provider "google" {
  credentials = "${file("creds/serviceaccount.json")}"
  project     = "<ENTER PROJECT NAME>"
  region      = "us-east1"
}
