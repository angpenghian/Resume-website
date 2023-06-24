########## Define the AWS route table ##########
resource "aws_route_table" "resume_route_table" {
  vpc_id = aws_vpc.resume_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.resume_gw.id
  }
}

# Define the AWS route table association to subnet 
resource "aws_route_table_association" "masternode_link_route_table" {
  subnet_id      = aws_subnet.masternode_subnet.id
  route_table_id = aws_route_table.resume_route_table.id
}

resource "aws_route_table_association" "node01_link_route_table" {
  subnet_id      = aws_subnet.node01_subnet.id
  route_table_id = aws_route_table.resume_route_table.id
}

resource "aws_route_table_association" "node02_link_route_table" {
  subnet_id      = aws_subnet.node02_subnet.id
  route_table_id = aws_route_table.resume_route_table.id
}

resource "aws_route_table_association" "jenkins_link_route_table" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.resume_route_table.id
}

resource "aws_route_table_association" "sonarqube_link_route_table" {
  subnet_id      = aws_subnet.sonarqube_subnet.id
  route_table_id = aws_route_table.resume_route_table.id
}