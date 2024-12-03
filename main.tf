provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}



resource "aws_vpc" "Django_EC2_VPC" {
#  cidr_block           = "10.0.0.0/16"
#  enable_dns_support   = true
#  enable_dns_hostnames = true
  tags = {
    Name = "Django_EC2_VPC"
  }

  lifecycle {
    prevent_destroy = true
  }
}


# Create VPC
resource "aws_vpc" "my_vpc_241203" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC_241203"
  }
}

# Create Subnet
resource "aws_subnet" "my_subnet_241203" {
  vpc_id                  = aws_vpc.my_vpc_241203.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "MySubnet_241203"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw_241203" {
  vpc_id = aws_vpc.my_vpc_241203.id
  tags = {
    Name = "MyInternetGateway_241203"
  }
}

# Create Route Table
resource "aws_route_table" "my_route_table_241203" {
  vpc_id = aws_vpc.my_vpc_241203.id
  tags = {
    Name = "MyRouteTable_241203"
  }
}

# Create a Route to the Internet
resource "aws_route" "my_route_241203" {
  route_table_id         = aws_route_table.my_route_table_241203.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw_241203.id
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "my_route_table_association_241203" {
  subnet_id      = aws_subnet.my_subnet_241203.id
  route_table_id = aws_route_table.my_route_table_241203.id
}
