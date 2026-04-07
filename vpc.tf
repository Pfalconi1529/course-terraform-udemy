resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virgina_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }
}


resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "private_subnet-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

/*================================
                                    route table
=================================*/

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

/*====================================
                                  security group
======================================*/

resource "aws_security_group" "sg_public_instance" {
  name        = "Public intance SG"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public intance SG-${local.sufix}"
  }
}

module "mybucket" {
  source      = "./modules/s3"
  bucket_name = "nombreunico123456789152515291529"
}

output "s3_arn" {
  value = module.mybucket.s3_backet_arn
}

# module "terraform_state_backend" {
#   source = "cloudposse/tfstate-backend/aws"
#   version    = "1.9.0"
#   namespace  = "example_12345678"
#   stage      = "prod"
#   name       = "terraform"
#   attributes = ["state"]
#   environment = "us-east-1"
#   terraform_backend_config_file_path = "."
#   terraform_backend_config_file_name = "backend.tf"
#   force_destroy                      = false
# }

