resource "helm_release" "ingress_nginx" {
  name  = "ingress-nginx"
  chart = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"

  namespace        = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }
}

resource "kubectl_manifest" "name" {
  yaml_body = file("./config/ingress-resource.yaml")
}
