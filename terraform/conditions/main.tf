# ? and :
# condition ? true_value : false_value


resource "aws_instance" "test" {
    count=2
    ami = "ami-0533f2ba8a1995cf9"
    instance_type = can(regex("^t2", var.instance_type)) ? "t3.micro" : var.instance_type
    tags = {
        Name = "Server - ${count.index}"
  }
}

variable "instance_type" {}

# variable "create_instance" {}

#make this ami dynamic with the data block

-----

variable "environment" {
  default = "dev"
}

resource "aws_instance" "example" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"

  tags = {
    Name = "EC2 - ${var.environment}"
  }
}


-----

#if the instance type is "t3.large", attach an EBS volume; otherwise, skip it.
variable "instance_type" {
  default = "t3.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = var.instance_type

  tags = {
    Name = "Instance - ${var.instance_type}"
  }
}

resource "aws_ebs_volume" "ebs" {
  count = var.instance_type == "t3.large" ? 1 : 0
  availability_zone = aws_instance.example.availability_zone
  size             = 20

  tags = {
    Name = "EBS Volume for ${var.instance_type}"
  }
}

---



