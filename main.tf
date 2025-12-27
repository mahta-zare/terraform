provider "aws" {
  region = "ca-west-1"
}

variable "cidr_blocks" {
  description = "cidr block and name tags for vpc and subnet"
  type = list(object({
    cidr_block = string,
    name = string
  }))
}


resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name: var.cidr_blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = "ca-west-1a"
  tags = {
    Name: var.cidr_blocks[1].name
  }
}