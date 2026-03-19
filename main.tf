provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"

  subnet_id = "subnet-05e8771ce46d7bb89"

  tags = {
    Name = "My EC2 Instance"
  }
}