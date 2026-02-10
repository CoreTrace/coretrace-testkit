#!/usr/bin/env bash
set -euo pipefail

targets=("$@")
if [ "${#targets[@]}" -eq 0 ]; then
  targets=("src")
fi

failed=0

python -m autopep8 --diff --exit-code --recursive --max-line-length 79 \
  "${targets[@]}" || failed=1
python -m flake8 "${targets[@]}" || failed=1

if [ "${failed}" -ne 0 ]; then
  echo "Formatting check failed. Run script/format.sh to fix."
  exit 1
fi

echo "Formatting is clean."
