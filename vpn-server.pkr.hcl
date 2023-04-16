packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = "amazon-linux"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.0.20230329.0-kernel-6.1-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners = ["137112412989"]
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
    extra_arguments = [
      "--connection=ssh"
    ]
  }
}
