provider "aws" {
  region = "eu-west-1"
  profile= "default"
}

resource "aws_instance" "udacity_t2" {
  count = "4"
  ami = "ami-0fc970315c2d38f01"
  instance_type = "t2.micro"
  subnet_id = "subnet-0ead33d1cca91539b"

  tags = {
    Name = "Udacity T2"
  }
}

resource "aws_instance" "udacity_m4" {
  count = "2"
  ami = "ami-0fc970315c2d38f01"
  instance_type = "m4.large"
  subnet_id = "subnet-0ead33d1cca91539b"

  tags = {
    Name = "Udacity M4"
  }
}
