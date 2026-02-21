FROM node:22-slim  
LABEL "language"="nodejs"  
WORKDIR /app  
# 安裝必要的系統依賴  
RUN apt-get update && apt-get install -y \  
    git \  
    curl \  
    && rm -rf /var/lib/apt/lists/*  
# 複製應用文件  
COPY . .  
# 安裝依賴  
RUN npm install -g openclaw@latest --unsafe-perm  
# 使用不同的 UID 避免衝突  
RUN useradd -m -u 1001 nodeuser || true  
# 設置工作目錄權限  
RUN chown -R 1001:1001 /app  
USER 1001  
EXPOSE 8080  
# 啟動 OpenClaw Gateway 服務  
CMD ["sh", "-lc", "openclaw gateway --bind custom --host 0.0.0.0 --port $PORT"]  
