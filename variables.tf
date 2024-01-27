variable "region" {
    default = "us-east-1"
}

variable "access_key" {
    description = "my aws access key"
  
}
variable "secret_key" {
    description = "my aws secret key"
  
}
variable "my_ip" {
  description = "My public IP address for SSH access"
  type        = string
  default     = "0.0.0.0/32"
}

