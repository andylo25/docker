#!/bin/bash
ufw disable
swapoff -a
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
images=(kube-scheduler-amd64:v1.8.7 \
kube-apiserver-amd64:v1.8.7 \
etcd-amd64:3.0.17 \
pause-amd64:3.0 \
k8s-dns-sidecar-amd64:1.14.5 \
k8s-dns-kube-dns-amd64:1.14.5 \
k8s-dns-dnsmasq-nanny-amd64:1.14.5 \
kubernetes-dashboard-amd64:v1.8.1)
for imageName in ${images[@]} ; do
  docker pull andylo25/$imageName
  docker tag andylo25/$imageName gcr.io/google_containers/$imageName
  docker rmi andylo25/$imageName
done
