resource "aws_s3_bucket" "fiap_video_files" {
  bucket = "postech-soat10-bucket-video-file"
}

resource "aws_s3_bucket_acl" "fiap_video_files_acl" {
  bucket = aws_s3_bucket.fiap_video_files.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.fiap_video_files_ownership]
}

resource "aws_s3_bucket_ownership_controls" "fiap_video_files_ownership" {
  bucket = aws_s3_bucket.fiap_video_files.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
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
