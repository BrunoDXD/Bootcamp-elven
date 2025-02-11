#Criação do grupo de segurança
resource "aws_security_group" "allow_ssh" {
  name        = var.name_security_group
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.this.id

#Habilitar SSh para meu IP 
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ip_from_ssh]
  }

  #Habilitar Prometheus para meu IP 
  ingress {
    description      = "HTTP"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = [var.ip_from_ssh]
  }

  #Habilitar Grafana para meu IP 
  ingress {
    description      = "HTTP"
    to_port          = 3000
    from_port        = 3000
    protocol         = "tcp"
    cidr_blocks      = [var.ip_from_ssh]
  }

  #Habilitar requisição HTTP para toda internet
    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.common_tags, {
    Name = "Allow-SSH"
  })
}

#cria grupo de segurança do db
resource "aws_security_group" "db" {
  name        = "DB"
  description = "Allow database traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "RDS"
  })
}  