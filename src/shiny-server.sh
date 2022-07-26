
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main

VERSION=$(wget -qO- https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION)
ARCH=$(dpkg --print-architecture)
wget --no-verbose \
  "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-$ARCH.deb" \
  -O shiny-server.deb

sudo gdebi -n shiny-server.deb
rm -f shiny-server.deb

sudo wget \
  $URL/rsc/shiny-server.conf \
  -O /etc/shiny-server/shiny-server.conf

sudo sed -i "s/run_as shiny/run_as $USER/" /etc/shiny-server/shiny-server.conf

sudo sed -i "s/site_dir \/srv\/shiny-server/site_dir \/home\/$USER\/shiny/" /etc/shiny-server/shiny-server.conf

mkdir $HOME/shiny

cp -r /opt/shiny-server/samples/sample-apps/hello/ ~/shiny


sudo systemctl daemon-reload
sudo systemctl --now enable shiny-server
