# resource "aws_key_pair" "daevonlab_auth" {
#   key_name   = "daevonlabkey"
#   public_key = file("~/.ssh/daevonbkey.pub")

# }

resource "aws_instance" "nginx_web_server" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  #key_name               = aws_key_pair.daevonlab_auth.id
  vpc_security_group_ids = [aws_security_group.daevonlab_sg.id]
  subnet_id              = aws_subnet.daevonlab_public_subnet.id
  user_data              = file("userdata.sh")

  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = var.instance_name
  }

  # provisioner "file" {
  #   source      = var.ssl_cert_path
  #   destination = "/tmp/nginx-selfsigned.crt"
  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file("~/.ssh/daevonbkey")
  #     host        = self.public_ip 
  #   }
  # }

  # provisioner "file" {
  #   source      = var.ssl_key_path
  #   destination = "/tmp/nginx-selfsigned.key"
  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu" 
  #     private_key = file("~/.ssh/daevonbkey")
  #     host        = self.public_ip
  #   }
  # }
  

}
