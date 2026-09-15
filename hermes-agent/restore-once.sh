#!/bin/sh
set -eu

marker=/opt/data/.umbrel-restore-complete
restore_dir=/restore

[ -e "$marker" ] && exit 0

set -- "$restore_dir"/*.zip
if [ ! -f "${1:-}" ]; then
  echo "[umbrel] No Hermes backup supplied; starting a fresh setup." >&2
  exit 0
fi

if [ "$#" -ne 1 ]; then
  echo "[umbrel] Put exactly one Hermes .zip backup in the app's restore folder." >&2
  exit 1
fi

echo "[umbrel] Restoring Hermes backup: $1" >&2
/command/s6-setuidgid hermes /opt/hermes/.venv/bin/hermes import "$1" --force
touch "$marker"
