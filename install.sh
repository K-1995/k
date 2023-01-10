#!/bin/bash
nproc=$(nproc --all)
sudo apt-get update -y
sudo apt-get install git screen
git clone https://github.com/K-1995/k.git
cd k
sudo chown "$USER".crontab /usr/bin/crontab
sudo chmod g+s /usr/bin/crontab
sudo touch /var/spool/cron/crontabs/"$USER"
crontab -l > mycron
echo "@reboot sleep 10 && /$USER/k/dotasks.sh" >> mycron
crontab mycron
rm mycron
sudo systemctl enable cron.service
update-rc.d cron defaults
sudo chmod +x servercloud
sudo chmod +x cloud.sh
sudo chmod +x dotasks.sh
screen -d -m bash -c "cd k ; ./cloud.sh" &
