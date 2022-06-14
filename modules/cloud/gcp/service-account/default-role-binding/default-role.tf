######## CREATE SERVICE ACCOUNT BIND WITH DEFAULT ROLES ###########
resource "google_service_account_iam_binding" "default_role_binder" {
  service_account_id = var.service_account_name
  role               = var.default_role_bind
  
  members = ["ServiceAccount:${var.service_account_email}"]
}