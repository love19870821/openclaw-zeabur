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

# 使用現有用戶而不是創建新用戶，或使用不同的 UID
RUN useradd -m -u 1001 nodeuser || true

# 設置工作目錄權限
RUN chown -R 1001:1001 /app

USER 1001

EXPOSE 8080

CMD ["openclaw"]
