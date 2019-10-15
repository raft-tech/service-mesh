resource "google_container_cluster" "gke" {
  name         = "gke-cluster-hsi"
  location     = "us-east1"

  remove_default_node_pool = true
  initial_node_count       = 1
  }

resource "google_container_node_pool" "gke_nodes" {
  name       = "hsi-node-pool"
  location       = "us-east1"
  cluster    = "${google_container_cluster.gke.name}"
  node_count = 2

  node_config {
    machine_type = "n1-standard-2"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
