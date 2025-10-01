resource "aws_sqs_queue" "sqs-video-processing" {
  name = "sqs-video-processing"
}

resource "aws_sqs_queue" "sqs-video-manager-api" {
  name = "sqs-video-manager-api"
}

resource "aws_sqs_queue_policy" "sqs-video-processing-policy" {
  queue_url = aws_sqs_queue.sqs-video-processing.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.sqs-video-processing.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.sns-video-manager-api.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "sqs-video-manager-api-policy" {
  queue_url = aws_sqs_queue.sqs-video-manager-api.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.sqs-video-manager-api.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.sns-video-processing.arn
          }
        }
      }
    ]
  })
}

