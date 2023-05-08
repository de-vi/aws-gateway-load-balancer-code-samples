output "application_instance1_ip" {
  value = aws_instance.application_1.public_ip
}

output "application_instance2_ip" {
  value = aws_instance.application_2.public_ip
}