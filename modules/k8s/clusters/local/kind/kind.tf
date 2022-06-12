resource "kind_cluster" "project" {
  name = var.kind_cluster_name
  kubeconfig_path = pathexpand(var.kind_cluster_config_path)
  wait_for_ready = true

    kind_config {
      kind = "cluster"
      api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]
      extra_port_mappings {
        container_port = 80
        host_port = 80
      }
    }

    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
  }
}


