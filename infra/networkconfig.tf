resource "aws_vpc" "jdoodle_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "My Joodle VPC"
  }
}

resource "aws_subnet" "public_ap_south_1a" {
  vpc_id     = aws_vpc.jdoodle_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Public Subnet ap-south-1a"
  }
}

resource "aws_subnet" "public_ap_south_1b" {
  vpc_id     = aws_vpc.jdoodle_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Public Subnet ap-south-1b"
  }
}

resource "aws_internet_gateway" "jdoodle_igw" {
  vpc_id = aws_vpc.jdoodle_vpc.id

  tags = {
    Name = "Jdoodle - Internet Gateway"
  }
}

resource "aws_route_table" "jdoodle_vpc_public" {
    vpc_id = aws_vpc.jdoodle_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jdoodle_igww.id
    }

    tags = {
        Name = "Jdoodle- Public Subnets Route Table for VPC"
    }
}

resource "aws_route_table_association" "jdoodle_ap-south_1a_public" {
    subnet_id = aws_subnet.public_ap_south_1a.id
    route_table_id = aws_route_table.jdoodle_vpc_public.id
}

resource "aws_route_table_association" "jdoodle_ap-south_1b_public" {
    subnet_id = aws_subnet.public_ap_south_1b.id
    route_table_id = aws_route_table.jdoodle_vpc_public.id
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound connections"
  vpc_id = aws_vpc.jdoodle_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP Security Group"
  }
}