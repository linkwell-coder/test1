provider "aws" {
 region = "us-east-1"
}

# creating the VPC file 

resource "aws_vpc" "example"{
cidr_block = "190.255.0.0/16"
instance_tenancy = "default"

tags{
Name = "dev-link-user-VPC"
}
}

# Create the internet gateway

resource "aws_internet_gateway" "Igw" {
  vpc_id = "${aws_vpc.example.id}"

  tags = {
    Name = "dev-link-user-igw"
  }
}

# create a route table 


resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.example.id}"

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags = {
    Name = "dev-link-user-routetable"
  }
}

# create a public subnets one 

resource "aws_subnet" "publicSubnet1" {
  vpc_id     = "${aws_vpc.example.id}"
  cidr_block = "190.255.1.1/24"

  tags = {
    Name = "dev-link-user-publicsubnet1"
  }
}

# create a public subnets two 

resource "aws_subnet" "publicSubnet2" {
  vpc_id     = "${aws_vpc.example.id}"
  cidr_block = "190.255.1.2/24"

  tags = {
    Name = "dev-link-user-publicsubnet2"
  }
}


# create a private subnet one 

resource "aws_subnet" "privateSubnet1" {
  vpc_id     = "${aws_vpc.example.id}"
  cidr_block = "190.255.1.3/24"

  tags = {
    Name = "dev-link-user-privatesubnet1"
  }
}


# create a private subnets two

resource "aws_subnet" "privateSubnet1" {
  vpc_id     = "${aws_vpc.example.id}"
  cidr_block = "190.255.1.4/24"

  tags = {
    Name = "dev-link-user-privatesubnet2"
  }
}



