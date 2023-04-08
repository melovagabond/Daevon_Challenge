variable "cloudflare_api_token" {
  description = "Your Cloudflare API token"
}

resource "cloudflare_record" "nginx_site" {
  # Replace YOUR_CLOUDFLARE_ZONE_ID with the actual Zone ID from your Cloudflare account
  zone_id = "YOUR_CLOUDFLARE_ZONE_ID"
  name    = "sed.daevonlab.org"
  value   = aws_instance.nginx_instance.public_ip
  type    = "A"
  proxied = false
  ttl     = 1
}
