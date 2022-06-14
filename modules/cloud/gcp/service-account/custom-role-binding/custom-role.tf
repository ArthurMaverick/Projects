######## CREATE SERVICE ACCOUNT BIND WITH CUSTOM ROLES ###########
resource "google_service_account_iam_binding" "custom_role_binder" {
  service_account_id = var.service_account_name
  role               = var.custom_role_bind
  
  members = ["ServiceAccount:${var.service_account_email}"]
}
