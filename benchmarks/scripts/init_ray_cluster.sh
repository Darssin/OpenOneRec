#!/bin/bash
# Compatibility wrapper: benchmark now runs in single-node mode only.
# Usage:
#   bash init_ray_cluster.sh [PORT]

set -e

PORT=${1:-6379}
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

echo "[INFO] Multi-node mode has been disabled for this benchmark."
echo "[INFO] Starting single-node local Ray runtime instead."
bash "${SCRIPT_DIR}/init_ray.sh" "${PORT}"
