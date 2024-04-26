provider "aws" {
  region = "us-east-1" # Update with your desired region
}

# Reference the existing security group by its name
data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["launch_wizard_1"]
  }
}

resource "aws_instance" "example" {
  # depends_on = [
  #   aws_security_group.instance_sg
  # ]
  ami           = "ami-05110239bdadf9038" # Update with your desired AMI ID
  instance_type = "t2.micro"              # Update with your desired instance type
  key_name      = "opk"           # Update with your key pair name

  // Assigning the security group to the instance
  security_groups = [data.aws_security_group.existing_sg.name]

  tags = {
    Name = "Jenkins-slave" # Update with your desired instance name
  }

  # Adding storage
  root_block_device {
    volume_size = 10    # Size of the root volume in gigabytes
    volume_type = "gp2" # Type of volume (e.g., gp2, standard, io1)
  }
}
