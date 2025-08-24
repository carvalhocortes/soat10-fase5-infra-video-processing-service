resource "aws_sqs_queue" "sqs-video-files" {
  name = "sqs-video-files"
}

resource "aws_sqs_queue_policy" "sqs-video-files-policy" {
  queue_url = aws_sqs_queue.sqs-video-files.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.sqs-video-files.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.video-files.arn
          }
        }
      }
    ]
  })
}

