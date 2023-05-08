# Outputs
output "appliance_vpc_cidr" {
  description = "Appliance VPC CIDR"
  value       = var.appliance_vpc_cidr
}

output "appliance_vpc_id" {
  description = "Appliance VPC ID"
  value       = aws_vpc.appliance_vpc.id
}

output "appliance_public_subnet1_id" {
  description = "Appliance VPC Public Subnet 1 ID"
  value       = aws_subnet.public_subnet1.id
}

output "appliance_public_subnet2_id" {
  description = "Appliance VPC Public Subnet 2 ID"
  value       = aws_subnet.public_subnet2.id
}

output "appliance_sg_id" {
  description = "Appliance VPC Security Group ID"
  value       = aws_security_group.appliance_sg.id
}

output "appliance1_public_ip" {
  description = "Appliance VPC Appliance1's public IP"
  value       = aws_instance.appliance1.public_ip
}

output "appliance2_public_ip" {
  description = "Appliance VPC Appliance1's public IP"
  value       = aws_instance.appliance2.public_ip
}

output "appliance_gwlb_arn" {
  description = "Appliance VPC GWLB ARN"
  value       = aws_lb.gwlb.arn
}

output "appliance_vpc_endpoint_service_id" {
  description = "Appliance VPC Endpoint Service ID"
  value       = aws_vpc_endpoint_service.vpc_endpoint_service.service_name
}