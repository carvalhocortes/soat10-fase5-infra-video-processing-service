resource "aws_sns_topic" "video-files" {
  name = "sns-video-files"
}

resource "aws_sns_topic_subscription" "video-files" {
  topic_arn = aws_sns_topic.video-files.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs-video-files.arn
}
