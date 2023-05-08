data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

provider "aws" {
  region = "us-east-1"
}

# Spoke VPC
resource "aws_vpc" "spoke_vpc" {
  cidr_block           = var.spoke_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "spoke-vpc"
  }
}

# IGW associated with spoke VPC
resource "aws_internet_gateway" "spoke_vpc_igw" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags = {
    "Name" = "igw-1"
  }
}
/*
resource "aws_internet_gateway_attachment" "spoke_vpc_igw_attach" {
  vpc_id = aws_vpc.spoke_vpc.id
  internet_gateway_id = aws_internet_gateway.spoke_vpc_igw.id
}
*/

#Subnets
resource "aws_subnet" "application_subnet_1" {
  availability_zone       = var.az1
  cidr_block              = var.application_subnet1_cidr
  vpc_id                  = aws_vpc.spoke_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "application-subnet-1"
  }
}

resource "aws_subnet" "gwlbe_subnet_1" {
  availability_zone       = var.az1
  cidr_block              = var.gwlbe_subnet1_cidr
  vpc_id                  = aws_vpc.spoke_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "gwlbe-subnet-1"
  }
}

resource "aws_subnet" "application_subnet_2" {
  availability_zone       = var.az2
  cidr_block              = var.application_subnet2_cidr
  vpc_id                  = aws_vpc.spoke_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "application-subnet-2"
  }
}

resource "aws_subnet" "gwlbe_subnet_2" {
  availability_zone       = var.az2
  cidr_block              = var.gwlbe_subnet2_cidr
  vpc_id                  = aws_vpc.spoke_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "gwlbe-subnet-2"
  }
}

# Route Table and subnet association:
#AZ1
resource "aws_route_table" "application_route_table_1" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags = {
    Name = "application-rtb-1"
  }
}

resource "aws_route_table_association" "app_subnet_1_route_table_association" {
  subnet_id      = aws_subnet.application_subnet_1.id
  route_table_id = aws_route_table.application_route_table_1.id
}

resource "aws_route_table" "gwlbe_route_table_1" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags = {
    Name = "gwlbe-rtb-1"
  }
}

resource "aws_route" "gwlbe_route_1" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.spoke_vpc_igw.id
  route_table_id         = aws_route_table.gwlbe_route_table_1.id
}

resource "aws_route_table_association" "gwlbe_subnet_1_route_table_association" {
  subnet_id      = aws_subnet.gwlbe_subnet_1.id
  route_table_id = aws_route_table.gwlbe_route_table_1.id
}

#AZ2
resource "aws_route_table" "application_route_table_2" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags = {
    Name = "application-rtb-2"
  }
}

resource "aws_route_table_association" "app_subnet_2_route_table_association" {
  subnet_id      = aws_subnet.application_subnet_2.id
  route_table_id = aws_route_table.application_route_table_2.id
}

resource "aws_route_table" "gwlbe_route_table_2" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags = {
    Name = "gwlbe-rtb-2"
  }
}

resource "aws_route" "gwlbe_route_2" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.spoke_vpc_igw.id
  route_table_id         = aws_route_table.gwlbe_route_table_2.id
}

resource "aws_route_table_association" "gwlbe_subnet_2_route_table_association" {
  subnet_id      = aws_subnet.gwlbe_subnet_2.id
  route_table_id = aws_route_table.gwlbe_route_table_2.id
}

#Ingress route table and association
resource "aws_route_table" "igw_route_table_1" {
  vpc_id = aws_vpc.spoke_vpc.id
  tags = {
    Name = "igw-rtb1"
  }
}

resource "aws_route_table_association" "igw_route_table_association" {
  gateway_id     = aws_internet_gateway.spoke_vpc_igw.id
  route_table_id = aws_route_table.igw_route_table_1.id
}

resource "aws_security_group" "application_sg" {
  name        = "application-sg-1"
  description = "Access to application instance: allow TCP, UDP and ICMP from appropriate location. Allow all traffic from VPC CIDR"
  vpc_id      = aws_vpc.spoke_vpc.id

  ingress {
    cidr_blocks = [var.access_location]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = [var.access_location]
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
  }

  ingress {
    cidr_blocks = [var.access_location]
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
  }

  ingress {
    cidr_blocks = [var.spoke_vpc_cidr]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "application-sg-1"
  }
}

