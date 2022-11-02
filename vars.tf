variable "AWS_REGION" {
  default = "ca-central-1"
}
variable "ami_win" {
  default = "ami-0982b9d4a30844d7f"
}
variable "ami_linux" {
  default = "ami-0a7154091c5c6623e"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}
variable "INSTANCE_USERNAME" {
  default = "terraform"
}

variable "INSTANCE_PASSWORD" {}