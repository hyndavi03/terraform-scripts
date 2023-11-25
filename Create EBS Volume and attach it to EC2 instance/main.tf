# Define variables
variable "aws_region" {
  default = "us-east-1"  # Change to your desired AWS region
}

variable "instance_ami" {
  default = "ami-xxxxxxxxxxxxxxxxx"  # Specify the AMI ID for your EC2 instance
}

variable "volume_size" {
  default = 8  # Specify the size of the EBS volume in GB
}

# Create an EC2 instance
resource "aws_instance" "example_instance" {
  ami             = var.instance_ami
  instance_type   = "t2.micro"  # Change to your desired instance type
  subnet_id       = "subnet-xxxxxxxxxxxxxxxxx"  # Replace with your subnet ID
  key_name        = "your-key-pair"  # Replace with your key pair name

  tags = {
    Name = "example-instance"
  }
}

# Create an EBS volume
resource "aws_ebs_volume" "example_volume" {
  availability_zone = "${aws_instance.example_instance.availability_zone}"
  size              = var.volume_size
  tags = {
    Name = "example-volume"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "example_attachment" {
  device_name = "/dev/sdf"  # Change to your desired device name
  volume_id   = aws_ebs_volume.example_volume.id
  instance_id = aws_instance.example_instance.id
}
