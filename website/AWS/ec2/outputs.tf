# Display the ip the webpage is hosted on
output "public_ip" {
  value       = aws_instance.nginx_web_server.public_ip
  description = "Public IP address of the Nginx web server instance"
}
