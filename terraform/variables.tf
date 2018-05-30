variable "cluster_name" {
  default = "skopje"
}

variable "project_id" {
  default = "tf-eidam-project"
}

variable "image_url" {
  default = "gcr.io/google-samples/hello-app:2.0"
}

variable "node_count" {
  default = 1
}

variable "node_type" {
  default = "n1-standard-1"
}

variable "cf_token" {
  // TF_VAR_cf_token
}
