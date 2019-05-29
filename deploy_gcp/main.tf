provider "google" {
  project = "${var.project}"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.name}-terraform-instance"
  machine_type = "n1-standard-2"

  boot_disk {
    initialize_params {
      image = "${var.project}/${var.image}"
      size  = "60"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    # network       = "default"
    network = "${google_compute_network.vpc_network.self_link}"
    access_config = {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.name}-terraform-network"
  auto_create_subnetworks = "true"
}

# firewall
resource "google_compute_firewall" "default" {
  name    = "${var.name}-test-firewall"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "1000-2000", "8800", "8006"]
  }

  source_ranges = ["0.0.0.0/0"]
}
