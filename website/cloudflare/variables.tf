variable "cloudflare_email" {
  type        = string
  description = "The email address associated with your Cloudflare account"
}

variable "cloudflare_api_key" {
  type        = string
  description = "The Cloudflare API key for your account"
}

variable "cloudflare_api_token" {
  description = "Your Cloudflare API token"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The Cloudflare Zone ID for the domain you want to create a record for"
}

variable "subdomain" {
  type        = string
  description = "The Subdomain Cloudflare should use"
  default     = "sed.daevonlab.org"

}