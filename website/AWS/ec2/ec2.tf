resource "aws_instance" "nginx_web_server" {
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id
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

}
