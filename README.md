# minikube

## 1. minikube 설치

```text
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

sudo minikube version
```

## 2. docker 설치

```text
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker version

sudo systemctl enable docker
```

```text
sudo apt-get install conntrack
```

## 3. cri-dockerd 설치

```text
VER=$(curl -s https://api.github.com/repos/Mirantis/cri-dockerd/releases/latest|grep tag_name | cut -d '"' -f 4|sed 's/v//g')
echo $VER

wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VER}/cri-dockerd-${VER}.amd64.tgz
tar xvf cri-dockerd-${VER}.amd64.tgz

sudo mv cri-dockerd/cri-dockerd /usr/local/bin/

cri-dockerd --version

wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket
```

## 4. crictl 설치

```text
VERSION="v1.26.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz
```

## 5. fs.protected_regular 설정

```text
sudo sysctl -a | grep fs.protected_regular

echo 'fs.protected_regular = 0' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sudo sysctl -a | grep fs.protected_regular

sudo crontab -e
Choose 1-3 [1]: 3 (option)

@reboot /sbin/sysctl --load=/etc/sysctl.conf
```

## 6. minikube 실행

```text
sudo -i
minikube start --driver=none
```

### 6.1 x509

error execution phase certs/apiserver-kubelet-client: [certs] certificate apiserver-kubelet-client not signed by CA certificate ca: x509: certificate has expired or is not yet valid

- <https://github.com/kubernetes/minikube/issues/13621>
- Tushar255 commented on Jul 28, 2022

```text
minikube delete --all --purge
```

## 7. Windows 10

### 7.1 VirtualBox 설치

```text
https://download.virtualbox.org/virtualbox/6.1.38/VirtualBox-6.1.38-153438-Win.exe
```

### 7.2 minikube 설치

```text
https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe
```

### 7.3 minikube 실행

- 명령 프롬프트 (cmd)에서

```text
minikube start --driver=virtualbox
```

### 7.4 대시보드 실행

- 명령 프롬프트 (cmd)에서

```text
minikube dashboard --url=true
```

## 8. microk8s

### 8.1 설치

```text
sudo snap install microk8s --classic
```

### 8.2 방화벽

```text
sudo ufw allow in on cni0 && sudo ufw allow out on cni0
sudo ufw default allow routed
```

### 8.3 그룹 설정

```text
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
```

```text
su - $USER
```

### 8.4 실행

```text
microk8s start

microk8s kubectl config view --raw > ~/.kube/config
```

```text
microk8s kubectl get all --all-namespaces
```

### 8.5 애드온 실행

```text
microk8s enable dns
microk8s enable dashboard
microk8s enable storage
microk8s enable metallb
microk8s enable ingress
```

### 8.6 대시보드  실행

```text
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
```

```text
microk8s dashboard-proxy
```

### 8.7 x509

```text
sudo microk8s stop
sudo microk8s refresh-certs --cert ca.crt
sudo microk8s start
```
