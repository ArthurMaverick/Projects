resource "kubernetes_secret" "secret_teleport" {
  metadata {
    name = var.secret_name
    namespace = var.secret_namespace
  }

  data = {
    "${var.secret_key}" = "${file("${var.secret_path}")}"
  }
}