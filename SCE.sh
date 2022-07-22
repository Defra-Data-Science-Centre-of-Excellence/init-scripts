#!/bin/bash
URL=https://raw.githubusercontent.com/aw-west-defra/init/main/src
wget -O - "$URL/update.sh" | bash
wget -O - "$URL/base_libs.sh" | bash
wget -O - "$URL/nginx-server.sh" | bash
wget -O - "$URL/rstudio-server.sh" | bash
wget -O - "$URL/shiny-server.sh" | bash
#wget -O - "$URL/jupyter-server.sh" | bash  # WIP
(sudo crontab -l | sed '/^#/d'; echo "@monthly wget -qO- $URL/update.sh | bash") | sort -u | sudo crontab -

echo "nginx is" $(systemctl is-active nginx)
echo "RStudio is" $(systemctl is-active rstudio-server)
echo "RShiny is" $(systemctl is-active shiny-server)
echo "Jupyter is" $(systemctl is-active jupyter-server)
printf "Cronjobs are: \n$(sudo crontab -l)\n"
