resource "google_compute_network" "custom" {
  name                    = "${var.type_project}-network"
  auto_create_subnetworks = false
}
