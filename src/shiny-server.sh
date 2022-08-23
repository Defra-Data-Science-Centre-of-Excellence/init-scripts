SHINY_CONF='''
# Instruct Shiny Server to run applications as the user "shiny"
run_as shiny;

# Define a server that listens on port 3838
server {
  listen 3838 0.0.0.0;

  # Define a location at the base URL
  location / {

    # Host the directory of Shiny Apps stored in this directory
    site_dir /srv/shiny-server;

    # Log all Shiny output to files in this directory
    log_dir /var/log/shiny-server;

    # When a user visits the base URL rather than a particular application,
    # an index of the applications available in this directory will be shown.
    directory_index on;
  }

  sanitize_errors off;

  disable_protocols xdr-streaming xhr-streaming iframe-eventsource iframe-htmlfile;
}
'''


VERSION=$(wget -qO- https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION)
ARCH=$(dpkg --print-architecture)
wget --no-verbose \
  "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-$ARCH.deb" \
  -O shiny-server.deb

sudo gdebi -n shiny-server.deb
rm -f shiny-server.deb

echo $SHINY_CONF > /etc/shiny-server/shiny-server.conf
sudo sed -i "s/run_as shiny/run_as $USER/" /etc/shiny-server/shiny-server.conf
sudo sed -i "s/site_dir \/srv\/shiny-server/site_dir \/home\/$USER\/shiny/" /etc/shiny-server/shiny-server.conf
mkdir $HOME/shiny
cp -r /opt/shiny-server/samples/sample-apps/hello/ ~/shiny


sudo systemctl daemon-reload
sudo systemctl --now enable shiny-server
