# Let me Terraform everything
- practical demonstration for "Let me Terraform everything" presentation (http://bit.ly/let-me-terraform-everything)
- leave feedback on the presentation http://bit.ly/let-me-feedback-everything

## Tasks
1. prepare project variables
    - name
    - gcp_project
    - image_url
    - node_count
    - node_type
2. setup backend for remote state
3. setup **Google provider**
4. create **Google Container Cluster** (Kubernetes cluster)
5. setup **Kubernetes provider**
6. deploy **Kubernetes Pod**
7. expose this Pod with **Kubernetes Service**
    - output Service public IP
    - check whether its working, try to change image
8. setup **CloudFlare provider**
9. create `A` DNS record for your service
    - output DNS **hostname**
    - check whether its working
10. Reproduce whole setup with **Workspaces** and `.tfvars` files

## Resources
- GCP
    - google provider configuration https://www.terraform.io/docs/providers/google/index.html#configuration-reference
    - Terraform GKE https://www.terraform.io/docs/providers/google/r/container_cluster.html
    - regions/zones https://cloud.google.com/compute/docs/regions-zones/
    - machine types https://cloud.google.com/compute/docs/machine-types/ (default `n1-standard-1`)
    - GCS remote state https://www.terraform.io/docs/backends/types/gcs.html
- Hello world image `gcr.io/google-samples/hello-app:1.0`

## Kubernetes provider example
```
provider "kubernetes" {
  host = "${google_container_cluster.skopje_cluster.endpoint}"
  username = "${google_container_cluster.skopje_cluster.master_auth.0.username}"
  password = "${google_container_cluster.skopje_cluster.master_auth.0.password}"
  client_certificate = "${base64decode(google_container_cluster.skopje_cluster.master_auth.0.client_certificate)}"
  client_key = "${base64decode(google_container_cluster.skopje_cluster.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.skopje_cluster.master_auth.0.cluster_ca_certificate)}"
}
```