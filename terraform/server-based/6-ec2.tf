########## EC2 instance ##########
### Masternode Server
resource "aws_eip_association" "masternote_eip_assoc" {
  instance_id   = aws_instance.masternode_server.id
  allocation_id = aws_eip.masternode_eip.id
}
resource "aws_instance" "masternode_server" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.resume_sg.id]
  subnet_id              = aws_subnet.masternode_subnet.id
  user_data              = file("bash_scripts/install-docker-kubernetes-master.sh")

  tags = {
    Name = "masternode_server_terraform"
  }
}
resource "aws_eip" "masternode_eip" {
  instance = aws_instance.masternode_server.id
  domain   = "vpc"
}


resource "null_resource" "provision_masternode_server" {
  depends_on = [aws_eip_association.masternote_eip_assoc]
  triggers = {
    instance_id = aws_instance.masternode_server.id
  }
  provisioner "file" {
    source      = "../../website"
    destination = "/home/ec2-user/website/"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = aws_eip.masternode_eip.public_ip
    }
  }

  provisioner "file" {
  source      = "bash_scripts/kubeadm_init.sh"
  destination = "/home/ec2-user/kubeadm_init.sh"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = aws_eip.masternode_eip.public_ip
  }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/kubeadm_init.sh",
      "/home/ec2-user/kubeadm_init.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = aws_eip.masternode_eip.public_ip
    }
  }
}


### Node01 Server
resource "aws_eip_association" "node01_server_eip_assoc" {
  instance_id   = aws_instance.node01_server.id
  allocation_id = aws_eip.node01_server_eip.id
}
resource "aws_instance" "node01_server" {
  ami                    = var.ami
  instance_type          = "t3.small"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.resume_sg.id]
  subnet_id              = aws_subnet.node01_subnet.id
  user_data              = file("bash_scripts/install-docker-kubernetes-node01.sh")

  tags = {
    Name = "node01_server_terraform"
  }
}
resource "aws_eip" "node01_server_eip" {
  instance = aws_instance.node01_server.id
  domain   = "vpc"
}


resource "null_resource" "provision_node01_server" {
  depends_on = [aws_eip_association.node01_server_eip_assoc]
  triggers = {
    instance_id = aws_instance.node01_server.id
  }
  provisioner "file" {
    source      = "../../website"
    destination = "/home/ec2-user/website/"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = aws_eip.node01_server_eip.public_ip
    }
  }
}


## Jenkins Server
resource "aws_instance" "jenkins_server" {
  count = var.create_jenkins_server_and_route53_rule ? 1 : 0

  ami                    = var.ami
  instance_type          = "t3.small"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.resume_sg.id]
  subnet_id              = aws_subnet.jenkins_subnet.id
  user_data              = file("bash_scripts/install-docker-kubernetes-jenkins.sh")

  tags = {
    Name = "jenkins_server_terraform"
  }
}

resource "aws_eip" "jenkins_server_eip" {
  count    = var.create_jenkins_server_and_route53_rule ? 1 : 0
  instance = aws_instance.jenkins_server[0].id
  domain   = "vpc"
}

resource "aws_eip_association" "jenkins_server_eip_assoc" {
  count         = var.create_jenkins_server_and_route53_rule ? 1 : 0
  instance_id   = aws_instance.jenkins_server[0].id
  allocation_id = aws_eip.jenkins_server_eip[0].id
}

resource "null_resource" "provision_jenkins_server" {
  count = var.create_jenkins_server_and_route53_rule ? 1 : 0
  
  depends_on = [aws_eip_association.jenkins_server_eip_assoc]
  
  triggers = {
    instance_id = aws_instance.jenkins_server[0].id
  }

  provisioner "file" {
    source      = "../../website"
    destination = "/home/ec2-user/website/"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = aws_eip.jenkins_server_eip[0].public_ip
    }
  }
}


## Sonareqube Server
# resource "aws_instance" "sonarqube_server" {
#   count = var.create_sonarqube_server_and_route53_rule ? 1 : 0

#   ami                    = var.ami
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   vpc_security_group_ids = [aws_security_group.resume_sg.id]
#   subnet_id              = aws_subnet.sonarqube_subnet.id
#   user_data              = file("bash_scripts/install-docker-kubernetes-sonarqube.sh")

#   tags = {
#     Name = "sonarqube_server_terraform"
#   }
# }

# resource "aws_eip" "sonarqube_server_eip" {
#   count    = var.create_sonarqube_server_and_route53_rule ? 1 : 0
#   instance = aws_instance.sonarqube_server[0].id
#   domain   = "vpc"
# }

# resource "aws_eip_association" "sonarqube_server_eip_assoc" {
#   count         = var.create_sonarqube_server_and_route53_rule ? 1 : 0
#   instance_id   = aws_instance.sonarqube_server[0].id
#   allocation_id = aws_eip.sonarqube_server_eip[0].id
# }

# resource "null_resource" "provision_sonarqube_server" {
#   count = var.create_sonarqube_server_and_route53_rule ? 1 : 0
  
#   depends_on = [aws_eip_association.sonarqube_server_eip_assoc]
  
#   triggers = {
#     instance_id = aws_instance.sonarqube_server[0].id
#   }

#   provisioner "file" {
#     source      = "../../website"
#     destination = "/home/ec2-user/website/"

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.private_key_path)
#       host        = aws_eip.sonarqube_server_eip[0].public_ip
#     }
#   }
# }