resource "aws_s3_bucket" "website" {
  bucket = "${local.name_prefix}-website"
  tags   = local.tags
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy     = data.aws_iam_policy_document.cloudfront_oac_access.json
  depends_on = [aws_s3_bucket_public_access_block.website]
}
