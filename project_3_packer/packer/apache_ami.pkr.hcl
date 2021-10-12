source "amazon-ebs" "apache_ami" {
  profile = "default"
  region = "ap-south-1"
  source_ami    =  "ami-041d6256ed0f2061c"
  instance_type =  "t2.micro"
  ssh_username  =  "ec2-user"
  ami_name      =  "apache_ami_{{timestamp}}"
}
build {
  sources = ["source.amazon-ebs.apache_ami"]

  provisioner "shell" {
    inline = [      
      "sudo su",
      "sudo yum update –y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
    ]
}
}