resource "null_resource" "test" {
  count = 10
}

resource "null_resource" "test1" {
  for_each = var.colors-codes
}

variable "colors-codes" {
  default = {
    red     = 31
    green   = 32
    yellow  = 33
    blue    = 34
    magenta = 35
    cyan    = 36

  }
}

----

#Dynamically create different instance types using for_each.

variable "instances" {
  default = {
    "web"    = "t3.micro"
    "db"     = "t3.medium"
    "worker" = "t3.small"
  }
}

resource "aws_instance" "example" {
  for_each     = var.instances
  ami          = "ami-0533f2ba8a1995cf9"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}

---

variable "iam_users" {
  default = ["alice", "bob", "charlie"]
}

resource "aws_iam_user" "users" {
  for_each = toset(var.iam_users)
  name     = each.key
}

---

# Create multiple EC2 instances in different environments (dev, prod).

variable "environments" {
  default = {
    "dev"  = 2  # 2 instances in dev
    "prod" = 3  # 3 instances in prod
  }
}

resource "aws_instance" "example" {
  for_each     = var.environments
  count        = each.value
  ami          = "ami-0533f2ba8a1995cf9"
  instance_type = "t3.micro"

  tags = {
    Name        = "${each.key}-instance-${count.index}"
    Environment = each.key
  }
}

---

#Suppose you have a map of instance details but need a list of instance types.
#Loop Through a Map and Convert to List

variable "instance_map" {
  default = {
    "web"    = "t3.micro"
    "db"     = "t3.medium"
    "worker" = "t3.small"
  }
}

output "instance_types" {
  value = [for key, value in var.instance_map : value]
}

---

# Define different port rules for different environments dynamically.

variable "security_rules" {
  default = {
    "dev"  = [22, 8080]
    "prod" = [22, 80, 443]
  }
}

resource "aws_security_group" "sg" {
  name = "example-sg"

  dynamic "ingress" {
    for_each = flatten([
      for env, ports in var.security_rules : [
        for port in ports : { environment = env, port = port }
      ]
    ])
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
