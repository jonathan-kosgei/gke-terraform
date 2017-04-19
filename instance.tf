resource "google_compute_instance" "gluster" {
  count        = "${var.count}"
  name         = "gluster-${count.index + 1}"
  machine_type = "n1-standard-1"
  zone         = "${var.region}"
  can_ip_forward = "true"

  tags = ["internal"]

  disk {
    image = "${var.image}"
  }

  // Local SSD disk
  disk {
    type    = "local-ssd"
    scratch = true
  }

  // Mount secondary pds for gluster
  disk {
    disk = "${element(google_compute_disk.gluster-pd.*.name, count.index)}"
    auto_delete = false
    device_name = "gluster-pd"
  }

  network_interface {
    network = "${google_compute_network.default.name}"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "jonathan:${file("${var.public_key_path}")}" 
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install -y glusterfs-server;sudo mkdir -p /mnt/gfs && sudo mount -o discard,defaults /dev/disk/by-id/google-gluster-pd /mnt/gfs && sudo chmod a+w /mnt/gfs && echo UUID=`sudo blkid -s UUID -o value /dev/disk/by-id/google-gluster-pd` /mnt/gfs ext4 discard,defaults,[NOFAIL] 0 2 | sudo tee -a /etc/fstab"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}