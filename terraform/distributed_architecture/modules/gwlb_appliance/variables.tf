variable "appliance_vpc_cidr" {
  default     = "192.168.1.0/24"
  description = "CIDR block for the VPC"
  type        = string
}

variable "region" {
  default = "us-east-1"
}

variable "az1" {
  description = "Availability zone to use for the Public subnet 1 in the VPC"
  type        = string
}

variable "az2" {
  description = "Availability zone to use for the Public subnet 2 in the VPC"
  type        = string
}

#variable "appliance_subnets" {}
variable "public_subnet1_cidr" {
  default     = "192.168.1.0/28"
  description = "CIDR block foe the Public Subnet 1 located in Public Availability Zone 1"
  type        = string
}

variable "public_subnet2_cidr" {
  default     = "192.168.1.16/28"
  description = "CIDR block foe the Public Subnet 2 located in Public Availability Zone 2"
  type        = string
}

variable "appliance_instance_type" {
  default     = "t2.micro"
  description = ""
  type        = string
}

variable "appliance_ami_id" {
  default     = ""
  description = "Latest AMI ID for appliance (EC2 instance)"
  type        = string
}

variable "appliance_instance_disk_size" {
  default     = 8
  description = "Appliance instance disk size in GB."
  type        = number
}

variable "key_pair_name" {
  description = "EC2 Keypair required for accessing EC2 instance"
  type        = string
}

variable "access_location" {
  default = "0.0.0.0/0"
  type    = string
}

variable "gwlb_name" {
  default     = "gwlb1"
  description = "Appliance gateway name. This name must be unique within your AWS account and can have maximum 32 characters"
  type        = string
}

variable "target_group_name" {
  default     = "tg1"
  description = "Target group name"
  type        = string
}

variable "health_port" {
  default     = "80"
  description = "The port the load balancer uses when performing health checks on targets"
  type        = string
}

variable "health_protocol" {
  default     = "HTTP"
  description = "The protocol the appliance gateway uses when performing health checks on targets"
  type        = string
}

variable "connection_acceptance" {
  default     = false
  description = "Acceptance required for endpoint connection or not"
  type        = string
}