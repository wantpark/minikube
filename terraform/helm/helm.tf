provider "helm" {
 kubernetes {
   config_path    = "~/.kube/config"
   config_context = "microk8s"
 }
}

resource "helm_release" "mysql" {
 name  = "mysql"
 chart = "${abspath(path.root)}/mysql-chart"
}

resource "helm_release" "wordpress" {
 name  = "wordpress"
 chart = "${abspath(path.root)}/wordpress-chart"
}