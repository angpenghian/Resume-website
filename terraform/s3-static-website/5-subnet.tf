########## Subnet ##########
resource "aws_subnet" "masternode_subnet" {
    vpc_id            = aws_vpc.resume_vpc.id
    cidr_block        = "10.0.0.0/19"
    availability_zone = "ap-southeast-1a"

    tags = {
        Name = "masternode_subnet_terraform"
    }
}