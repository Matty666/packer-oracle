#Packer templates for Oracle Linux

With this you make your own OEL 6.6, 6.7 or 7.2 image/machine which you can use with vagrant ( it can work with Virtualbox and Vmware)
but also you can generate the same image/machine for Oracle public cloud (OPC)

##Contributions
Big thanks to Lucas de Souza Reis Gomes for all the help on OEL7 on OPC

##OPC
For OPC you should use Qemu emulator and this will make
- a clean image ( no guest or vmtools)
- add the opc user
- sudo rights for opc
- key inject script
- tar.gz as export
- delete password & disable root

Follow the Oracle Cloud docs for uploading the image and to associate it. After that follow the normal flow


For now qemu is a bit slow ( can take a few hours ) because I cannot use the kvm accelerator on my mac. It only works fast on linux host or vm)

##Software
Download [Packer](http://packer.io) (tested with Packer version 0.8.6)

##How to build a box, image
- Download OEL6.6 from edelivery
- Update the iso_location path variable in the oracle-linux-6.6-x86_64.json
- extract packer in your home folder.
- export PATH=~/packer_0.8.6_darwin_amd64:$PATH

For OEL6.6 Choose one
- packer build -only=virtualbox-iso oracle-linux-6.6-x86_64.json
	- This also requires virtualbox
- packer build -only=vmware-iso oracle-linux-6.6-x86_64.json
	- This also requires vmware fusion or workstation
- packer build -only=qemu oracle-linux-6.6-x86_64.json
	- Requires Qemu for linux or for mac

For OEL6.7 with UEK4 Choose one
- packer build -only=virtualbox-iso oracle-linux-6.7-x86_64.json
- packer build -only=vmware-iso oracle-linux-6.7-x86_64.json

For OEL6.7 with UEK3 for the OPC (UEK4 does not work)
- packer build -only=qemu oracle-linux-6.7-x86_64.json

For OEL7.2 with UEK4 Choose one
- packer build -only=virtualbox-iso oracle-linux-7.2-x86_64.json
- packer build -only=vmware-iso oracle-linux-7.2-x86_64.json

For OEL7.2 for OPC
- packer build -only=qemu oracle-linux-7.2-x86_64.json

##Qemu installation for mac osx
- brew install qemu --with-sdl

##Qemu packer on a linux VM

###Init
- vagrant init phusion/ubuntu-14.04-amd64
- enable nested x86 support ( also in the bios of your computer )
	- in vmware vb.vmx["vhv.enable"] = "TRUE"
	- Virtualbox does not pass on vmx but you can try to set this in VBOX 5 vb.customize ["modifyvm", :id, "--hwvirtex", "on"] and vb.customize ['modifyvm', :id, '--paravirtprovider', 'kvm']
- vagrant up

###Install

- Download packer and add it to the root/vagrant folder
- Download OEL ISO and add it to the root/vagrant folder

For ubuntu
```bash
vagrant ssh
sudo apt-get install qemu-kvm qemu virt-manager virt-viewer libvirt-bin
egrep -c '(vmx|svm)' /proc/cpuinfo
kvm-ok
cd /vagrant
sudo apt-get install git
git clone https://github.com/biemond/packer-oracle.git
sudo apt-get install unzip
unzip packer_0.10.0_linux_amd64.zip
```

For OEL 7
```bash
vagrant ssh
sudo -i
yum -y install qemu-kvm libvirt virt-install bridge-utils
egrep -c '(vmx|svm)' /proc/cpuinfo
lsmod | grep kvm
```

###Build
Update OEL 6 qemu config
- update iso_location to /vagrant
- headless true instead of false
- accelerator kvm instead of none
- update ["-machine", "type=pc"] -> ["-machine", "type=pc,accel=kvm"]
- For RHEL7 add "qemu_binary" : "/usr/libexec/qemu-kvm" to the Qemu packer definition

```bash
cd packer-oracle/
sudo /vagrant/packer build -only=qemu oracle-linux-6.6-x86_64.json
```

- move build output file to /vagrant and you can use it