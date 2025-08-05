data "aws_security_group" "selected" {
    name = "dasdasd"
}

output "sg" {
    value = data.aws_security_group.selected
}