########## Subnet ##########
resource "aws_subnet" "masternode_subnet" {
  vpc_id            = aws_vpc.resume_vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "masternode_subnet_terraform"
  }
}

resource "aws_subnet" "node01_subnet" {
  vpc_id            = aws_vpc.resume_vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "node01_subnet_terraform"
  }
}

resource "aws_subnet" "node02_subnet" {
  vpc_id            = aws_vpc.resume_vpc.id
  cidr_block        = "10.0.64.0/19"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "node02_subnet_terraform"
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id            = aws_vpc.resume_vpc.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "jenkins_subnet_terraform"
  }
}

resource "aws_subnet" "sonarqube_subnet" {
  vpc_id            = aws_vpc.resume_vpc.id
  cidr_block        = "10.0.128.0/19"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "sonarqube_subnet_terraform"
  }
}