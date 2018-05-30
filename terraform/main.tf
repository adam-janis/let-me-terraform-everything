resource "google_container_cluster" "mycluster" {
  name    = "${var.cluster_name}"
  zone    = "europe-west1-b"
  project = "${var.project_id}"

  initial_node_count = "${var.node_count}"

  node_config {
    machine_type = "${var.node_type}"
  }
}

resource "kubernetes_pod" "mypod" {
  depends_on = ["google_container_cluster.mycluster"]

  "metadata" {
    name = "mypod"

    labels {
      app = "myapp"
    }
  }

  "spec" {
    container {
      name  = "mycontainer"
      image = "${var.image_url}"

      port {
        container_port = 8080
      }
    }
  }
}

resource "kubernetes_service" "myservice" {
  depends_on = ["kubernetes_pod.mypod"]

  "metadata" {
    name = "myservice"
  }

  "spec" {
    selector {
      app = "myapp"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "cloudflare_record" "myhostname" {
  domain = "typek.sk"
  name   = "${var.cluster_name}"
  type   = "A"
  value  = "${kubernetes_service.myservice.load_balancer_ingress.0.ip}"
}
