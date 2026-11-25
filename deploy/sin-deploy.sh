#!/usr/bin/env bash
# Pull the course repository and republish the site when main has changed.
# Run by sin-deploy.service (systemd timer, every minute) as user 'deploy'.
#
# Settings (override in /etc/default/sin-deploy):
#   REPO_DIR  clone of the repository        (default /srv/sti2d-sin)
#   WEB_ROOT  folder served by Nginx         (default /var/www/sin)
#   VENV      Python venv with MkDocs        (default /opt/sin-venv)
#   BRANCH    branch to publish              (default main)
#   FORCE=1   rebuild even without new commit
set -euo pipefail

REPO_DIR="${REPO_DIR:-/srv/sti2d-sin}"
WEB_ROOT="${WEB_ROOT:-/var/www/sin}"
VENV="${VENV:-/opt/sin-venv}"
BRANCH="${BRANCH:-main}"
FORCE="${FORCE:-0}"
export NO_MKDOCS_2_WARNING=1

log()
{
    echo "[sin-deploy] $*"
}

cd "${REPO_DIR}"
git fetch --quiet origin "${BRANCH}"

# Last commit published successfully: a failed build is retried next run.
state_file="$(git rev-parse --git-dir)/sin-published"
published_rev="$(cat "${state_file}" 2>/dev/null || true)"
remote_rev="$(git rev-parse "origin/${BRANCH}")"
if [[ "${published_rev}" == "${remote_rev}" && "${FORCE}" != "1" ]]; then
    exit 0
fi

changed_files="$(git diff --name-only "${published_rev:-HEAD}" "${remote_rev}" 2>/dev/null || true)"
git reset --quiet --hard "origin/${BRANCH}"
log "building ${remote_rev:0:7}: $(git log -1 --format=%s)"

# Keep the build tools in step with the repository.
if [[ "${FORCE}" == "1" ]] || grep -qx "requirements.txt" <<< "${changed_files}"; then
    log "installing requirements"
    "${VENV}/bin/pip" install --quiet --upgrade -r requirements.txt
fi

# Build in a temporary folder: a failed build leaves the live site untouched.
build_dir="$(mktemp -d)"
trap 'rm -rf "${build_dir}"' EXIT
# No --quiet: it hides warnings from --strict, letting broken links through.
"${VENV}/bin/mkdocs" build --strict --site-dir "${build_dir}"

rsync -a --delete "${build_dir}/" "${WEB_ROOT}/"
echo "${remote_rev}" > "${state_file}"
log "site published to ${WEB_ROOT}"
