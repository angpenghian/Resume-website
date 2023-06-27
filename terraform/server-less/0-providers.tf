provider "aws" {
  access_key = chomp(file("../../secrets/aws_access_key.txt"))
  secret_key = chomp(file("../../secrets/aws_secret_key.txt"))
  region     = "ap-southeast-1"
}
