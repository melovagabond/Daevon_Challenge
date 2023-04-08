provider "aws" {
  alias  = "east2"
  region = "us-east-2"
}

terraform {
  required_providers {
    # ...
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}
