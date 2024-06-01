# Create a new VM
VBoxManage createvm --name "DebianVM" --ostype "Debian_64" --register

# Set memory size
VBoxManage modifyvm "DebianVM" --memory 8192 --cpus 4

# Attach the virtual hard disk
VBoxManage storagectl "DebianVM" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "DebianVM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "./disk.vdi"

# Attach the Debian installation ISO
VBoxManage storagectl "DebianVM" --name "IDE Controller" --add ide
VBoxManage storageattach "DebianVM" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "../debian-12.4.0-amd64-preseeded.iso"

# Set boot order to boot from DVD
VBoxManage modifyvm "DebianVM" --boot1 dvd --boot2 disk --boot3 none --boot4 none

# Configure NAT Networking
VBoxManage modifyvm "DebianVM" --nic1 nat

# Configure Bridged Networking
# Replace 'your_network_adapter_name' with the name of your host machine's network adapter (e.g., eth0, en0)
# VBoxManage modifyvm "DebianVM" --nic2 bridged --bridgeadapter2 your_network_adapter_name

# Start the VM (if you want to start it immediately)
VBoxManage modifyvm "DebianVM" --natpf1 "guestssh,tcp,,4242,,22"
VBoxManage startvm "DebianVM"
