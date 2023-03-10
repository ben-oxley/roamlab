sudo apt update
sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
mkdir /data
sudo mount -o discard /dev/nvme0n1 /data

#Install podman
sudo apt-get -y install podman

#Install ceph following guide here: https://docs.ceph.com/en/quincy/cephadm/install/#cephadm-deploying-new-cluster
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
./cephadm add-repo --release quincy
sudo apt update
sudo apt install -y cephadm
ipaddr=$(ip a s eth0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
cephadm bootstrap --mon-ip $ipaddr
