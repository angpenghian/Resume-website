########## ALB ##########
resource "aws_lb_target_group" "resume_target_group" {
  name     = "resume-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.resume_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/index.html"
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group_attachment" "masternote_attach_1" {
  target_group_arn = aws_lb_target_group.resume_target_group.arn
  target_id        = aws_instance.masternode_server.id
  port             = 30080
}

# resource "aws_lb_target_group_attachment" "node01_attach_2" {
#   target_group_arn = aws_lb_target_group.resume_target_group.arn
#   target_id        = aws_instance.node01_server.id
#   port             = 30080
# }



resource "aws_lb" "resume_alb" {
  name               = "resume-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.resume_sg.id]
  subnets            = [aws_subnet.masternode_subnet.id, aws_subnet.node01_subnet.id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "listener_443" {
  load_balancer_arn = aws_lb.resume_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.resume_target_group.arn
  }
}

resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.resume_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
