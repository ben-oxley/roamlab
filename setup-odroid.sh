#To grab this scrip, you'll need git
#sudo apt install git -y
#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo apt install curl -y
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-armv7" -o /usr/local/bin/docker-compose
sudo sed -i 's/#DNSStubListener=yes/DNSStubListener=no/' /etc/systemd/resolved.conf
sudo sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
sudo apt install fancontrol -y
sudo systemctl restart systemd-resolved
#then reboot
