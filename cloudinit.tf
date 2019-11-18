data "template_cloudinit_config" "app_userdata" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config
manage_etc_hosts: true
package_upgrade: false
packages:
- epel-release
users:
  - name: drupal
    gecos: drupal
    lock-passwd: true
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${var.ssh_key}
EOF
  }
}
