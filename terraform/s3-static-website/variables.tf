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

variable "certificate_arn2" {
  description = "The certificate arn"
  type        = string
}

variable "create_jenkins_server_and_route53_rule" {
  description = "Whether to create the whole jenkins server stack change true to create and false to delete"
  default     = true
}

variable "create_sonarqube_server_and_route53_rule" {
  description = "Whether to create the whole sonarqube server stack change true to create and false to delete"
  default     = false
}

variable "environment" {
  description = "s3-static-website-resume"
  type        = string
}