// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("service-account.json")}"
  project     = "churchwebsitepress-1"
  region      = "us-central1-a"
}