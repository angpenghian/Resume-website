########## Security Group ##########
resource "aws_security_group" "resume_sg" {
    name        = "resume_sg"
    description = "Allow inbound traffic on port 443, 80 and 22"
    vpc_id      = aws_vpc.resume_vpc.id

    # Define rules for incoming traffic
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Nginx port
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Jenkins port
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Jenkins port
    ingress {
        from_port   = 8443
        to_port     = 8443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

        # Allow internal instance to talk to each other
    ingress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        self      = true
    }


    # Define rules for outgoing traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Add tags to the Security Group
    tags = {
        Name = var.environment
    }
}