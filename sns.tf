resource "aws_sns_topic" "sns-video-processing" {
  name = "sns-video-processing"
}

resource "aws_sns_topic" "sns-video-manager-api" {
  name = "sns-video-manager-api"
}

resource "aws_sns_topic_subscription" "video-processing-to-manager-api" {
  topic_arn = aws_sns_topic.sns-video-processing.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs-video-manager-api.arn
}

resource "aws_sns_topic_subscription" "video-manager-api-to-processing" {
  topic_arn = aws_sns_topic.sns-video-manager-api.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs-video-processing.arn
}
