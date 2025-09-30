terraform {
  backend "s3" {
    bucket = "fiap-terraform-backend"
    key    = "github-actions-fiap/infra-video-manager/terraform.tfstate"

    region  = "us-west-2"
    encrypt = true
  }

  required_version = ">= 1.2.0"

}
