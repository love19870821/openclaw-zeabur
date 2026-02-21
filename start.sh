#!/usr/bin/env bash
set -e

# 確保 state 目錄存在
mkdir -p "${OPENCLAW_STATE_DIR:-/home/node/.openclaw}"

echo "Starting OpenClaw Gateway..."
echo "PORT=${PORT:-8080}"

exec openclaw gateway \
  --bind lan \
  --port "${PORT:-8080}" \
  --allow-unconfigured
