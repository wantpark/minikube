# Terrform

## 1. 테라폼 설치

```text
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install terraform -y
```

## 2. 테라폼 실행

-   minikube 또는 microk8s가 실행된 상태

```text
terraform init

terraform plan

terraform apply
Enter a value: <yes 입력>
```

## 3. 배포 확인

```text
http://127.0.0.1:32000
```
