# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block =   var.k8slabVPC
}

# Create a public subnet with an Internet Gateway
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.k8slabPublicSN  # Adjust the CIDR block as needed
  availability_zone       = var.k8slabAZ  # Change to your desired availability zone

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_route_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.k8slabPrivateSN  # Adjust the CIDR block as needed
  availability_zone       = var.k8slabAZ # Change to your desired availability zone

  tags = {
    Name = "Private Subnet"
  }
}

# Create a NAT Gateway for the private subnet
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "my_eip" {}

# Create a route table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "private_subnet_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gateway.id
}

resource "aws_route_table_association" "private_route_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

output "subnetid" {
  value = aws_subnet.private_subnet.id
}