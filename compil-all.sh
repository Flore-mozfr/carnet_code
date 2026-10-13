#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
shopt -s nullglob
books=(books/*.yaml books/*.yml)

if ((${#books[@]} == 0)); then
    echo "Aucun carnet YAML trouvé dans books/." >&2
    exit 1
fi

mkdir -p dist
for book in "${books[@]}"; do
    name="$(basename -- "${book%.*}")"
    echo "Génération de $book"
    songbook -v --steps tex,pdf,sbx,pdf "$book"
    test -s "$name.pdf"
    cp -- "$name.pdf" "dist/$name.pdf"
done
