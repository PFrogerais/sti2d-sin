#!/usr/bin/env bash
# Convert every lesson of docs/ into a Canoprof archive, mirroring the tree.
#
# Usage: tools/build_scar.sh [DOCS_DIR] [OUT_DIR] [FILTER]
#   FILTER  optional path fragment, e.g. "02_cour_info" to convert one theme
#
# Only pages with a front matter (--- title: ... ---) are lessons; index
# pages generated from Canoprof collections are skipped.
set -euo pipefail

readonly DOCS_DIR="${1:-docs}"
readonly OUT_DIR="${2:-build/scar}"
readonly FILTER="${3:-}"

command -v md2canoprof > /dev/null || { echo "error: md2canoprof not installed (pip install -r requirements.txt)" >&2; exit 1; }

count=0
while IFS= read -r -d '' md; do
    [[ -z "${FILTER}" || "${md}" == *"${FILTER}"* ]] || continue
    [[ "$(head -c 3 "${md}")" == "---" ]] || continue
    [[ "$(basename "${md}")" == "index.md" ]] && continue

    rel="${md#"${DOCS_DIR}"/}"
    out="${OUT_DIR}/${rel%.md}.scar"
    mkdir -p "$(dirname "${out}")"
    md2canoprof "${md}" -o "${out}" > /dev/null
    count=$((count + 1))
done < <(find "${DOCS_DIR}" -name '*.md' -print0 | sort -z)

echo "${count} archive(s) written to ${OUT_DIR}"
