#!/bin/bash
apt-get install -y -q socat ebtables ethtool
dpkg -i kubernetes-cni_0.5.1-00_amd64.deb
dpkg -i kubelet_1.8.7-00_amd64.deb
dpkg -i kubectl_1.8.7-00_amd64.deb
dpkg -i kubeadm_1.8.7-00_amd64.deb
systemctl enable kubelet
systemctl start kubelet
