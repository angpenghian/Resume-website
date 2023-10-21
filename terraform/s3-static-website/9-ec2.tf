########## EC2 instance ##########
### Masternode Server
resource "aws_eip_association" "masternote_eip_assoc" {
    instance_id   = aws_instance.masternode_server.id
    allocation_id = aws_eip.masternode_eip.id
    }
    resource "aws_instance" "masternode_server" {
    ami                    = var.ami
    instance_type          = var.instance_type
    key_name               = var.key_name
    vpc_security_group_ids = [aws_security_group.resume_sg.id]
    subnet_id              = aws_subnet.masternode_subnet.id
    user_data              = file("bash_scripts/install-jenkins.sh")

    tags = {
        Name = "masternode_server_terraform"
    }
    }
    resource "aws_eip" "masternode_eip" {
    instance = aws_instance.masternode_server.id
    domain   = "vpc"
}