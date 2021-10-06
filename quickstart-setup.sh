echo "Confirming creation of registry:2 container."
[ ! "$(docker ps -a | grep registry)" ] && sudo docker run -d -p 2345:5000 registry:2

echo "Adding bchd.registry to localhost."
sudo sed -i 's/127.0.0.1 localhost bchd.registry/127.0.0.1 localhost/' /etc/hosts
sudo sed -i 's/127.0.0.1 localhost/127.0.0.1 localhost bchd.registry/' /etc/hosts

echo "Updating sites enabled."
cat > /etc/nginx/sites-enabled/reg << EOF
server {
    listen bchd.registry;
    client_max_body_size 100M;
    
    location / {
        proxy_pass http://127.0.0.1:2345;
        }
    }
EOF

echo "Reloading nginx."
sudo nginx -s reload

echo "Confirming if cluster is present:"
if ! command -v kubectl get pods &> /dev/null
then
	echo "Initiating cluster."
	ansible-playbook -i ~/git/kubernetes-the-alta3-way/hosts.yml ~/git/kubernetes-the-alta3-way/main.yml
fi

echo "Adding tab completion for K8s objects."
echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc

echo "Bypassing Docker's throttle limit."
cat > /home/student/containerd_config.toml  << EOF
version = 2

[plugins]
  [plugins."io.containerd.grpc.v1.cri"]
    [plugins."io.containerd.grpc.v1.cri".registry]
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."bchd.registry"]
          endpoint = ["http://bchd:2345"]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
          endpoint = ["https://registry.alta3.com"]
      [plugins."io.containerd.grpc.v1.cri".registry.configs."bchd.registry".tls]
        insecure_skip_verify = true
EOF

echo "Creating additional playbook."
cat > /home/student/containerd_update.yaml  << EOF
- name: Containerd Update
  hosts: all
  tasks:
  - name: copy the file over
    copy:
      src: "containerd_config.toml"
      dest: "/etc/containerd/config.toml"
    become: True
    when: inventory_hostname != 'localhost'

  - name: restart containerd
    systemd:
      name: containerd
      state: restarted
    become: True
    when: inventory_hostname != 'localhost'

  - name: add bchd.registry pointer
    lineinfile:
      path: /etc/hosts
      line: "{{ hostvars['localhost']['ansible_default_ipv4']['address']}} bchd.registry"
    become: True

- name: push base alta3-webby image
  hosts: bchd
  tasks:
  - name: push base webby image
    get_url:
      url: https://static.alta3.com/courses/k8s/888-sam-webby.tar
      dest: /home/student/888-sam-webby.tar

  - command: docker image load -i 888-sam-webby.tar
    become: True

  - command: docker tag reg.alta3.com/888-sam-webby bchd.registry/alta3-webby
    become: True

  - command: docker push bchd.registry/alta3-webby
    become: True
EOF

echo "Creating playbook inventory file."
cat > /home/student/node-hosts.txt  << EOF
[nodes]
node-1
node-2
node-3

[bchd]
localhost ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
EOF

echo "Executing playbook."
ansible-playbook -i /home/student/node-hosts.txt /home/student/containerd_update.yaml

echo "Creating test pod manifest."
cat > /home/student/my_first_pod.yaml  << EOF
apiVersion: v1
kind: Pod
metadata:
  name: myfirstpod
spec:
  containers:
  - name: webster
    image: bchd.registry/alta3-webby
EOF

echo "Creating test pod."
kubectl apply -f /home/student/my_first_pod.yaml

echo "Displaying pods. Press ctrl c to return to command line."
kubectl get pods -w
