# Helm

## 1. 헬름 설치

```text
curl -fsSL -o get_helm.sh \
    https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## 2. 헬름 차트

```text
helm repo add stable https://charts.helm.sh/stable

helm repo add bitnami https://charts.bitnami.com/bitnami
```

## 3. wordpress 설치

-   wordpress와 mysql이 설치되고 실행까지 대기

```text
helm install wordpress bitnami/wordpress --set service.type=NodePort

minikube kubectl -- get services
```

## 4. wordpress 삭제

```text
helm delete wordpress
```

## 5. 주피터 노트북

### 5.1 차트

#### 5.1.1 탬플릿 생성

```text
helm create python_data_science
```

#### 5.1.2 차트 만들기

-   불필요한 파일 삭제
-   배포 파일 생성
-   서비스 파일 생성
-   변수 파일 생성

```text
cd python_data_science

rm hpa.yaml
rm ingress.yaml
rm NOTES.txt
rm serviceaccount.yaml
```

### 5.2 주피터 노트북 설치

```text
helm install python-data-science-notebook python_data_science
```

### 5.3 주피터 노트북 삭제

```text
helm delete python-data-science-notebook
```
