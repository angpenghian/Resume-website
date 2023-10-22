resource "aws_route53_zone" "resume_hosted_zone" {
    name = var.domain
}

resource "aws_route53_record" "angpenghian" {
    zone_id = aws_route53_zone.resume_hosted_zone.zone_id
    name    = var.domain
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.resume_cloudfront.domain_name
        zone_id                = aws_cloudfront_distribution.resume_cloudfront.hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "masternode_angpenghian" {
    zone_id = aws_route53_zone.resume_hosted_zone.zone_id
    name    = "jenkins.angpenghian.com"
    type    = "A"
    ttl     = "300"
    records = [aws_eip.masternode_eip.public_ip]

    depends_on = [aws_eip_association.masternote_eip_assoc]
}

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
        Name = var.environment
    }
}