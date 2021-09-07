output "external_ip_load_balancer" {
  value = google_compute_instance.load_balancer.network_interface[0].access_config[0].nat_ip
}