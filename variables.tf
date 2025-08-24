variable "AWS-REGION" {
  description = "Região AWS"
  type        = string
  default     = "us-west-2"
}

variable "REPOSITORY-NAMES" {
  description = "ECR Repository Names"
  type        = list(string)
  default     = ["file-processing-api"]
}

variable "PROJECT-NAME" {
  type    = string
  default = "eks-fiap-soat10"
}

variable "NODE-GROUP" {
  type    = string
  default = "fiap"
}

variable "INSTANCE-TYPE" {
  type    = string
  default = "t3.medium"
}

variable "AWS-ACCOUNT-ID" {
  type    = string
  default = "548226336065"
}

variable "SES-DOMAIN" {
  type    = string
  default = "fiap.com.br"
}

variable "SES-FROM-ADDRESS" {
  type    = string
  default = "no-reply@fiap.com.br"
}
