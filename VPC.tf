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

# create a public subnets

resource "aws_subnet" "publicSubnet1" {
  vpc_id     = "${aws_vpc.example.id}"
  cidr_block = "190.255.1.1/24"

  tags = {
    Name = "dev-link-user-publicsubnet1"
  }
}
