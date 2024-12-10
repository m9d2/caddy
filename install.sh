#!/bin/bash

echo "Prepare to create a directory"
sudo mkdir -p /data/html
sudo mkdir -p /data/share

# 更新并安装必要的软件包
echo "Installing prerequisites..."
sudo apt update
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

# 导入 Caddy 的 GPG 密钥
echo "Adding Caddy GPG key..."
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

# 添加 Caddy 的 APT 源
echo "Adding Caddy repository..."
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

# 更新 APT 源并安装 Caddy
echo "Updating package list and installing Caddy..."
sudo apt update
sudo apt install -y caddy

# 从 GitHub 仓库下载 Caddyfile 配置文件
# 请替换 <github_repo_url> 为 GitHub 仓库的 URL，并确保文件路径正确
CADDYFILE_URL="https://raw.githubusercontent.com/m9d2/caddy/main/Caddyfile"
echo "Downloading Caddyfile from GitHub..."
curl -o /etc/caddy/Caddyfile "$CADDYFILE_URL"

# 启动并启用 Caddy 服务
echo "Starting Caddy with the downloaded Caddyfile..."
sudo systemctl restart caddy
sudo systemctl enable caddy

echo "Caddy installation and setup complete!"

echo "Install x-ui"
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
