resource "cloudflare_record" "nginx_site" {
  zone_id = var.cloudflare_zone_id
  name    = var.subdomain
  value   = var.public_ip
  type    = "A"
  proxied = false
  ttl     = 1
}
