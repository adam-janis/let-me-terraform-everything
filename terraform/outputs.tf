output "myservice_ip" {
  value = "${kubernetes_service.myservice.load_balancer_ingress.0.ip}"
}

output "myservice_hostname" {
  value = "${cloudflare_record.myhostname.hostname}"
}
