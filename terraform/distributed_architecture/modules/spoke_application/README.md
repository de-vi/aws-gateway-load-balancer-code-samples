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
| [aws_iam_instance_profile.application_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.application_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.application_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.application_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.spoke_vpc_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.add_application1_igw_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.add_application2_igw_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.add_route1_application_route_table1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.add_route2_application_route_table2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.gwlbe_route_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.gwlbe_route_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.application_route_table_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.application_route_table_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.gwlbe_route_table_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.gwlbe_route_table_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.igw_route_table_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.app_subnet_1_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.app_subnet_2_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.gwlbe_subnet_1_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.gwlbe_subnet_2_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.igw_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.application_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.application_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.application_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.gwlbe_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.gwlbe_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.spoke_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.gwlb_vpc_endpoint_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.gwlb_vpc_endpoint_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.spoke_vpc_ec2_messages_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.spoke_vpc_ssm_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.spoke_vpc_ssm_messages_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_ssm_parameter.ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_location"></a> [access\_location](#input\_access\_location) | CIDR block for the Access Location | `string` | n/a | yes |
| <a name="input_application_instance_disk_size"></a> [application\_instance\_disk\_size](#input\_application\_instance\_disk\_size) | Disk size for the application instance in GB | `number` | n/a | yes |
| <a name="input_application_instance_type"></a> [application\_instance\_type](#input\_application\_instance\_type) | Instance type for the application instances | `string` | n/a | yes |
| <a name="input_application_subnet1_cidr"></a> [application\_subnet1\_cidr](#input\_application\_subnet1\_cidr) | CIDR block for the Application Subnet 1 | `string` | n/a | yes |
| <a name="input_application_subnet2_cidr"></a> [application\_subnet2\_cidr](#input\_application\_subnet2\_cidr) | CIDR block for the Application Subnet 2 | `string` | n/a | yes |
| <a name="input_az1"></a> [az1](#input\_az1) | Availability zone to use for the Public subnet 1 in the VPC | `string` | n/a | yes |
| <a name="input_az2"></a> [az2](#input\_az2) | Availability zone to use for the Public subnet 2 in the VPC | `string` | n/a | yes |
| <a name="input_gwlbe_subnet1_cidr"></a> [gwlbe\_subnet1\_cidr](#input\_gwlbe\_subnet1\_cidr) | CIDR block for the Gateway Load Balncer Endpoint Subnet 1 | `string` | n/a | yes |
| <a name="input_gwlbe_subnet2_cidr"></a> [gwlbe\_subnet2\_cidr](#input\_gwlbe\_subnet2\_cidr) | CIDR block for the Gateway Load Balncer Endpoint Subnet 2 | `string` | n/a | yes |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name of the EC2 Key pair | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_spoke_vpc_cidr"></a> [spoke\_vpc\_cidr](#input\_spoke\_vpc\_cidr) | CIDR block for the spoke VPC | `string` | n/a | yes |
| <a name="input_vpc_endpoint_service_name"></a> [vpc\_endpoint\_service\_name](#input\_vpc\_endpoint\_service\_name) | Gateway Load Balancer VPC endpoint service id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_instance1_ip"></a> [application\_instance1\_ip](#output\_application\_instance1\_ip) | n/a |
| <a name="output_application_instance2_ip"></a> [application\_instance2\_ip](#output\_application\_instance2\_ip) | n/a |
