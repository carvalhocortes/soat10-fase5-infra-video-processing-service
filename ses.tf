resource "aws_ses_domain_identity" "domain" {
  domain = var.SES-DOMAIN
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = var.SES-DOMAIN
}

resource "aws_ses_email_identity" "from_address" {
  email = var.SES-FROM-ADDRESS
}
