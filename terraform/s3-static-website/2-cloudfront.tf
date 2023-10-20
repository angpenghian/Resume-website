resource "aws_cloudfront_distribution" "resume_cloudfront" {
    origin {
        domain_name = aws_s3_bucket.angpenghian-s3.bucket_regional_domain_name
        origin_id   = aws_s3_bucket.angpenghian-s3.id

        custom_origin_config {
            http_port              = 80
            https_port             = 443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols   = ["TLSv1.2"]
        }
    }

    enabled             = true
    is_ipv6_enabled     = false
    aliases             = [var.domain]
    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.angpenghian-s3.bucket_domain_name

        viewer_protocol_policy = "redirect-to-https"
        default_ttl = 0
        min_ttl     = 0
        max_ttl     = 0

        forwarded_values {
            query_string = false
            headers      = ["*"]
            cookies {
                forward = "none"
            }
        }
    }

    viewer_certificate {
        acm_certificate_arn      = var.certificate_arn2
        ssl_support_method       = "sni-only"
        minimum_protocol_version = "TLSv1.2_2018"
    }

    price_class = "PriceClass_200"
    restrictions {
        geo_restriction {
            restriction_type = "whitelist"
            locations        = ["US", "CA", "GB", "SG"]
        }
    }

    tags = {
        Name = var.environment
    }
}
