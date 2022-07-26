#!/bin/bash
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main
wget -O - $URL/src/update.sh | bash
wget -O - $URL/src/base_libs.sh | bash
wget -O - $URL/src/nginx-server.sh | bash
wget -O - $URL/src/rstudio-server.sh | bash
wget -O - $URL/src/shiny-server.sh | bash
#wget -O - $URL/src/jupyter-server.sh | bash  # WIP
(sudo crontab -l | sed '/^#/d'; echo "@monthly wget -qO- $URL/src/update.sh | bash") | sort -u | sudo crontab -

echo "nginx is" $(systemctl is-active nginx)
echo "RStudio is" $(systemctl is-active rstudio-server)
echo "RShiny is" $(systemctl is-active shiny-server)
echo "Jupyter is" $(systemctl is-active jupyter-server)
printf "Cronjobs are: \n$(sudo crontab -l)\n"
