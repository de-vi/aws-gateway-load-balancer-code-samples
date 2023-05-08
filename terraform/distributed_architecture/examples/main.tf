provider "aws" {
  region = "us-east-1"
}

module "appliance" {
  source        = "../modules/gwlb_appliance"
  az1           = var.az1
  az2           = var.az2
  key_pair_name = var.key_pair_name
}

module "application" {
  source                         = "../modules/spoke_application"
  spoke_vpc_cidr                 = var.spoke_vpc_cidr
  az1                            = var.az1
  az2                            = var.az2
  key_pair_name                  = var.key_pair_name
  application_subnet1_cidr       = var.application_subnet1_cidr
  application_subnet2_cidr       = var.application_subnet2_cidr
  gwlbe_subnet1_cidr             = var.gwlbe_subnet1_cidr
  gwlbe_subnet2_cidr             = var.gwlbe_subnet2_cidr
  application_instance_type      = var.application_instance_type
  application_instance_disk_size = var.application_instance_disk_size
  vpc_endpoint_service_name      = module.appliance.appliance_vpc_endpoint_service_id
  access_location                = var.access_location
}