resource "google_compute_firewall" "k8wp" {
  name    = "allow-all-internal"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  source_ranges = ["10.128.0.0/20"]
}

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}