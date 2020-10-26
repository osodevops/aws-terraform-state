resource "aws_s3_bucket" "state_bucket" {
  # e.g. renamed bucket to something like aws-production-<<account-id>>-state
  bucket        = "<<account_name>>-<<account_id>>-tf-state-<<region>>"
  acl           = "private"
  force_destroy = "false"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = "${merge(var.common_tags,
    map("Name", "${substr(var.common_tags["Environment"],0,1)}-${upper(var.common_tags["AccountType"])}-${upper(var.common_tags["Application"])}-S3")
    )}"
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = "${aws_s3_bucket.state_bucket.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}