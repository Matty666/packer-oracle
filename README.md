#Packer templates for Oracle Linux

With this you make your own OEL image/machine which you can use with vagrant ( it can work with Virtualbox and Vmware)
but also you can generate the same image/machine for the OPC Oracle public cloud.

##OPC
For OPC you should use Qemu emulator and this will make
- a clean image ( no guest or vmtools)
- add the opc user
- sudo rights for opc
- key inject script
- tar.gz as export

Follow the Oracle Cloud docs for uploading the image and to associate it. After that follow the normal flow


For now qemu is a bit slow ( can take a few hours ) because I cannot use the kvm accelerator on my mac ( for now it only works on linux and not inside a vm)

##Software
Download [Packer](http://packer.io) (tested with Packer version 0.8.6)

##How to build a box, image
- Download OEL6.6 from edelivery
- Update the iso_location path variable in the oracle-linux-6.6-x86_64.json
- extract packer in your home folder.
- export PATH=~/packer_0.8.6_darwin_amd64:$PATH

Choose one
- packer build -only=virtualbox-iso oracle-linux-6.6-x86_64.json
	- This also requires virtualbox
- packer build -only=vmware-iso oracle-linux-6.6-x86_64.json
	- This also requires vmware fusion or workstation
- packer build -only=qemu oracle-linux-6.6-x86_64.json
	- Requires Qemu for linux or for mac

##Qemu installation for mac osx
- brew install qemu --with-sdl