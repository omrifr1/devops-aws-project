output "server_ip" {
  value = aws_instance.web.public_ip
}

output "portainer_url" {
  value = "http://${aws_instance.web.public_ip}:9000"
}