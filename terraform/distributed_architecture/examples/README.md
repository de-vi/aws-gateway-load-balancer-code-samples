## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_appliance"></a> [appliance](#module\_appliance) | ../modules/gwlb_appliance | n/a |
| <a name="module_application"></a> [application](#module\_application) | ../modules/spoke_application | n/a |

## Resources

No resources.

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
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | EC2 Keypair required for accessing EC2 instance | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_spoke_vpc_cidr"></a> [spoke\_vpc\_cidr](#input\_spoke\_vpc\_cidr) | CIDR block for the spoke VPC | `string` | n/a | yes |
| <a name="input_vpc_endpoint_service_name"></a> [vpc\_endpoint\_service\_name](#input\_vpc\_endpoint\_service\_name) | Gateway Load Balancer VPC endpoint service id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appliance1_public_ip"></a> [appliance1\_public\_ip](#output\_appliance1\_public\_ip) | Appliance VPC Appliance1's public IP |
| <a name="output_appliance2_public_ip"></a> [appliance2\_public\_ip](#output\_appliance2\_public\_ip) | Appliance VPC Appliance1's public IP |
| <a name="output_appliance_gwlb_arn"></a> [appliance\_gwlb\_arn](#output\_appliance\_gwlb\_arn) | Appliance VPC GWLB ARN |
| <a name="output_appliance_public_subnet1_id"></a> [appliance\_public\_subnet1\_id](#output\_appliance\_public\_subnet1\_id) | Appliance VPC Public Subnet 1 ID |
| <a name="output_appliance_public_subnet2_id"></a> [appliance\_public\_subnet2\_id](#output\_appliance\_public\_subnet2\_id) | Appliance VPC Public Subnet 2 ID |
| <a name="output_appliance_sg_id"></a> [appliance\_sg\_id](#output\_appliance\_sg\_id) | Appliance VPC Security Group ID |
| <a name="output_appliance_vpc_endpoint_service_id"></a> [appliance\_vpc\_endpoint\_service\_id](#output\_appliance\_vpc\_endpoint\_service\_id) | Appliance VPC Endpoint Service ID |
| <a name="output_appliance_vpc_id"></a> [appliance\_vpc\_id](#output\_appliance\_vpc\_id) | Appliance VPC ID |
| <a name="output_application_instance1_ip"></a> [application\_instance1\_ip](#output\_application\_instance1\_ip) | n/a |
| <a name="output_application_instance2_ip"></a> [application\_instance2\_ip](#output\_application\_instance2\_ip) | n/a |
