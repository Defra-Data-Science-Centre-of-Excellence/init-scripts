
VERSION=$(wget -qO- https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION)

wget --no-verbose \
  "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" \
  -O ss-latest.deb

sudo gdebi -n ss-latest.deb
rm -f ss-latest.deb

sudo wget \
  https://raw.githubusercontent.com/Jtsmith275/RStudioShiny-nginx/master/shiny-server.conf \
  -O /etc/shiny-server/shiny-server.conf

sudo sed -i "s/run_as shiny/run_as $USER/" /etc/shiny-server/shiny-server.conf

sudo sed -i "s/site_dir \/srv\/shiny-server/site_dir \/home\/$USER\/shiny/" /etc/shiny-server/shiny-server.conf

mkdir $HOME/shiny

cp -r /opt/shiny-server/samples/sample-apps/hello/ ~/shiny


sudo systemctl daemon-reload
sudo systemctl --now enable shiny-server
