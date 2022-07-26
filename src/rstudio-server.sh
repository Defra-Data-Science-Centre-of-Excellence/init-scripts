
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main

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

sudo wget \
  $URL/rsc/nginx_default \
  -O /etc/nginx/sites-enabled/default


sudo systemctl daemon-reload
sudo systemctl --now enable rstudio-server
