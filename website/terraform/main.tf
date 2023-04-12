# Create a VPC
resource "aws_vpc" "daevonlab_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

# Create a subnet
resource "aws_subnet" "daevonlab_public_subnet" {
  vpc_id                  = aws_vpc.daevonlab_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name = "dev-public"
  }
}

# Create an internet Gateway
resource "aws_internet_gateway" "daevonlab_internet_gateway" {
  vpc_id = aws_vpc.daevonlab_vpc.id

  tags = {
    Name = "dev-igw"
  }

}

# Create a Route Table
resource "aws_route_table" "daevonlab_public_rt" {
  vpc_id = aws_vpc.daevonlab_vpc.id

  tags = {
    Name = "dev_public_rt"
  }

}

# Create a default route
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.daevonlab_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.daevonlab_internet_gateway.id
}

# Associate Route and Route Table

resource "aws_route_table_association" "daevolab_public_assoc" {
  subnet_id      = aws_subnet.daevonlab_public_subnet.id
  route_table_id = aws_route_table.daevonlab_public_rt.id

}

# Add Security Group

resource "aws_security_group" "daevonlab_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.daevonlab_vpc.id

  ingress {
    cidr_blocks = [var.wan_ip]
    description = "Allow traffic only from IP"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "daevonlab_auth" {
  key_name   = "daevonlabkey"
  public_key = file("~/.ssh/daevonbkey.pub")

}

resource "aws_instance" "dev_node" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.daevonlab_auth.id
  vpc_security_group_ids = [aws_security_group.daevonlab_sg.id]
  subnet_id              = aws_subnet.daevonlab_public_subnet.id
  user_data              = file("userdata.sh")

  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "dev-node"

  }
  # Provisioner (Would want to use Jenkins or Ansible for this normally)

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/daevonbkey"
    })
    interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "-Command"]

  }

}
