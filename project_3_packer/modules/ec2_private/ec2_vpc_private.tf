resource "aws_vpc" "web_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_tag_name}"
  }
}

#*****************************************Subnets*********************************************


resource "aws_subnet" "web_subnet" {
  vpc_id     = aws_vpc.web_vpc.id
  cidr_block = var.pub_subnet_cidr
  availability_zone = "${var.availability_zone}"
  tags = {
    Name = "${var.web_subnet_tag_name}"
  }
}
resource "aws_subnet" "jenkins_subnet" {
  vpc_id = aws_vpc.web_vpc.id
  cidr_block = var.pri_subnet_cidr
  availability_zone = "${var.availability_zone}"
  tags = {
    "Name" = "${var.jenkins_subnet_name}"
  }
}

#******************************************* IGW *********************************************
resource "aws_internet_gateway" "web_igw" {
      vpc_id = aws_vpc.web_vpc.id
    tags = {
      Name = "${var.igw_tag_name}"
    }
}

#*********************************************NAT Gateway*****************************************
resource "aws_eip" "eip_nat_gateway" {
    vpc = var.vpc_bool
  tags = {
    "Name" = "${var.eip_name}"
  }
}

resource "aws_nat_gateway" "jenkins_nat" {
    subnet_id = aws_subnet.web_subnet.id
    connectivity_type = "${var.connectivity_type_jenkins}"
    allocation_id = aws_eip.eip_nat_gateway.id
  tags= {
    "Name"= "${var.jen_nat_name}"
  }  
}

#********************************* rout_table_part *************************************

#***************Public**************
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "${var.all_cidr}"
    gateway_id = aws_internet_gateway.web_igw.id
  }
  tags = {
    Name = "${var.web_rt_tag}"
  }
}

resource "aws_route_table_association" "associate_rt" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rt.id
}
#*******************Private*****************
resource "aws_route_table" "jenkins_rt" {
  vpc_id = aws_vpc.web_vpc.id
  route {
    cidr_block = "${var.all_cidr}"
    gateway_id = aws_nat_gateway.jenkins_nat.id
  }
  tags = {
    "Name" = "${var.jen_rt_name_tag}"
  }
}
resource "aws_route_table_association" "jenkins_associate_rt" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_rt.id
}

#************************* Security grp part ***********************************

resource "aws_security_group" "web_secgroup" {
  name        = "${var.secgroup_name}"
  description = "${var.secgroup_description}"
  vpc_id      = aws_vpc.web_vpc.id

    ingress {
        description      = "HTTP"
        from_port        = var.http_port
        to_port          = var.http_port
        protocol         = "${var.protocol_type}"
        cidr_blocks = ["${var.all_cidr}"]
    }
    ingress {
        description      = "RDP"
        from_port        = var.rdp_port
        to_port          = var.rdp_port
        protocol         = "${var.protocol_type}"
        cidr_blocks = ["${var.all_cidr}"]
    }
    ingress {
        description = "SSH for VPC"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "${var.protocol_type}"
        cidr_blocks = ["${var.all_cidr}"]
    }
    egress {
        from_port   = var.port_all
        to_port     = var.port_all
        protocol    = "-1"
        cidr_blocks = ["${var.all_cidr}"]
    }
  tags = {
    Name = "${var.secgroup_name_web}"
  }
}
resource "aws_security_group" "jenkins_secgroup" {
  name = "${var.secgroup_name_jenkins}"
  description = "${var.secgroup_description_jenkins}"
  vpc_id = aws_vpc.web_vpc.id
    ingress {
        description      = "HTTP"
        from_port        = var.http_port
        to_port          = var.http_port
        protocol         = "${var.protocol_type}"
        cidr_blocks = ["${var.all_cidr}"]
    }
    ingress {
      description = "Jenkins"
      from_port = var.jen_port
      to_port = var.jen_port
      protocol = "${var.protocol_type}"
      cidr_blocks = ["${var.all_cidr}"]
    }
    ingress {
        description = "SSH"
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "${var.protocol_type}"
        cidr_blocks = ["${var.all_cidr}"]
    }
    egress {
        from_port   = var.port_all
        to_port     = var.port_all
        protocol    = "-1"
        cidr_blocks = ["${var.all_cidr}"]
    }
  tags = {
    Name = "${var.sec_group_jenkins}"
  }
}

