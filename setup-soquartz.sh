sudo apt update
sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
mkdir /data
sudo mount -o discard /dev/nvme0n1 /data

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
