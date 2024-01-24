
sudo apt install -y \
  gdebi-core \
  nginx \


sudo systemctl daemon-reload
sudo systemctl --now enable nginx
