resource "random_id" "role_id" {
  byte_length = 4
  
}

resource "google_project_iam_custom_role" "role" {
  for_each    = var.role_config
  role_id     = "${each.value["role_id"]}-${random_id.role_id.result}"
  title       = each.value["title"]
  description = each.value["description"]
  permissions = each.value["permissions"]
}