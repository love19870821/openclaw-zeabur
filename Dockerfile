FROM node:20-slim

# ✅ 安裝 git（解決 npm spawn git 失敗）
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# ✅ 安裝最新 openclaw
RUN npm install -g openclaw@latest --unsafe-perm

# 建立非 root 使用者（穩定營運）
RUN useradd -m -u 1000 nodeuser
USER nodeuser
ENV HOME=/home/nodeuser

# OpenClaw 設定
ENV OPENCLAW_STATE_DIR=/home/nodeuser/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/home/nodeuser/.openclaw/workspace
ENV OPENCLAW_GATEWAY_PORT=18789

EXPOSE 18789

CMD ["openclaw", "gateway"]
