
output "SQS_VIDEO_FILES_QUEUE_URL" {
  description = "URL da fila SQS de arquivos de vídeo"
  value       = aws_sqs_queue.sqs-video-files.id
}


output "SNS_VIDEO_FILES_TOPIC_ARN" {
  description = "ARN do tópico SNS video-files"
  value       = aws_sns_topic.video-files.arn
}

output "SES-DKIM-TOKENS" {
  description = "DKIM tokens (create CNAMEs for each token pointing to <token>.dkim.amazonses.com)"
  value       = aws_ses_domain_dkim.dkim.dkim_tokens
}

output "SES-DOMAIN-VERIFICATION-TOKEN" {
  description = "TXT token to add at _amazonses.<domain> for domain verification"
  value       = aws_ses_domain_identity.domain.verification_token
}

output "SES-FROM-ADDRESS-VERIFICATION" {
  description = "Email identity verification status (true when verified). Note: SES sends a verification email to the address."
  value       = aws_ses_email_identity.from_address.arn
}
