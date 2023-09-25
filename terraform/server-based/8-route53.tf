########## Route53 ##########
resource "aws_route53_zone" "resume_hosted_zone" {
  name = var.domain
}

# Define the AWS Route53 Record for domain's A record
resource "aws_route53_record" "angpenghian" {
  zone_id = aws_route53_zone.resume_hosted_zone.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.resume_alb.dns_name
    zone_id                = aws_lb.resume_alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "jenkins_angpenghian" {
  count   = var.create_jenkins_server_and_route53_rule ? 1 : 0
  zone_id = aws_route53_zone.resume_hosted_zone.zone_id
  name    = "jenkins.angpenghian.com"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.jenkins_server_eip[0].public_ip]

  depends_on = [aws_eip_association.jenkins_server_eip_assoc]
}

# resource "aws_route53_record" "sonarqube_angpenghian" {
#   count   = var.create_sonarqube_server_and_route53_rule ? 1 : 0
#   zone_id = aws_route53_zone.resume_hosted_zone.zone_id
#   name    = "sonarqube.angpenghian.com"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_eip.sonarqube_server_eip[0].public_ip]

#   depends_on = [aws_eip_association.sonarqube_server_eip_assoc]
# }

resource "aws_route53domains_registered_domain" "angpenghian_registered_domain" {
  domain_name = var.domain

  name_server {
    name = aws_route53_zone.resume_hosted_zone.name_servers[0]
  }

  name_server {
    name = aws_route53_zone.resume_hosted_zone.name_servers[1]
  }

  name_server {
    name = aws_route53_zone.resume_hosted_zone.name_servers[2]
  }

  name_server {
    name = aws_route53_zone.resume_hosted_zone.name_servers[3]
  }

  tags = {
    Environment = "resume_terraform"
  }
}