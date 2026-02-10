#!/bin/bash
# Single-node Ray initialization script (no multi-node mode)
# Usage:
#   bash init_ray.sh [PORT]

set -e

PORT=${1:-6379}
NUM_CPUS=${NUM_CPUS:-""}
NUM_GPUS=${NUM_GPUS:-""}
OBJECT_STORE_MEMORY=${OBJECT_STORE_MEMORY:-""}

RAY_OPTS=""
if [ -n "${NUM_CPUS}" ]; then
    RAY_OPTS="${RAY_OPTS} --num-cpus=${NUM_CPUS}"
fi
if [ -n "${NUM_GPUS}" ]; then
    RAY_OPTS="${RAY_OPTS} --num-gpus=${NUM_GPUS}"
fi
if [ -n "${OBJECT_STORE_MEMORY}" ]; then
    RAY_OPTS="${RAY_OPTS} --object-store-memory=${OBJECT_STORE_MEMORY}"
fi

echo "[INFO] Stopping existing local Ray runtime..."
ray stop --force 2>/dev/null || true
sleep 1

echo "[INFO] Starting local Ray head on 127.0.0.1:${PORT}..."
ray start --head --node-ip-address=127.0.0.1 --port="${PORT}" ${RAY_OPTS}
sleep 2

echo "[INFO] Ray status:"
ray status
