variable "INSTANCE_SIZE" {
  type        = string
  default     = "s"
  description = "Size of the instance using shirt size terminology. See locals.tf for a list of available sizes"
}

variable "ROOT_STORAGE_SIZE" {
  type        = number
  default     = 10
  description = "Size of the root volume in GB"
}

variable "AMI_NAME" {
  type        = string
  default     = "rhel8"
  description = "Name of the AMI to use. See locals.tf for a list of available AMIs"
}

variable "KEEP_DATA" {
  type        = bool
  default     = false
  description = "If true, the root volume will not be deleted when the instance is terminated"
}

variable "PUBLIC_KEY_PATH" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to your public key"
}

variable "PRIVATE_KEY_PATH" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "Path to your private key"
}
