FROM node:22-bookworm-slim

# 基本工具（讓你能用 ps/ss/curl 檢查）
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl procps iproute2 net-tools tini \
  && rm -rf /var/lib/apt/lists/*

# 安裝 OpenClaw（固定 latest）
RUN npm i -g openclaw@latest --unsafe-perm

# 建議用 node 使用者跑（比較符合雲端習慣）
USER node
WORKDIR /app

# 可選：把狀態目錄指定到固定位置（也方便你之後掛 volume）
ENV OPENCLAW_STATE_DIR=/home/node/.openclaw

COPY --chown=node:node start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Zeabur 會給 PORT；我們不在這裡寫死
EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["/app/start.sh"]
