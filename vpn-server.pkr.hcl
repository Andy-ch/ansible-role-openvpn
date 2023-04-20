packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = "vpn-rkn"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami    = "ami-022daa15b37b5e55d"
  ssh_username  = "ec2-user"
}

build {
  name = "vpn-rkn"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]
  provisioner "ansible" {
    playbook_file = "playbook.yml"
    user          = "ec2-user"
    use_proxy     = false
    extra_arguments = [
      "-vvv",
      "--connection=paramiko",
      "-e",
      "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}
