# Ansible

## 1. 우분투 설치

```text
sudo su

docker run -d -it --name ansible_server ubuntu:20.04
docker run -d -it --name worker1 -p 8081:80 ubuntu:20.04
docker run -d -it --name worker2 -p 8082:80 ubuntu:20.04
```

## 2. 대상 클라이언트

### 2.1 ssh 서버 설치

-   ssh 서버 설치시 지역은 Asia/Seoul 선택
    -   Geograpic area: 6
    -   Time zone: 69
-   worker2도 동일하게 진행 (2.1부터 2.3 까지)

```text
docker exec -it worker1 /bin/bash

apt-get update
apt-get install openssh-server vim -y
```

### 2.2 루트 암호 및 서버 설정 변경

```text
passwd
New password: 1 (암호 입력)
Retype new password: 1 (암호 재입력)

vi /etc/ssh/sshd_config
PermitRootLogin yes
Port 22
```

### 2.3 ssh 서버 실행

```text
service ssh start
service ssh status

exit
```

## 2.4 worker IP 주소 확인

-   "IPAddress": "172.17.0.3" (환경마다 다름)
-   "IPAddress": "172.17.0.4"

```text
docker inspect worker1
docker inspect worker2
```

## 3. 앤서블 실행 클라이언트

### 3.1 ssh 키 복사

-   대상 클라이언트에 비밀번호 대신 키로 접속하기 위해

```text
docker exec -it ansible_server /bin/bash

ssh-keygen
(질문에 대해 모두 엔터 입력)

ssh-copy-id 172.17.0.3
(worker1에서 입력한 root 암호)

ssh-copy-id 172.17.0.4
(worker2에서 입력한 root 암호)
```

### 3.2 앤서블 설치

```text
apt-get update
apt-get install ansible vim -y

ansible --version
```

### 3.3 인벤토리

인벤토리(hosts 파일)에 worker 정보 설정

```text
vi /etc/ansible/hosts

[webserver]
172.17.0.3
172.17.0.4
```

### 3.4 엔서블 동작 확인

```text
ansible -m ping all
```

### 3.5 플레이북

-   nginx 설치
-   playbook-nginx.yaml 파일 생성

```text
ansible-playbook playbook-nginx.yaml

exit
```

### 3.6 nginx 설치 확인

-   worker2도 확인

```text
docker exec -it worker1 /bin/bash

nginx -v

exit
```
