packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.2"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = "amazon-linux"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "amazon/al2023-ami-2023*x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"
}

build {
  name = "vpn-rkn"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]
  provisioner "ansible" {
    playbook_file = "playbook.yml"
    user          = "ec2-user"
  }
}
