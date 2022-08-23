sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U 

