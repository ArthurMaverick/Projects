resource "random_id" "role_id" {
  byte_length = 8
  
}

resource "google_project" "my_project" {
  name       = var.project_name
  project_id = "${var.project_name}-${random_id.role_id.result}"
  folder_id  =  google_folder.Labs.name
}

resource "google_folder" "Labs" {
  display_name = var.project_display_name
  parent       = "organizations/${var.project_display_name}"
}