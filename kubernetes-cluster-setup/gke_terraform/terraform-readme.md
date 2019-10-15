# GKE Installation using Terraform
GKE is managed kubernetes solution offered by Google Cloud
We will use terraform to install GKE

# Prerequisites
Install Terraform
```
brew install terraform
```

# GKE Installation
**Step1: Create a directory called gke-terraform and also create couple of .tf files**
```
mkdir gke-terraform
cd gke-terraform
mkdir creds
touch provider.tf
touch cluster.tf
```

**Step2: Create a Service Account in Google Cloud Console**
```
1. Navigate to https://console.cloud.google.com and login to the console
2. Navigate to IAM&admin -> Service Accounts -> Create new service account -> Name it as you like -> Click Create -> Assign Project Editor role -> Download JSON keys for Service Account
3. Store the JSON file under creds directory that we created
```

**Step3: cluster.tf has gke cluster configuration and provider.tf has project and other metadata info**
cluster.tf
```
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
```

provider.tf
```
provider "google" {
  credentials = "${file("creds/xxx.json")}"
  project     = "<ENTER PROJECT NAME>"
  region      = "us-east1"
}

**Step4: Initialize terraform**
```
terraform init
```

**Step5: Run terraform plan**
```
terraform plan
```

**Step6: Run terraform apply**
```
terraform apply
```

Terraform code is available in this repo under gke_terraform

