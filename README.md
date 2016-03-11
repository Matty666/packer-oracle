#Packer templates for Oracle Linux

[Packer](http://packer.io)

Download packer.io, tested with Packer version 0.8.6

## software
Download [Packer](http://packer.io) at http://packer.io, tested it with Packer 0.8.6

export PATH=~/packer_0.8.6_darwin_amd64:$PATH

## how to build a box

* packer build -only=virtualbox-iso oracle-linux-6.6-x86_64.json
* packer build -only=vmware-iso oracle-linux-6.6-x86_64.json
