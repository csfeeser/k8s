# Creating a Single Node Cluster with Kubeadm!

In this guide, we'll walk you through setting up a one-node Kubernetes cluster using `kubeadm`. A one-node setup may not mimic a production environment, but it's an excellent starting point for those who are new to Kubernetes or looking to run small-scale tests. We'll cover all the necessary steps, from installing prerequisites to initializing the cluster, ensuring you have a sandbox where you can freely experiment and learn without worrying about the overhead of a multi-node setup.

## Installing the Cluster
Before  installing the Cluster, get yourself a virtual machine (VM). It doesn't have to be super beefy, 2GB RAM and 2 CPU is more than enough. In our labs, we used `Ubuntu 22.04.3 LTS`.

> Also, make sure that you have sudo privileges if you are using the VM as a guest operator.

The process that I will walk you through here will allow you to stand up a cluster using kubeadm using only a single VM.

Kubernetes requires the installation of several packages and their dependencies, which will require you to use root privileges. Therefore, because nobody likes typing sudo repetitively, just become the root user.

```
sudo -i
```

Now create a bash script named `kubernetes_setup.sh` to run the following commands:

```bash
#!/bin/bash
# common.sh
# copy this script and run in all master and worker nodes
#i1) Switch to root user [ sudo -i]

#2) Disable swap & add kernel settings

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


#3) Add  kernel settings & Enable IP tables(CNI Prerequisites)

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

#4) Install containerd run time

#To install containerd, first install its dependencies.

apt-get update -y
apt-get install ca-certificates curl gnupg lsb-release -y

#Note: We are not installing Docker Here.Since containerd.io package is part of docker apt repositories hence we added docker repository & it's key to download and install containerd.
# Add Docker’s official GPG key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#Use follwing command to set up the repository:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install containerd

apt-get update -y
apt-get install containerd.io -y

# Generate default configuration file for containerd

#Note: Containerd uses a configuration file located in /etc/containerd/config.toml for specifying daemon level options.
#The default configuration can be generated via below command.

containerd config default > /etc/containerd/config.toml

# Run following command to update configure cgroup as systemd for contianerd.

sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service

systemctl restart containerd
systemctl enable containerd

#5) Installing kubeadm, kubelet and kubectl

# Update the apt package index and install packages needed to use the Kubernetes apt repository:

apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key:

curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

# Add the Kubernetes apt repository:

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

apt-get update
apt-get install -y kubelet kubeadm kubectl

# apt-mark hold will prevent the package from being automatically upgraded or removed.

apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet service

systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service
```

Now run your script!

```
sh kubernetes_setup.sh
```

This will set up Kubernetes and its dependencies. After it finishes, initialize your controller node:

```
kubeadm init
```

## Setting up Kubeconfig

You now need to make it possible for `kubectl` to reach your cluster by setting up a kubeconfig file. Do the following steps:

```bash
#exit root as normal user
exit
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#to verify, if kubectl is working or not, run the following command.
kubectl get pod -A
```

## Deploy a Network Plugin

Without a Container Network Interface (CNI) you will not be able to create pods. However, you can't create any pods at the moment because your node is tainted! Remove it.

```
kubectl taint node --all "node-role.kubernetes.io/control-plane-"
```

You may now install your Network Plugin. For this cluster we will use Weave!

```bash
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
#verify if weave is deployed successfully
```

You may now want to check that all your Pods are in a running state.

```bash
kubectl get pods -A
```

There you have it, a fully functioning one-node Kubernetes Cluster that is perfect for a learning environment!
