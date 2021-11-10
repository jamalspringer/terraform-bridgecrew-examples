data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "non_compliant" {
	# checkov:skip=CKV_AWS_79: ADD REASON
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
    root_block_device {
    encrypted = true
  }
  monitoring = true
  ebs_optimized = true
}



provider "aws" {
  region = "eu-west-2"
}