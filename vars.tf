variable "vpc-cidr" {
  default = "172.16.0.0/16"
  description = "VPC CIDR Block"
  type = string
}

variable "public-subnet-cidr" {
  default = "172.16.1.0/24"
  description = "Public Subnet CIDR Block"
  type = string
}

variable "private-subnet-cidr" {
  default = "172.16.2.0/24"
  description = "Private Subnet CIDR Block"
  type = string
}

variable "route-cidr" {
  default = "172.16.0.0/24"
  description = "Route table CIDR Block"
  type = string
}