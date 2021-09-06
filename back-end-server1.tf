resource "google_compute_instance" "redmine_server_1" {
  name         = "redmine-server1"
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

resource "local_file" "db_config_redmine" {
  content = templatefile("${path.module}/configs/database.yml.template", {
    DB_HOST     = google_compute_instance.postgresql_db.network_interface.0.access_config.0.nat_ip,
    DB_USER     = var.db_user_name,
    DB_PASSWORD = var.db_password,
    DB_NAME     = var.db_name,
    DB_ADAPTER  = var.db_adapter
  })
  filename = "${path.module}/configs/database.yml"
}