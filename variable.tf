variable "vpc_id" {
    type = string
    description = "VPC ID"
}

variable "secondary_cidr_block" {
    type = string
    description = "Secondary CIDR"
}

variable "internet_gateway" {
    type = string
    description = "Internet Gateway ID"
}
variable "vpn_gateway" {
    type = string
    description = "VPN Gateway ID"
}

variable "public_subnet_01" {
    type = string
    description = "Public Subnet 01 CIDR Block"
}

variable "public_subnet_02" {
    type = string
    description = "Public Subnet 02 CIDR Block"
}

variable "public_subnet_03" {
    type = string
    description = "Public Subnet 03 CIDR Block"
}

variable "private_subnet_01" {
    type = string
    description = "Private Subnet 01 CIDR Block"
}

variable "private_subnet_02" {
    type = string
    description = "Private Subnet 02 CIDR Block"
}

variable "private_subnet_03" {
    type = string
    description = "Private Subnet 03 CIDR Block"
}

variable "cluster_name" {
    type = string
    description = "Eks Cluster name"
}