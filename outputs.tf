output "SQS_VIDEO_FILES_QUEUE_URL" {
  description = "URL da fila SQS de arquivos de vídeo"
  value       = aws_sqs_queue.sqs-video-files.id
}

output "SNS_VIDEO_FILES_TOPIC_ARN" {
  description = "ARN do tópico SNS video-files"
  value       = aws_sns_topic.video-files.arn
}

output "S3_VIDEO_FILES_BUCKET_NAME" {
  description = "Nome do bucket S3 de arquivos de vídeo"
  value       = aws_s3_bucket.fiap_video_files.bucket
}

output "S3_VIDEO_FILES_BUCKET_ARN" {
  description = "ARN do bucket S3 de arquivos de vídeo"
  value       = aws_s3_bucket.fiap_video_files.arn
}
