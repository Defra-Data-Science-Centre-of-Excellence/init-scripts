# https://docs.rstudio.com/resources/install-quarto/

sudo curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
sudo apt-get install gdebi-core
sudo gdebi quarto-linux-amd64.deb
/usr/local/bin/quarto check
