variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "registry_port" {
  description = "The port the server will use to host a Docker registry"
  default     = 5000
}

variable "ami" {
  description = "The AMI used by the ec2 instance"
  default     = "ami-0ff8a91507f77f867"
}

variable "key_pair_name" {
  description = "The name of the Key Pair that can be used to SSH to each EC2 instance. Leave blank to not include a Key Pair."
  default     = "deployer-key"
}
