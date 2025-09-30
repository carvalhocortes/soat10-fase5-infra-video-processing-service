resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.PROJECT-NAME}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "${var.PROJECT-NAME}-cluster-role"
    Project = var.PROJECT-NAME
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.PROJECT-NAME}-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "${var.PROJECT-NAME}-node-group-role"
    Project = var.PROJECT-NAME
  }
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_policy" "s3_video_access_policy" {
  name        = "${var.PROJECT-NAME}-s3-video-access"
  description = "Política para acesso ao bucket S3 de vídeos"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.fiap_video_files.arn,
          "${aws_s3_bucket.fiap_video_files.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_s3_video_access" {
  policy_arn = aws_iam_policy.s3_video_access_policy.arn
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_policy" "messaging_access_policy" {
  name        = "${var.PROJECT-NAME}-messaging-access"
  description = "Política para acesso ao SQS e SNS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:SendMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Resource = aws_sqs_queue.sqs-video-files.arn
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:Subscribe",
          "sns:Unsubscribe",
          "sns:GetTopicAttributes"
        ]
        Resource = aws_sns_topic.video-files.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_messaging_access" {
  policy_arn = aws_iam_policy.messaging_access_policy.arn
  role       = aws_iam_role.eks_node_group_role.name
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "ssm_access_policy" {
  name        = "${var.PROJECT-NAME}-ssm-access"
  description = "Política para acesso ao SSM Parameter Store"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "arn:aws:ssm:${var.AWS-REGION}:${data.aws_caller_identity.current.account_id}:parameter/soat10/infra-video-manager/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_ssm_access" {
  policy_arn = aws_iam_policy.ssm_access_policy.arn
  role       = aws_iam_role.eks_node_group_role.name
}
