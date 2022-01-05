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
  default = ["us-east-1b", "us-east-1c", "us-east-1d"]

}          
               