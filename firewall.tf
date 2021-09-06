resource "google_compute_firewall" "http" {
  name    = "http"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  priority    = "65534"
  target_tags = ["http"]
}

resource "google_compute_firewall" "https" {
  name    = "https"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["https"]
}

resource "google_compute_firewall" "postgres" {
  name    = "postgres"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  priority    = "65534"
  target_tags = ["postgres"]

}

resource "google_compute_firewall" "redmine_point" {
  name    = "redmine"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }
  priority    = "65534"
  target_tags = ["redmine"]
}

resource "google_compute_firewall" "icmp" {
  name    = "icmp"
  network = var.network_name
  allow {
    protocol = "icmp"
  }
  target_tags = ["icmp"]
}

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}
