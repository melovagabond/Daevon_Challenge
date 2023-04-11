terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

  }
}
provider "aws" {
  region                   = var.aws_region
  shared_config_files      = ["~/.asw/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode"
}

