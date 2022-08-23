
JUPYTER_SERVICE="""[Unit]
Description=JupyterHub
After=syslog.target network.target

[Service]
User=root
Environment="PATH=/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/jupyterhub/bin"
ExecStart=/opt/jupyterhub/bin/jupyterhub -f /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py

[Install]
WantedBy=multi-user.target
"""
sudo apt-get install -y \
  python3-venv \
  nodejs \
  npm
sudo python3 -m venv \
  /opt/jupyterhub/
sudo /opt/jupyterhub/bin/python3 -m pip install \
  wheel \
  jupyterhub \
  jupyterlab \
  ipywidgets
sudo npm install -g \
  configurable-http-proxy

sudo mkdir -p /opt/jupyterhub/etc/jupyterhub/
sudo /opt/jupyterhub/bin/jupyterhub --generate-config
sudo cp jupyterhub_config.py /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
rm jupyterhub_config.py
sudo sed -i "s|# c.Spawner.default_url = ''|c.Spawner.default_url = '/lab'|" /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
sudo sed -i "s|# c.JupyterHub.bind_url = 'http://:8000'|c.JupyterHub.bind_url = 'http://:8000/jupyter'|" /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py

echo $JUPYTER_SERVICE > /etc/systemd/system/jupyter-server.service


sudo systemctl daemon-reload
sudo systemctl --now enable jupyter-server
