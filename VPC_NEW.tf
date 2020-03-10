provider "aws" {
 region = "us-east-1"
}

# resource for the VPC 

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

tags {
Name = "dev-acs-test-us-east-1"
}
}

#  resource for the internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

tags {
Name = "dev-acs-test-igw"
}
}

# resource for the security groups 

resource "aws_security_group" "security" {
  name        = "region"
  description = "Open access within this region"
  vpc_id      = "${aws_vpc.vpc.id}"

tags {
Name = "dev-acs-test-security"
}
  ingress {
    from_port   = 0
    to_port     = 0	
    protocol    = -1
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
  }
}

# resources for the route table 

resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "56.78.0.0/16"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "dev-acs-test-routetable"
  }
}


# resources for the creating public subnets 

resource "aws_subnet" "publicsubnet1" {
  cidr_block        = "10.0.10.0/22"
  vpc_id            = "${aws_vpc.vpc.id}"

tags = {
Name = "dev-acs-test-publicsubnet1"
}
}

resource "aws_route_table_association" "plublicsubnet1" {
  subnet_id      = "${aws_subnet.publicsubnet1.id}"
  route_table_id = "${aws_route_table.route.id}"
}

resource "aws_subnet" "publicsubnet2" {
  cidr_block        = "10.0.100.0/22"
  vpc_id            = "${aws_vpc.vpc.id}"

tags = {
Name = "dev-acs-test-publicsubnet2"
}
}

resource "aws_route_table_association" "plublicsubnet2" {
  subnet_id      = "${aws_subnet.publicsubnet2.id}"
  route_table_id = "${aws_route_table.route.id}"
}


# create a private subnets 


resource "aws_subnet" "privatesubnet1" {
  cidr_block        = "10.0.110.0/22"
  vpc_id            = "${aws_vpc.vpc.id}"

tags = {
Name = "dev-acs-test-privatesubnet1"
}
}

resource "aws_subnet" "privatesubnet2" {
  cidr_block        = "10.0.120.0/22"
  vpc_id            = "${aws_vpc.vpc.id}"

tags = {
Name = "dev-acs-test-privatesubnet2"
}
}

