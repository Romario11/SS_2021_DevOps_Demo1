resource "google_compute_instance" "redmine_server_2" {
  name         = "redmine-server2"
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
  tags = [
  "http", "https", "redmine", "icmp", "ssh"]
  provisioner "file" {
    source      = "${path.module}/configs/database.yml"
    destination = "/home/romario/database.yml"
    connection {
      type        = "ssh"
      user        = "romario"
      host        = self.network_interface.0.access_config.0.nat_ip
      private_key = file("~/.ssh/ssh_GCP_private_key")
    }
  }


  metadata_startup_script = file(var.redmine_start_script)
  metadata = {
    ssh-keys = "${var.user_name}:${file(var.ssh_public_key)}"
  }
}