resource "google_compute_network" "default" {
  name                    = "k8wp"
  auto_create_subnetworks = "true"
}