provider "aws" {
  region = "us-east-1" # Update with your desired region
}

resource "aws_instance" "example" {
  # depends_on = [
  #   aws_security_group.instance_sg
  # ]
  ami           = "ami-02e2b55c9e895603c" # Update with your desired AMI ID
  instance_type = "t2.micro"              # Update with your desired instance type
  key_name      = "opk"           # Update with your key pair name

  // Assigning the security group to the instance
  security_groups = [aws_security_group.instance_sg.name]

  tags = {
    Name = "Jenkins" # Update with your desired instance name
  }

  # Adding storage
  root_block_device {
    volume_size = 10    # Size of the root volume in gigabytes
    volume_type = "gp2" # Type of volume (e.g., gp2, standard, io1)
  }
}


resource "aws_security_group" "instance_sg" {
  name        = "launch_wizard_1"
  description = "Security group for EC2 instance"

  // Define ingress rule to allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

    # New ingress rule to allow HTTP traffic on port 8080 from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from anywhere
  }

  // Define egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}