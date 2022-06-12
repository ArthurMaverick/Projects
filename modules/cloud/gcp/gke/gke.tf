resource "google_container_cluster" "gke_cluster" {
  name               = "${var.type_project}-cluster"
  location           = "us-central1"
  initial_node_count = var.initial_node_count
  remove_default_node_pool = true

  network    =  var.network_id
  subnetwork =  var.subnet_id

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = var.secondary_ip_range_name
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.type_project}-node-pool"
  cluster    = google_container_cluster.gke_cluster.id
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_type = "pd-standard"
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.gke_cluster.email
  }

  cluster_autoscaling {
    enabled = var.cluster_autoscaling
  }

  autoscaling {
    min_node_count = var.min_nodes_limits
    max_node_count = var.max_nodes_limits
  }

  timeouts {
    create = "30m"
    update = "20m"
  }

}