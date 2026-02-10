#!/usr/bin/env bash
set -euo pipefail

targets=("$@")
if [ "${#targets[@]}" -eq 0 ]; then
  targets=("src")
fi

python -m autopep8 --in-place --recursive --max-line-length 79 "${targets[@]}"
