source "amazon-ebs" "jenkins_ami" {
  profile = "default"
  region = "ap-south-1"
  source_ami    =  "ami-041d6256ed0f2061c"
  instance_type =  "t2.micro"
  ssh_username  =  "ec2-user"
  ami_name      =  "apache_ami_{{timestamp}}"
}
build {
  sources = ["source.amazon-ebs.jenkins_ami"]

  provisioner "shell" {
    inline = [      
      "sudo su",
      "sudo yum update –y",
      "sudo amazon-linux-extras install epel -y",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo chmod 777 /etc/yum.repos.d/",
      "sudo echo -e '[jenkins]\nname=Jenkins-stable\nbaseurl=http://pkg.jenkins.io/redhat-stable\ngpgcheck=1'>>/etc/yum.repos.d/jenkins.repo",
      "sudo chmod 777 /etc/yum.repos.d/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo yum install jenkins -y",
      "sudo systemctl daemon-reload",
      "sudo systemctl start jenkins ",]
  }
}
