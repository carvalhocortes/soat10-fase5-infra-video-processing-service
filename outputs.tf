output "SQS_VIDEO_FILES_QUEUE_URL" {
  description = "URL da fila SQS de arquivos de vídeo"
  value       = aws_sqs_queue.sqs-video-files.id
}


output "SNS_VIDEO_FILES_TOPIC_ARN" {
  description = "ARN do tópico SNS video-files"
  value       = aws_sns_topic.video-files.arn
}
