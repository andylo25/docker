#!/bin/bash
setenforce 0
systemctl disable firewalld
systemctl stop firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
swapoff -a
cat >> /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness=0
EOF
sysctl -p /etc/sysctl.d/k8s.conf
yum install -y socat ebtables ethtool
rpm -ivh kubernetes-cni-0.5.1-0.x86_64.rpm kubelet-1.8.7-0.x86_64.rpm kubectl-1.8.7-0.x86_64.rpm kubeadm-1.8.7-0.x86_64.rpm
images=(kube-proxy-amd64:v1.8.7 \
pause-amd64:3.0 \
kubernetes-dashboard-amd64:1.8.1)
for imageName in ${images[@]} ; do
  docker pull andylo25/$imageName
  docker tag andylo25/$imageName gcr.io/google_containers/$imageName
  docker rmi andylo25/$imageName
done
kubeadm join --token 34fb5a.87ec418b32857c65 192.168.129.133:6443 --discovery-token-ca-cert-hash sha256:da4765f5721db7ed2130c265a71e849005f0334aeb821cd05ec9c9020e036919
