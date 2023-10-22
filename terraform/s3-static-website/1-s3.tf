resource "aws_s3_bucket" "angpenghian-s3" {
    bucket = "angpenghian-s3"

    tags = {
        Name = var.environment
    }
}

resource "aws_s3_bucket_policy" "angpenghian-s3-policy" {
  bucket = aws_s3_bucket.angpenghian-s3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.angpenghian-s3.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_ownership_controls" "resume-s3-ownership-controls" {
  bucket = aws_s3_bucket.angpenghian-s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "resume-s3-public-access-block" {
  bucket = aws_s3_bucket.angpenghian-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "angpenghian-s3-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.resume-s3-ownership-controls,
    aws_s3_bucket_public_access_block.resume-s3-public-access-block,
  ]

  bucket = aws_s3_bucket.angpenghian-s3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "angpenghian-s3-versioning" {
  bucket = aws_s3_bucket.angpenghian-s3.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "angpenghian-s3-website" {
  bucket = aws_s3_bucket.angpenghian-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}