sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
mkdir /data
sudo mount -o discard /dev/nvme0n1 /data
