provider "aws" {
    region = "${var.aws_region}"
    profile = "${var.profile}"
}

module "ec2_private" {
    source = ".//modules/ec2_private/"
    
}