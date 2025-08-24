resource "aws_s3_bucket" "fiap_video_files" {
  bucket = "postech-soat10-bucket-video-files"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "fiap_video_files_block" {
  bucket = aws_s3_bucket.fiap_video_files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "fiap_video_files_versioning" {
  bucket = aws_s3_bucket.fiap_video_files.id

  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fiap_video_files_sse" {
  bucket = aws_s3_bucket.fiap_video_files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
