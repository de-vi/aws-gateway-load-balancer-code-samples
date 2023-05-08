data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_vpc" "appliance_vpc" {
  cidr_block           = var.appliance_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "appliance-vpc"
  }
}

resource "aws_internet_gateway" "appliance_igw" {
  tags = {
    Name = "appliance-vpc-igw"
  }
}

resource "aws_internet_gateway_attachment" "appliance_vpc_igw_attach" {
  vpc_id              = aws_vpc.appliance_vpc.id
  internet_gateway_id = aws_internet_gateway.appliance_igw.id
}

# PUblic subnets
resource "aws_subnet" "public_subnet1" {
  availability_zone       = var.az1
  cidr_block              = var.public_subnet1_cidr
  vpc_id                  = aws_vpc.appliance_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "appliance-subnet-1"
  }
}

resource "aws_subnet" "public_subnet2" {
  availability_zone       = var.az2
  cidr_block              = var.public_subnet2_cidr
  vpc_id                  = aws_vpc.appliance_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "appliance-subnet-2"
  }
}

# Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.appliance_vpc.id
  tags = {
    Name = "appliance-rtb-1"
  }
}

resource "aws_route" "public_route" {
  depends_on = [
    aws_internet_gateway_attachment.appliance_vpc_igw_attach
  ]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.appliance_igw.id
  route_table_id         = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Appliance Security Group
resource "aws_security_group" "appliance_sg" {
  name_prefix = "appliance-sg-1"
  vpc_id      = aws_vpc.appliance_vpc.id
  description = "Access ro appliance instance: allow SSH and ICMP access from desired CIDR. Allow all traffic from VPC CIDR"
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.access_location]
  }
  ingress {
    description = "ICMP Access"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.access_location]
  }
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.access_location]
  }
  ingress {
    description = "Allow all traffic from VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.access_location]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "appliance-sg-1"
  }
}

# Gateway Load Balancer (GWLB), Target Group, Listener
resource "aws_lb" "gwlb" {
  name               = var.gwlb_name
  internal           = false
  load_balancer_type = "gateway"
  subnets = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id
  ]
  tags = {
    Name = "gwlb-1"
  }
}

resource "aws_lb_target_group" "target_group" {
  name                 = var.target_group_name
  port                 = 6081
  protocol             = "GENEVE"
  vpc_id               = aws_vpc.appliance_vpc.id
  target_type          = "instance"
  deregistration_delay = 20
  health_check {
    port     = var.health_port
    protocol = var.health_protocol
  }
  tags = {
    Name = "tg-1"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.gwlb.arn
  #port = 6081
  #protocol = "GENEVE"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

# Private link
resource "aws_vpc_endpoint" "appliance_vpc_ssm_endpoint" {
  vpc_id              = aws_vpc.appliance_vpc.id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.appliance_sg.id
  ]
  subnet_ids = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id
  ]
}

resource "aws_vpc_endpoint" "appliance_vpc_ec2_messages_endpoint" {
  vpc_id              = aws_vpc.appliance_vpc.id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.appliance_sg.id
  ]
  subnet_ids = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id
  ]
}

resource "aws_vpc_endpoint" "appliance_vpc_ssm_messages_endpoint" {
  vpc_id              = aws_vpc.appliance_vpc.id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.appliance_sg.id
  ]
  subnet_ids = [
    aws_subnet.public_subnet1.id,
    aws_subnet.public_subnet2.id
  ]
}


#IAM instance role and profile
resource "aws_iam_role" "appliance_role" {
  name               = "appliance-role"
  path               = "/"
  assume_role_policy = file("${path.module}/ec2_assume_role_policy.json")
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.appliance_policy.arn
  ]
}

resource "aws_iam_policy" "appliance_policy" {
  name = "appServer"

  policy = jsonencode({
    Statement = [
      {
        Action   = "ec2:DescribeNetworkInterfaces"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "appliance_policy_attachment" {
  policy_arn = aws_iam_policy.appliance_policy.arn
  role       = aws_iam_role.appliance_role.name
}

resource "aws_iam_instance_profile" "appliance_profile" {
  name = "appliance_instance_profile"
  path = "/"
  role = aws_iam_role.appliance_role.name
}

resource "aws_instance" "appliance1" {
  depends_on           = [aws_lb.gwlb]
  ami                  = data.aws_ssm_parameter.ami_id.value
  instance_type        = var.appliance_instance_type
  key_name             = var.key_pair_name
  iam_instance_profile = aws_iam_instance_profile.appliance_profile.name
  vpc_security_group_ids = [
    aws_security_group.appliance_sg.id
  ]
  subnet_id = aws_subnet.public_subnet1.id
  tags = {
    Name = "appliance-1"
  }

  root_block_device {
    volume_size = var.appliance_instance_disk_size
  }

  user_data = templatefile("${path.module}/appliance.sh.tftpl", { gwlb_target = "appliance1" })
}

resource "aws_instance" "appliance2" {
  depends_on           = [aws_lb.gwlb]
  ami                  = data.aws_ssm_parameter.ami_id.value
  instance_type        = var.appliance_instance_type
  key_name             = var.key_pair_name
  iam_instance_profile = aws_iam_instance_profile.appliance_profile.name
  vpc_security_group_ids = [
    aws_security_group.appliance_sg.id
  ]
  subnet_id = aws_subnet.public_subnet2.id
  tags = {
    Name = "appliance-2"
  }

  root_block_device {
    volume_size = var.appliance_instance_disk_size
  }

  user_data = templatefile("${path.module}/appliance.sh.tftpl", { gwlb_target = "appliance2" })

}

resource "aws_vpc_endpoint_service" "vpc_endpoint_service" {
  gateway_load_balancer_arns = [aws_lb.gwlb.arn]
  acceptance_required        = var.connection_acceptance
}

resource "aws_lb_target_group_attachment" "appliance1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.appliance1.id
  port             = 6081
}

resource "aws_lb_target_group_attachment" "appliance2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.appliance2.id
  port             = 6081
}

/*
resource "aws_vpc_endpoint_service_allowed_principal" "vpc_endpoint_service_permissions" {
    vpc_endpoint_service_id = aws_vpc_endpoint_service.vpc_endpoint_service.id
   # principal_arn = var.aws_account_to_whitelist
}
*/