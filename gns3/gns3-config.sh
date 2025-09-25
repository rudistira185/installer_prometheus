#!/bin/bash

#download ubuntu
sudo add-apt-repository ppa:gns3/ppa
sudo apt update                                
sudo apt install gns3-gui gns3-server

#permision
sudo usermod -aG ubridge,libvirt,kvm,wireshark,docker $(whoami)
