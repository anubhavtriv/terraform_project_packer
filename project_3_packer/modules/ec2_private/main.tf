#*****************************************************Apache_Web_Server_AMI_Instance**************************************************
resource "aws_instance" "apache_web" {
  depends_on = [aws_vpc.web_vpc]
  ami = "${var.ami_ids_apache}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  vpc_security_group_ids = [ "${aws_security_group.web_secgroup.id}" ]
  subnet_id = aws_subnet.web_subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name = "${var.key_name}"
  tags = {
    Name = "${var.instance_name}"
  }
}

#*****************************************************Jenkins_Server_AMI_Instance**************************************************

resource "aws_instance" "jenkins_ami" {
  depends_on = [aws_vpc.web_vpc]
  ami = "${var.ami_ids_jenkins}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  vpc_security_group_ids = [ "${aws_security_group.jenkins_secgroup.id}" ]
  subnet_id = aws_subnet.jenkins_subnet.id
  associate_public_ip_address = var.associate_public_ip_address_jenkins
  key_name = "${var.key_name}"
  tags = {
    Name = "${var.jenkins_instance_name}"
  }
}

#*****************************************************Windows_Server_AMI_Instance**************************************************

resource "aws_instance" "windows_server" {
  depends_on = [aws_vpc.web_vpc]
  ami = "${var.ami_ids_windows}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  vpc_security_group_ids = [ "${aws_security_group.web_secgroup.id}" ]
  subnet_id = aws_subnet.web_subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name = "${var.key_name}"
  tags = {
    Name = "${var.windows_instance_name}"
  }
}

