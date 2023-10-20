resource "aws_s3_bucket" "angpenghian-s3" {
    bucket = "angpenghian-s3"

    tags = {
        Name = var.environment
    }
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