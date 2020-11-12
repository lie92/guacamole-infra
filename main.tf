terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
  shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}

#variables
variable "subnet_id" {
  type    = string
  default = "subnet-03103193c4cc782bc"
}

#ressources
resource "aws_instance" "vm1" {
  ami           = "ami-0de12f76efe134f2f"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.nic1[count.index].id
    device_index         = 0
  }

  key_name = "conduent1.key"
  count = 12
}

resource "aws_network_interface" "nic1" {
  subnet_id   = var.subnet_id
  security_groups = ["sg-01852d2df0828a402"]
  count = 12
}