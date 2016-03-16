#Packer templates for Oracle Linux

With this you make your own OEL image/machine which you can use with vagrant ( it can work with Virtualbox and Vmware)
but also you can generate the same image/machine for the OPC Oracle public cloud.

##OPC
For OPC you should use Qemu emulator and this will make
- a clean image ( no guest or vmtools)
- add the opc user
- key inject script
- tar.gz as export

Follow the Oracle Cloud docs for uploading the image and to associate it. After that follow the normal flow


For now qemu is a bit slow ( can take a few hours ) because I cannot use the kvm accelerator on my mac ( for now it only works on linux and not inside a vm)

##software
Download [Packer](http://packer.io) (tested with Packer version 0.8.6)

export PATH=~/packer_0.8.6_darwin_amd64:$PATH

##How to build a box

* packer build -only=virtualbox-iso oracle-linux-6.6-x86_64.json
* packer build -only=vmware-iso oracle-linux-6.6-x86_64.json
* packer build -only=qemu oracle-linux-6.6-x86_64.json


##Qemu on mac osx
- brew install qemu --with-sdl
