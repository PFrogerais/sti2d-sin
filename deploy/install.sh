#!/usr/bin/env bash
# One-time setup of automatic deployment on the Nginx container (Debian/Ubuntu).
# Run as root from a clone of the repository:  sudo deploy/install.sh
# Safe to run again (idempotent).
set -euo pipefail

readonly REPO_URL="${REPO_URL:-https://github.com/PFrogerais/sti2d-sin.git}"
readonly REPO_DIR="/srv/sti2d-sin"
readonly WEB_ROOT="/var/www/sin"
readonly VENV="/opt/sin-venv"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly HERE

[[ "${EUID}" -eq 0 ]] || { echo "error: run as root (sudo $0)" >&2; exit 1; }

echo ">>> Packages"
apt-get install -y --no-install-recommends git rsync python3-venv nginx > /dev/null

echo ">>> User 'deploy'"
id deploy > /dev/null 2>&1 || useradd --system --create-home --shell /usr/sbin/nologin deploy

echo ">>> Folders"
install -d -o deploy -g deploy "${WEB_ROOT}"
if [[ ! -d "${REPO_DIR}/.git" ]]; then
    install -d -o deploy -g deploy "${REPO_DIR}"
    sudo -u deploy git clone --quiet "${REPO_URL}" "${REPO_DIR}"
fi

echo ">>> Python venv ${VENV}"
if [[ ! -x "${VENV}/bin/python" ]]; then
    python3 -m venv "${VENV}"
fi
chown -R deploy:deploy "${VENV}"
sudo -u deploy "${VENV}/bin/pip" install --quiet --upgrade -r "${REPO_DIR}/requirements.txt"

echo ">>> systemd units"
install -m 0755 "${HERE}/sin-deploy.sh" /usr/local/bin/sin-deploy
install -m 0644 "${HERE}/sin-deploy.service" "${HERE}/sin-deploy.timer" /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now sin-deploy.timer

echo ">>> First publication"
sudo -u deploy env FORCE=1 /usr/local/bin/sin-deploy

if [[ ! -e /etc/nginx/sites-available/sin ]]; then
    echo ">>> Nginx site (edit server_name in /etc/nginx/sites-available/sin)"
    install -m 0644 "${HERE}/nginx-sin.conf" /etc/nginx/sites-available/sin
    ln -sf ../sites-available/sin /etc/nginx/sites-enabled/sin
    nginx -t && systemctl reload nginx
fi

echo ">>> Done. Follow deployments with: journalctl -u sin-deploy -f"
