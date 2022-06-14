resource "google_compute_network" "custom" {
  name                    = "${var.project_name}-network"
  auto_create_subnetworks = false
}
