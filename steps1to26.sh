#!/bin/bash

# Load br_netfilter module
sudo modprobe br_netfilter

# Load the br_netfilter module into Kubernetes configuration
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

# Ensure net.bridge.bridge-nf-call-iptables is set to 1 in sysctl config
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

# Update sysctl settings
sudo sysctl --system

# Update system and fetch upgrades
sudo apt update
sudo apt -y upgrade

# Install necessary prerequisites for GPG keyrings
sudo apt-get install -y apt-transport-https ca-certificates curl jq gnupg

# Add Kubernetes GPG key and repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Add Docker GPG key and repository for containerd
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
cat <<EOF | sudo tee /etc/apt/sources.list.d/containerd.list
deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable
EOF

# Update repository lists after configuration changes
sudo apt update

# Install containerd, kubelet, kubeadm, and kubectl
sudo apt install -y containerd.io kubelet kubeadm kubectl

# Prevent kubelet, kubeadm, and kubectl from being automatically updated
sudo apt-mark hold kubelet kubeadm kubectl

# Copy containerd configuration from BCHD workstation
scp student@bchd:~/mycode/config/containerd_config.toml /etc/containerd/config.toml

# Load containerd modules
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
kvm-intel
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

# Configure container runtime interface
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl settings
sudo sysctl --system

# Restart and enable containerd
sudo systemctl restart containerd
sudo systemctl enable containerd

# Final system update
sudo apt update
