#VPC creation
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "dev_vpc"
    Environment = "development"
  }
}

# Private subnets
resource "aws_subnet" "dev_private" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.subnets_cidr[0]

  tags = {
    Name        = "dev_private_subnet"
    Environment = "development"
    Access      = "private"
  }
}

# Public subnets
resource "aws_subnet" "dev_public" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.subnets_cidr[1]

  tags = {
    Name        = "dev_public_subnet"
    Environment = "development"
    Access      = "public"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name        = "dev_vpc_Internet_Gateway"
    Environment = "development"
  }
}

resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "route_table_internet_gateway"
    Environment = "development"
  }
}

resource "aws_route_table_association" "dev_public_rta" {
  subnet_id      = aws_subnet.dev_public.id
  route_table_id = aws_route_table.dev_public_rt.id
}


# NAT Gateway
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name        = "dev_nat_eip"
    Environment = "development"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.dev_public.id

  tags = {
    Name        = "dev_nat_gateway"
    Environment = "development"
  }
}

resource "aws_route_table" "dev_private_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name        = "route_table_nat_gateway"
    Environment = "development"
  }
}

resource "aws_route_table_association" "dev_private_rta" {
  subnet_id      = aws_subnet.dev_private.id
  route_table_id = aws_route_table.dev_private_rt.id
}
