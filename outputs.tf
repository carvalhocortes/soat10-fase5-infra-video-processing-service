output "SQS_VIDEO_FILES_QUEUE_URL" {
  description = "URL da fila SQS de arquivos de vídeo"
  value       = aws_sqs_queue.sqs-video-files.id
}

output "SNS_VIDEO_FILES_TOPIC_ARN" {
  description = "ARN do tópico SNS de arquivos de vídeo"
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

output "EKS_CLUSTER_ROLE_ARN" {
  description = "ARN da role IAM do cluster EKS"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "EKS_NODE_GROUP_ROLE_ARN" {
  description = "ARN da role IAM do node group EKS"
  value       = aws_iam_role.eks_node_group_role.arn
}
