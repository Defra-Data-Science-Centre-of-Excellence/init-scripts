
sudo apt install -y \
  r-base r-base-dev \
  pandoc pandoc-citeproc

echo deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/ | sudo tee --append /etc/apt/sources.list

gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -

wget \
  https://www.rstudio.org/download/latest/stable/server/bionic/rstudio-server-latest-amd64.deb \
  -O rstudio-server-latest-amd64.deb

sudo gdebi --non-interactive rstudio-server-latest-amd64.deb

rm rstudio-server-latest-amd64.deb

sudo wget \
  https://raw.githubusercontent.com/jtsmith275/RStudioShiny-nginx/master/default \
  -O /etc/nginx/sites-enabled/default


sudo systemctl daemon-reload
sudo systemctl --now enable rstudio-server
