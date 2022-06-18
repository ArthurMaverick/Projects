resource "aws_s3_bucket" "tf_bucket_state" { 
    bucket = var.bucket_name
    force_destroy = true

    lifecycle {
      prevent_destroy = false
    }
    tags = {
      Project  = var.bucket_name
  }
}

resource "aws_s3_bucket_acl" "acl_mode" {
  acl = "private"
  bucket = aws_s3_bucket.tf_bucket_state.id
}