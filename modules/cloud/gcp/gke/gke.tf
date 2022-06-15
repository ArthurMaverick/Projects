resource "google_container_cluster" "gke_cluster" {
  name                     = "${var.project_name}-cluster"
  location                 = "us-central1"
  initial_node_count       = var.initial_node_count
  remove_default_node_pool = true

  network    = var.network_id
  subnetwork = var.subnet_id

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = var.secondary_ip_range_name
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.project_name}-node-pool"
  cluster    = google_container_cluster.gke_cluster.id
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    disk_type    = "pd-standard"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
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
