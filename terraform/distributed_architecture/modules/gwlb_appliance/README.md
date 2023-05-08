## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.appliance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.appliance_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.appliance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.appliance_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.appliance1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.appliance2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.appliance_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_internet_gateway_attachment.appliance_vpc_igw_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway_attachment) | resource |
| [aws_lb.gwlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.appliance1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.appliance2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_route.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public_subnet1_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_subnet2_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.appliance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.public_subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.appliance_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.appliance_vpc_ec2_messages_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.appliance_vpc_ssm_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.appliance_vpc_ssm_messages_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.vpc_endpoint_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_ssm_parameter.ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_location"></a> [access\_location](#input\_access\_location) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_appliance_ami_id"></a> [appliance\_ami\_id](#input\_appliance\_ami\_id) | Latest AMI ID for appliance (EC2 instance) | `string` | `""` | no |
| <a name="input_appliance_instance_disk_size"></a> [appliance\_instance\_disk\_size](#input\_appliance\_instance\_disk\_size) | Appliance instance disk size in GB. | `number` | `8` | no |
| <a name="input_appliance_instance_type"></a> [appliance\_instance\_type](#input\_appliance\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_appliance_vpc_cidr"></a> [appliance\_vpc\_cidr](#input\_appliance\_vpc\_cidr) | CIDR block for the VPC | `string` | `"192.168.1.0/24"` | no |
| <a name="input_az1"></a> [az1](#input\_az1) | Availability zone to use for the Public subnet 1 in the VPC | `string` | n/a | yes |
| <a name="input_az2"></a> [az2](#input\_az2) | Availability zone to use for the Public subnet 2 in the VPC | `string` | n/a | yes |
| <a name="input_connection_acceptance"></a> [connection\_acceptance](#input\_connection\_acceptance) | Acceptance required for endpoint connection or not | `string` | `false` | no |
| <a name="input_gwlb_name"></a> [gwlb\_name](#input\_gwlb\_name) | Appliance gateway name. This name must be unique within your AWS account and can have maximum 32 characters | `string` | `"gwlb1"` | no |
| <a name="input_health_port"></a> [health\_port](#input\_health\_port) | The port the load balancer uses when performing health checks on targets | `string` | `"80"` | no |
| <a name="input_health_protocol"></a> [health\_protocol](#input\_health\_protocol) | The protocol the appliance gateway uses when performing health checks on targets | `string` | `"HTTP"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | EC2 Keypair required for accessing EC2 instance | `string` | n/a | yes |
| <a name="input_public_subnet1_cidr"></a> [public\_subnet1\_cidr](#input\_public\_subnet1\_cidr) | CIDR block foe the Public Subnet 1 located in Public Availability Zone 1 | `string` | `"192.168.1.0/28"` | no |
| <a name="input_public_subnet2_cidr"></a> [public\_subnet2\_cidr](#input\_public\_subnet2\_cidr) | CIDR block foe the Public Subnet 2 located in Public Availability Zone 2 | `string` | `"192.168.1.16/28"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | Target group name | `string` | `"tg1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appliance1_public_ip"></a> [appliance1\_public\_ip](#output\_appliance1\_public\_ip) | Appliance VPC Appliance1's public IP |
| <a name="output_appliance2_public_ip"></a> [appliance2\_public\_ip](#output\_appliance2\_public\_ip) | Appliance VPC Appliance1's public IP |
| <a name="output_appliance_gwlb_arn"></a> [appliance\_gwlb\_arn](#output\_appliance\_gwlb\_arn) | Appliance VPC GWLB ARN |
| <a name="output_appliance_public_subnet1_id"></a> [appliance\_public\_subnet1\_id](#output\_appliance\_public\_subnet1\_id) | Appliance VPC Public Subnet 1 ID |
| <a name="output_appliance_public_subnet2_id"></a> [appliance\_public\_subnet2\_id](#output\_appliance\_public\_subnet2\_id) | Appliance VPC Public Subnet 2 ID |
| <a name="output_appliance_sg_id"></a> [appliance\_sg\_id](#output\_appliance\_sg\_id) | Appliance VPC Security Group ID |
| <a name="output_appliance_vpc_cidr"></a> [appliance\_vpc\_cidr](#output\_appliance\_vpc\_cidr) | Appliance VPC CIDR |
| <a name="output_appliance_vpc_endpoint_service_id"></a> [appliance\_vpc\_endpoint\_service\_id](#output\_appliance\_vpc\_endpoint\_service\_id) | Appliance VPC Endpoint Service ID |
| <a name="output_appliance_vpc_id"></a> [appliance\_vpc\_id](#output\_appliance\_vpc\_id) | Appliance VPC ID |
