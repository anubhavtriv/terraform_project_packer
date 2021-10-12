#*********************************************** Providers ***********************************************************#

variable "aws_region" {
    default = "ap-south-1"
}

#********************************************** VPC Variable *********************************************************#

variable "vpc_tag_name" {
    default = "web_vpc"
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

#**************************************************** Public Subnet ***************************************************************#

variable "pub_subnet_cidr" {
    default =  "10.0.0.0/24"    
}
variable "web_subnet_tag_name" {
    default = "web_subnet"
}

#**************************************************** Private Subnet ***************************************************************#

variable "pri_subnet_cidr" {
    default = "10.0.1.0/24" 
}

variable "jenkins_subnet_name" {
    default = "jenkins_server"
}

#******************************************* IGW *********************************************

variable "igw_tag_name" {
    default = "web_igw"
}

#*********************************************NAT Gateway*****************************************

variable "vpc_bool" {
    type= bool
    default = true
}

variable "eip_name" {
    default = "nat_eip"
}

variable "connectivity_type_jenkins" {
    default = "public"  
}
variable "jen_nat_name" {
  default = "jenkins_nat"
}

#*************************************************** Route Table ************************************************

variable "web_rt_tag" {
    default = "web" 
}
variable "all_cidr" {
  default = "0.0.0.0/0"
}
variable "jen_rt_name_tag" {
  default = "jenkins_rt"
}
variable "secgroup_description" {
    default = "Allow TLS inbound traffic"
}
variable "protocol_type" {
    default = "tcp"
  
}
variable "http_port" {
    default = 80
}

variable "rdp_port" {
    default = 3389
}
variable "ssh_port" {
  default = 22
}

variable "port_all" {
  default = 0
}
variable "sec_group_jenkins" {
  default = "jenkins_sec_group"
}

variable "secgroup_name_web" {
    default = "web_sec_group"
}
#**************************************************** Private Subnet ***************************************************************#

variable "secgroup_name" {
    default = "web"
}
#************************************************ EC2 Apache_Server_linux *******************************************************#

variable "instance_type" {
    default = "t2.micro"
}

variable "instance_name" {
    default = "apache_web_server"
}
variable "associate_public_ip_address" {
       type = bool       
    default = true
}

variable "availability_zone"{
    default = "ap-south-1a"
}

variable "key_name" {
    default = "Anubhav"
}

variable "ami_ids_apache" {
    default = "ami-01522a05eb4ff2481"
}
variable "secgroup_description_jenkins" {
  default = "private_host"
}
variable "secgroup_name_jenkins" {
  default = "jenkins_sec_grp"
}
variable "jen_port" {
    default = 8080
}

#******************************************************* EC2 Jenkins_Server_linux *******************************************************#

variable "jenkins_instance_name" {
    default = "jenkins_server"
}
variable "ami_ids_jenkins" {
    default = "ami-017009dca342e614c"
}

variable "associate_public_ip_address_jenkins" {
       type = bool       
    default = false
}
#******************************************************* EC2 Windows_Server_linux *******************************************************#

variable "windows_instance_name" {
    default = "windows_server"
}

variable "ami_ids_windows" {
    default = "ami-09a62bf22e41143a4"
}
