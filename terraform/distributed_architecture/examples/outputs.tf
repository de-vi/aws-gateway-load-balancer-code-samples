# Outputs
/*
output "appliance_vpc_cidr" {
    description = "Appliance VPC CIDR"
    value = var.appliance_vpc_cidr
}
*/

output "appliance_vpc_id" {
  description = "Appliance VPC ID"
  value       = module.appliance.appliance_vpc_id
}

output "appliance_public_subnet1_id" {
  description = "Appliance VPC Public Subnet 1 ID"
  value       = module.appliance.appliance_public_subnet1_id
}

output "appliance_public_subnet2_id" {
  description = "Appliance VPC Public Subnet 2 ID"
  value       = module.appliance.appliance_public_subnet2_id
}

output "appliance_sg_id" {
  description = "Appliance VPC Security Group ID"
  value       = module.appliance.appliance_sg_id
}

output "appliance1_public_ip" {
  description = "Appliance VPC Appliance1's public IP"
  value       = module.appliance.appliance1_public_ip
}

output "appliance2_public_ip" {
  description = "Appliance VPC Appliance1's public IP"
  value       = module.appliance.appliance2_public_ip
}

output "appliance_gwlb_arn" {
  description = "Appliance VPC GWLB ARN"
  value       = module.appliance.appliance_gwlb_arn
}

output "appliance_vpc_endpoint_service_id" {
  description = "Appliance VPC Endpoint Service ID"
  value       = module.appliance.appliance_vpc_endpoint_service_id
}

output "application_instance1_ip" {
  value = module.application.application_instance1_ip
}

output "application_instance2_ip" {
  value = module.application.application_instance2_ip
}