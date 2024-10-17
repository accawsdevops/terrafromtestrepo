provider "aws" {
  region = "us-east-1"  # Specify your desired region
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0c55b159cbfafe01e"  # Replace with a valid AMI ID
  instance_type = var.instance_type

  tags = {
    Name = "MyEC2Instance"
  }

  # Security group for SSH access
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change as needed
  }
}

output "instance_id" {
  description = "The Instance ID of the newly created EC2 instance"
  value       = aws_instance.my_ec2_instance.id
}
