resource "google_compute_instance" "load_balancer" {
  name         = "nginx-load-balancer"
  machine_type = "e2-small"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210720"
    }
  }


  network_interface {
    network = var.network_name
    access_config {
    }
  }
  tags = ["http", "https"]

  metadata_startup_script = templatefile(var.load_balancer_start_script,{var1="Hello"})
  metadata = {
    ssh-keys = "${var.user_name}:${file(var.ssh_public_key)}"
  }
}
