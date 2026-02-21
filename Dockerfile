FROM node:20-slim

# 這行決定版本：latest = 永遠最新；建議日後改成固定版本避免被上游更新炸到
RUN npm install -g openclaw@latest --unsafe-perm

# 建立非 root 使用者（長期營運更穩）
RUN useradd -m -u 1000 nodeuser
USER nodeuser
ENV HOME=/home/nodeuser

# OpenClaw 狀態路徑
ENV OPENCLAW_STATE_DIR=/home/nodeuser/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/home/nodeuser/.openclaw/workspace

# Zeabur 通常用 PORT 注入，你也可以用 OPENCLAW_GATEWAY_PORT
ENV OPENCLAW_GATEWAY_PORT=18789

EXPOSE 18789

CMD ["openclaw", "gateway"]
