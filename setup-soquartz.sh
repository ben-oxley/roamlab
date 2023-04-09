#!/usr/bin/env bash
sudo apt update
sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
mkdir /data
sudo mount -o discard /dev/nvme0n1 /data

#Install influx
# influxdata-archive_compat.key GPG fingerprint:
#     9D53 9D90 D332 8DC7 D6C8 D3B9 D8FF 8E1F 7DF8 B07E
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo apt-get update && sudo apt-get install -y influxdb2
sudo service influxdb start
sudo apt install -y telegraf
# configure influx and telegraf config at /etc/telegraf/telegraf.conf

#Install MQTT
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl start mosquitto

#Install mDNS
sudo apt install -y avahi-daemon

#Install podman
sudo apt-get -y install podman

#Install ceph following guide here: https://docs.ceph.com/en/quincy/cephadm/install/#cephadm-deploying-new-cluster
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
chmod +x cephadm
sudo apt install -y cephadm catatonit
ipaddr=$(ip a s eth0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
cephadm bootstrap --mon-ip $ipaddr
cephadm shell -- ceph orch apply osd --all-available-devices --single-host-defaults
cephadm shell -- ceph mgr module enable dashboard
cephadm shell -- ceph dashboard create-self-signed-cert
cephadm shell <<EOF
date +%s | sha256sum | base64 | head -c 32 > password.txt
ceph dashboard ac-user-create ben -i password.txt administrator
cat password.txt
EOF
