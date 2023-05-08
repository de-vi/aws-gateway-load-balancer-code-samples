variable "spoke_vpc_cidr" {
  type        = string
  description = "CIDR block for the spoke VPC"
}

variable "az1" {
  description = "Availability zone to use for the Public subnet 1 in the VPC"
  type        = string
}

variable "az2" {
  description = "Availability zone to use for the Public subnet 2 in the VPC"
  type        = string
}

variable "access_location" {
  type        = string
  description = "CIDR block for the Access Location"
}

variable "application_subnet1_cidr" {
  type        = string
  description = "CIDR block for the Application Subnet 1"
}

variable "application_subnet2_cidr" {
  type        = string
  description = "CIDR block for the Application Subnet 2"
}

variable "gwlbe_subnet1_cidr" {
  type        = string
  description = "CIDR block for the Gateway Load Balncer Endpoint Subnet 1"
}

variable "gwlbe_subnet2_cidr" {
  type        = string
  description = "CIDR block for the Gateway Load Balncer Endpoint Subnet 2"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the EC2 Key pair"
}

variable "application_instance_type" {
  type        = string
  description = "Instance type for the application instances"
}

variable "application_instance_disk_size" {
  type        = number
  description = "Disk size for the application instance in GB"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_endpoint_service_name" {
  type        = string
  description = "Gateway Load Balancer VPC endpoint service id"
}