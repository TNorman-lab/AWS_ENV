data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "kubernetes_namespace" "k8_production_namespace" {
  metadata {
    name = "terraform-managed"
  }
}