resource "aws_vpc_endpoint" "spoke_vpc_ssm_endpoint" {
  vpc_id              = aws_vpc.spoke_vpc.id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.application_sg.id]

  subnet_ids = [
    aws_subnet.application_subnet_1.id,
    aws_subnet.application_subnet_2.id
  ]
}

resource "aws_vpc_endpoint" "spoke_vpc_ec2_messages_endpoint" {
  vpc_id              = aws_vpc.spoke_vpc.id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.application_sg.id]

  subnet_ids = [
    aws_subnet.application_subnet_1.id,
    aws_subnet.application_subnet_2.id
  ]
}

resource "aws_vpc_endpoint" "spoke_vpc_ssm_messages_endpoint" {
  vpc_id              = aws_vpc.spoke_vpc.id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.application_sg.id]

  subnet_ids = [
    aws_subnet.application_subnet_1.id,
    aws_subnet.application_subnet_2.id
  ]
}

resource "aws_iam_role" "application_role" {
  name               = "application-role"
  path               = "/"
  assume_role_policy = file("${path.module}/ec2_assume_role_policy.json")
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

resource "aws_iam_instance_profile" "application_profile" {
  name = aws_iam_role.application_role.name
  path = "/"
  role = aws_iam_role.application_role.name
}

resource "aws_instance" "application_1" {
  ami           = data.aws_ssm_parameter.ami_id.value
  instance_type = var.application_instance_type
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.application_subnet_1.id

  iam_instance_profile = aws_iam_instance_profile.application_profile.name

  vpc_security_group_ids = [
    aws_security_group.application_sg.id
  ]

  tags = {
    Name = "client-1"
  }

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.application_instance_disk_size
  }
  user_data = file("${path.module}/application.sh")
}

resource "aws_instance" "application_2" {
  ami           = data.aws_ssm_parameter.ami_id.value
  instance_type = var.application_instance_type
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.application_subnet_2.id

  iam_instance_profile = aws_iam_instance_profile.application_profile.name

  vpc_security_group_ids = [
    aws_security_group.application_sg.id
  ]

  tags = {
    Name = "client-2"
  }

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.application_instance_disk_size
  }
  user_data = file("${path.module}/application.sh")
}

#GWLB endpoints
resource "aws_vpc_endpoint" "gwlb_vpc_endpoint_1" {
  vpc_id            = aws_vpc.spoke_vpc.id
  service_name      = var.vpc_endpoint_service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids = [
    aws_subnet.gwlbe_subnet_1.id
  ]
}

resource "aws_vpc_endpoint" "gwlb_vpc_endpoint_2" {
  vpc_id            = aws_vpc.spoke_vpc.id
  service_name      = var.vpc_endpoint_service_name
  vpc_endpoint_type = "GatewayLoadBalancer"
  subnet_ids = [
    aws_subnet.gwlbe_subnet_2.id
  ]
}

#Add route to route tables
resource "aws_route" "add_route1_application_route_table1" {
  depends_on = [
    aws_vpc_endpoint.gwlb_vpc_endpoint_1
  ]
  destination_cidr_block = var.access_location
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_vpc_endpoint_1.id
  route_table_id         = aws_route_table.application_route_table_1.id
}

resource "aws_route" "add_route2_application_route_table2" {
  depends_on = [
    aws_vpc_endpoint.gwlb_vpc_endpoint_2
  ]
  destination_cidr_block = var.access_location
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_vpc_endpoint_2.id
  route_table_id         = aws_route_table.application_route_table_2.id
}

resource "aws_route" "add_application1_igw_route_table" {
  depends_on = [
    aws_vpc_endpoint.gwlb_vpc_endpoint_1
  ]
  destination_cidr_block = var.application_subnet1_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_vpc_endpoint_1.id
  route_table_id         = aws_route_table.igw_route_table_1.id
}

resource "aws_route" "add_application2_igw_route_table" {
  depends_on = [
    aws_vpc_endpoint.gwlb_vpc_endpoint_2
  ]
  destination_cidr_block = var.application_subnet2_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_vpc_endpoint_2.id
  route_table_id         = aws_route_table.igw_route_table_1.id
}