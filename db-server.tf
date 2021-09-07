resource "google_compute_instance" "postgresql_db" {
  name         = "postgres-db"
  machine_type = "e2-highcpu-2"

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
  "postgres"]

  metadata_startup_script = templatefile(var.db_start_script, {
    DB_PASSWORD = var.db_password,
    DB_USER = var.db_user_name,
    DB_NAME = var.db_name })
  metadata = {
    ssh-keys = "${var.user_name}:${file(var.ssh_public_key)}"
  }
}