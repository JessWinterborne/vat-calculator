terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = [var.creds_file]
  region = "us-west-2"
}

variable creds_file {}

resource "aws_instance" "docker_server" {
  ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.medium"
  subnet_id = "the same subnet id as your lab instance – can be found via AWS console"
  vpc_security_group_ids = ["the same security group id as your lab instance"]
  tags = {
    Name = "DockerServer"
  }
  user_data = "${file("init.sh")}"
}
