// AWS Bucket Policy for CloudFront
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.my_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.my_bucket.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3BucketPolicy" {
  bucket = "${aws_s3_bucket.my_bucket.id}"
  policy = "${data.aws_iam_policy_document.s3_policy.json}"
}

//
resource "aws_s3_object" "bucketObject" {
  for_each = fileset("/home/dimash/Downloads/assets", "**/*.jpg")
  bucket = "${aws_s3_bucket.my_bucket.bucket}"
  key    = each.value
  source = "/home/dimash/Downloads/assets/${each.value}"
  content_type = "image/jpg"
}