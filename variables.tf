# Variables

variable ssh_label {
  description = "ssh label"
  default     = "anspro2"
}

variable ssh_public_key {
  description = "ssh public key"
}

variable ssh_private_key {
  description = "ssh private key"
}

variable ssh_notes {
  description = "ssh public key notes"
  default     = "SSH key for remote access to web site"
}

variable vm_count_app {
  default = 2
}
