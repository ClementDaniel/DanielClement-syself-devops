variable "cert" {
  description = "The ARN of the certificate to use for the CloudFront distribution"
  type        = string

}

variable "ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string

}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string

}