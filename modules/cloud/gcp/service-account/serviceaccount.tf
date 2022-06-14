resource "random_id" "role_id" {
  byte_length = 4
  
}

resource "google_service_account" "service_account" {
  service_account_name  =  "${var.service_account_name}-${random_id.role_id.result}"
  account_id            = var.account_id
  display_name          = var.display_name
  description           = var.description
}

# ######## CREATE SERVICE ACCOUNT BIND WITH CUSTOM ROLES ###########
# resource "google_service_account_iam_binding" "custom_role_binder" {
#   service_account_id = google_service_account.service_account.name
#   role               = var.custom_role_bind
  
#   members = ["ServiceAccount:${google_service_account.service_account.email}"]
# }

# ######## CREATE SERVICE ACCOUNT BIND WITH DEFAULT ROLES ###########
# resource "google_service_account_iam_binding" "default_role_binder" {
#   service_account_id = google_service_account.service_account.name
#   role               = var.default_role_bind
  
#   members = ["ServiceAccount:${google_service_account.service_account.email}"]
# }

############# GENERATE A KEY ################
resource "google_service_account_key" "vault_admin_credentials" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "vault_service_account_cred_file" {
  content  = "${base64decode(google_service_account_key.vault_admin_credentials.private_key)}"
  filename = "${path.module}/vault-admin-credentials.json"
}