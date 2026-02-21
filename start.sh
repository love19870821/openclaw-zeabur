#!/usr/bin/env sh
set -eu

echo "[boot] whoami=$(whoami) pwd=$(pwd)"
echo "[boot] PORT=${PORT:-<empty>}"
echo "[boot] node=$(node -v 2>/dev/null || true) npm=$(npm -v 2>/dev/null || true)"
echo "[boot] openclaw=$(openclaw --version 2>/dev/null || true)"

# 確保狀態目錄存在（避免 credentials/state 缺失類問題）
STATE_DIR="${OPENCLAW_STATE_DIR:-/home/node/.openclaw}"
mkdir -p "$STATE_DIR" "$STATE_DIR/credentials" "$STATE_DIR/workspace"
echo "[boot] state_dir=$STATE_DIR"

# 這裡用 $PORT（平台給什麼就聽什麼）
P="${PORT:-8080}"
echo "[boot] starting gateway on 0.0.0.0:${P}"

exec openclaw gateway --bind lan --port "$P" --allow-unconfigured
