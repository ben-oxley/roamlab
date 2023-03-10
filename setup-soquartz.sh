sudo apt update
sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
mkdir /data
sudo mount -o discard /dev/nvme0n1 /data

#Install docker
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
sudo curl -L "https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-armv7" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Prep apparmor
sudo apt-get purge apparmor apparmor-profiles apparmor-utils
sudo apt-get install apparmor-utils apparmor-profiles apparmor-profiles-extra vim-addon-manager

#Install ceph following guide here: https://docs.ceph.com/en/quincy/cephadm/install/#cephadm-deploying-new-cluster
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
./cephadm add-repo --release quincy
sudo apt update
sudo apt install -y cephadm
ipaddr=$(ip a s eth0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
cephadm bootstrap --mon-ip $ipaddr
