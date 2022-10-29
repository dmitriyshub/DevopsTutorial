// Creating private S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
      Name = "my-bucket"
      Pro = var.my_tag
      Env = var.my_tag_env
  }
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

// Block Public Access
resource "aws_s3_bucket_public_access_block" "s3BlockPublicAccess" {
  bucket = "${aws_s3_bucket.my_bucket.id}"

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
}

//
locals {
  s3_origin_id = aws_s3_bucket.my_bucket.id
}