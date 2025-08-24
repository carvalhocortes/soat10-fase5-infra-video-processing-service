resource "aws_ssm_parameter" "video_sqs_id" {
  name        = "/soat10/infra-video-manager/video_sqs_id"
  description = "URL da fila SQS de arquivos de vídeo"
  type        = "String"
  value       = aws_sqs_queue.sqs-video-files.id
}

resource "aws_ssm_parameter" "video_sns_topic_arn" {
  name        = "/soat10/infra-video-manager/video_sns_topic_arn"
  description = "ARN do tópico SNS de arquivos de vídeo"
  type        = "String"
  value       = aws_sns_topic.video-files.arn

}

resource "aws_ssm_parameter" "video_bucket_name" {
  name        = "/soat10/infra-video-manager/video_bucket_name"
  description = "Nome do bucket S3 de arquivos de vídeo"
  type        = "String"
  value       = aws_s3_bucket.fiap_video_files.bucket
}

resource "aws_ssm_parameter" "video_bucket_arn" {
  name        = "/soat10/infra-video-manager/video_bucket_arn"
  description = "ARN do bucket S3 de arquivos de vídeo"
  type        = "String"
  value       = aws_s3_bucket.fiap_video_files.arn
}
