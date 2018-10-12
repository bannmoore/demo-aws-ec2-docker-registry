provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "bam" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name      = "${var.key_pair_name}"

  vpc_security_group_ids = [
    "${aws_security_group.instance.id}",
    "${aws_security_group.ssh.id}",
  ]

  user_data = <<-EOF
            #!/bin/bash
            echo "hello"
            EOF

  tags {
    Name = "bam-app"
  }
}

resource "aws_security_group" "instance" {
  name = "bam-app-instance"

  # app requests
  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # docker registry
  ingress {
    from_port   = "${var.registry_port}"
    to_port     = "${var.registry_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {    
    from_port   = 0    
    to_port     = 0    
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name = "bam-app-ssh"

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
