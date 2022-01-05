variable "region" {
    type    = string
    default = "us-east-1"
}

variable "prefix" {
  description = "servername prefix"
  default     = "k3s-manager"
}

variable "instance_count" {
  default = 3 
}

variable "availability_zones" {
  type    = list(string)
  default = ["b", "c", "d"]
}