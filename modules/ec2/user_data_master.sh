#!/bin/bash
# Update system packages
yum update -y

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Disable SWAP (required for Kubernetes)
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

# Install Docker
yum install -y docker
systemctl enable docker
systemctl start docker

# Configure sysctl for Kubernetes networking
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

# Add Kubernetes repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
EOF

# Install kubelet, kubeadm, and kubectl
yum install -y kubelet kubeadm kubectl
systemctl enable --now kubelet

# Initialize Kubernetes
kubeadm init --pod-network-cidr=10.244.0.0/16  --ignore-preflight-errors=Mem > /tmp/kubeadm-init.log 2>&1

# Configure kubectl for the admin user
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Allow scheduling on control plane (optional, for single-node clusters)
kubectl taint nodes --all node-role.kubernetes.io/control-plane- || true

# Install Flannel CNI (Networking)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
