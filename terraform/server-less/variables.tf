variable "ami" {
  description = "The ID of the AMI to use"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "key_name" {
  description = "The key pair name"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key"
  type        = string
}

variable "domain" {
  description = "The domain name"
  type        = string
}

variable "certificate_arn" {
  description = "The certificate arn"
  type        = string
}

variable "region" {
  description = "The region"
  type        = string
}
