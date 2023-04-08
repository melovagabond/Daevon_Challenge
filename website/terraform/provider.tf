provider "aws" {
  alias  = "east2"
  region = "us-east-2"
}

provider "cloudflare" {
  version = "~> 3.0"
  # Add your Cloudflare API token as an environment variable named CLOUDFLARE_API_TOKEN
  # or provide it directly below:
  api_token = var.cloudflare_api_token
}
