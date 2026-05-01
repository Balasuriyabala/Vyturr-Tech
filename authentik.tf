resource "helm_release" "authentik" {
  name       = "authentik"
  repository = "https://charts.goauthentik.io"
  chart      = "authentik"
  namespace  = "authentik"

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
  depends_on = [
    null_resource.update_kubeconfig
  ]
}