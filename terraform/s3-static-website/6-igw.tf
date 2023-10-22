########## internet gateway ##########
resource "aws_internet_gateway" "resume_gw" {
    vpc_id = aws_vpc.resume_vpc.id

    tags = {
        Name = var.environment
    }
}