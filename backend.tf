resource "aws_s3_bucket" "terraform_state_backend" {
  bucket = "iac-terraform-global-state"

  tags = {
    Name        = "iac-terraform-global-state"
    Environment = "global"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_backend_versioning" {
  bucket = aws_s3_bucket.terraform_state_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_backend_encryption" {
  bucket = aws_s3_bucket.terraform_state_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_backend_public_access" {
  bucket = aws_s3_bucket.terraform_state_backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
