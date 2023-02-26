// network 
variable "vpc-cidr" {
#   default = "10.0.0.0/24"
}
variable "vpc-name" {
  
}
variable "igw-name" {
  
}
variable "nat-name" {
  
}
variable "subnet-cidr" {
  type = list
}
variable "availability-zone" {
 type = list
}
variable "subnet-name" {
  type = list
}
variable "subnet-cidr-2" {
  type = list
}
variable "availability-zone-2" {
 type = list
}
variable "subnet-name-2" {
  type = list
}
variable "route-table-public-cidr"{

}
variable "route-table-public"{

}
variable "route-table-private"{

}
variable "security-group-name"{
    
}
variable "ec2_ami" {
  
}
variable "ec2_type" {
  
}
variable "ec2_name" {
  
}
variable "key_pair" {
  
}
variable "cluster-role" {
  
}
variable "eks-cluster" {
  
}
variable "worker-node-role" {
  
}
variable "node-group-name" {
  
}
variable "capcity-type" {
  
}
variable "instance-type" {
  
}