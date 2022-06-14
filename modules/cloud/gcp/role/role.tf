resource "random_id" "role_id" {
  byte_length = 4
  
}

resource "google_project_iam_custom_role" "role" {
  role_id     = "${var.role_id}-${random_id.role_id.result}"
  name        = var.role_name
  title       = var.role_title
  description = var.role_description
  permissions = var.role_permissions
}