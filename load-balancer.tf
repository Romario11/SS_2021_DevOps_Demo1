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
  tags = ["http", "https","icmp","ssh"]

  provisioner "file" {
    source      = "${path.module}/configs/nginx.conf"
    destination = "/home/romario/nginx.conf"
    connection {
      type        = "ssh"
      user        = "romario"
      host        = self.network_interface.0.access_config.0.nat_ip
      private_key = file(var.ssh_private_key)
    }
  }

depends_on = [local_file.load_balancer_config]

  metadata_startup_script = file(var.load_balancer_start_script)
  metadata = {
    ssh-keys = "${var.user_name}:${file(var.ssh_public_key)}"
  }
}


resource "local_file" "load_balancer_config" {
  content = templatefile("${path.module}/configs/nginx.conf.template", {
    REDMINE_SERVER1 = google_compute_instance.redmine_server_1.network_interface.0.access_config.0.nat_ip,
    REDMINE_SERVER2 = google_compute_instance.redmine_server_2.network_interface.0.access_config.0.nat_ip
  })
  filename = "${path.module}/configs/nginx.conf"


}