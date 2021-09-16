terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("~/.ssh/credentials-gcp.json")
  project     = "credible-mode-318514"
  region      = "us-central1"
  zone        = "us-central1-a"
}
//e2-highcpu-4

resource "google_compute_instance" "vm_instance" {
  name         = "jenkins-ci-redmine"
  machine_type = "e2-highcpu-4"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210720"
    }
    
  }



  network_interface {
    network = "default"
    access_config {
    }
  }
  tags = ["http-server", "https-server","jenkins8080"]


  metadata_startup_script = file("apache.sh")
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/gcp-key")}"
  }
}
