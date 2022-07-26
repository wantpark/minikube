# Helm

```text
mkdir charts
cd charts
```

## 1. MySQL

```text
helm create mysql-chart
```

## 1.1 차트

#### 1.1.1 탬플릿 생성

-   불필요한 파일 삭제
-   배포 파일 생성
-   서비스 파일 생성
-   변수 파일 생성

```text
cd mysql-chart/templates

rm hpa.yaml ingress.yaml NOTES.txt serviceaccount.yaml
cp ~/minikube/terraform/helm/mysql-chart/templates/* ./
cp ~/minikube/terraform/helm/mysql-chart/values.yaml ../

cd ../..
```

## 2. wordpress

```text
helm create wordpress-chart
```

## 1.1 차트

#### 1.1.1 탬플릿 생성

-   불필요한 파일 삭제
-   배포 파일 생성
-   서비스 파일 생성
-   변수 파일 생성

```text
cd wordpress-chart/templates

rm hpa.yaml ingress.yaml NOTES.txt serviceaccount.yaml
cp ~/minikube/terraform/helm/wordpress-chart/templates/* ./
cp ~/minikube/terraform/helm/wordpress-chart/values.yaml ../

cd ../..
```

## 3. 테라폼 실행

```text
cp ~/minikube/terraform/helm/helm.tf ./

terraform init

terraform plan

terraform apply
Enter a value: <yes 입력>
```

## 4. 배포 확인

```text
http://127.0.0.1:32000
```
