#!/bin/bash
NGINX_DEFAULT='''
map $http_upgrade $connection_upgrade {   
   default upgrade;
   ''	close;
 }
server {
	listen 80 default_server;
	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;
	server_name _;
	location / {
		try_files $uri $uri/ =404;
	}
  location /rstudio/ {
    rewrite ^/rstudio/(.*)$ /$1 break;
    proxy_pass http://127.0.0.1:8787;
    proxy_redirect http://127.0.0.1:8787/ $scheme://$host/rstudio/;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
    client_max_body_size 0;
    proxy_read_timeout 20d;
  }
  location /shiny/ {
    rewrite ^/shiny/(.*)$ /$1 break;
    proxy_pass http://127.0.0.1:3838;
    proxy_redirect http://127.0.0.1:3838/ $scheme://$http_host/shiny;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
    proxy_read_timeout 20d;
    proxy_buffering off;
  }
	location /jupyter/ {
    proxy_pass http://127.0.0.1:8000;
    proxy_redirect   off;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    # websocket headers
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
	}
}
'''


sudo apt install -y \
  r-base r-base-dev \
  pandoc pandoc-citeproc

echo deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/ | sudo tee --append /etc/apt/sources.list

KEY=E298A3A825C0D65DFD57CBB651716619E084DAB9
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $KEY
gpg -a --export $KEY | sudo apt-key add -

ARCH=$(dpkg --print-architecture)
wget \
  https://www.rstudio.org/download/latest/stable/server/bionic/rstudio-server-latest-$ARCH.deb \
  -O rstudio-server.deb
sudo gdebi --non-interactive rstudio-server.deb
rm rstudio-server.deb
echo $NGINX_DEFAULT > /etc/nginx/sites-enabled/default


sudo systemctl daemon-reload
sudo systemctl --now enable rstudio-server
