sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y
sudo apt-get autoclean -y
python -m pip install -U pip
