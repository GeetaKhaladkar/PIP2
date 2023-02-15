
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "MY-VPC"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "MY-PUBLIC-SUBNET1"
  }
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "MY-PUBLIC-SUBNET2"
  }
}
resource "aws_subnet" "prisub1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "MY-PRIVATE-SUBNET1"
  }
}
resource "aws_subnet" "prisub2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.32.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "MY-PRIVATE-SUBNET2"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    "Name" = "MY-IGW"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "MY-PUBLIC-RT"
  }
}


resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.public-rt.id
}


