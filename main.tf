resource "ibm_compute_ssh_key" "ssh_key" {
  label      = "anspro2"
  notes      = "${var.ssh_notes}"
  public_key = "${var.ssh_public_key}"
}

########################################################
# Create VM 
########################################################

resource "ibm_compute_vm_instance" "ans_webapp1" {
  domain            = "wcpclouduk.com"
  datacenter        = "lon06"
  count             = "${var.vm_count_app}"
  hostname          = "${format("ans-webapp1%02d", count.index + 1)}"
  os_reference_code = "CENTOS_LATEST_64"
  flavor_key_name   = "C1_1X1X25"
  local_disk        = false
  ssh_key_ids       = ["${ibm_compute_ssh_key.ssh_key.id}"]

  private_security_group_ids = ["${ibm_security_group.sg_private_ans.id}"]
  public_security_group_ids  = ["${ibm_security_group.sg_public_ans.id}"]
  private_network_only       = false

  # user_metadata = "${data.template_cloudinit_config.app_userdata.rendered}"
  tags          = ["group:ansible_provisioner","group:servers"]
  connection {
    //user = "root"
    private_key = "${var.ssh_private_key}"
  }
  provisioner "ansible" {
    plays {
      playbook = {
        file_path = "${path.module}/ansible-data/playbooks/install-tree.yml"
        roles_path = [
            "${path.module}/ansible-data/roles"
        ]
      }
      groups = ["servers"]
      verbose = true
    }
    ansible_ssh_settings {
      insecure_no_strict_host_key_checking = "${var.insecure_no_strict_host_key_checking}"
    }
  }    
}



data "ibm_resource_group" "group" {
  name = "default"
}

variable "insecure_no_strict_host_key_checking" {
  default = true
}


      
