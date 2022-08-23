sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y
pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}
