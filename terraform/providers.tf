terraform {
  backend "gcs" {
    bucket = "tf-eidam-state"
  }
}

provider "google" {
  region = "europe-west1" // Belgium
}

provider "kubernetes" {
  host                   = "${google_container_cluster.mycluster.endpoint}"
  username               = "${google_container_cluster.mycluster.master_auth.0.username}"
  password               = "${google_container_cluster.mycluster.master_auth.0.password}"
  client_certificate     = "${base64decode(google_container_cluster.mycluster.master_auth.0.client_certificate)}"
  client_key             = "${base64decode(google_container_cluster.mycluster.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.mycluster.master_auth.0.cluster_ca_certificate)}"
}

provider "cloudflare" {
  email = "adam.janis@gmail.com"
  token = "${var.cf_token}"
}
