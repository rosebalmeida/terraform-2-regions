variable "project_name" {
  description = "Project Name"
  default = "Project_1"
}

variable "range_ip" {
  description = "Range IP"
  default = "172.31.0.0/16"
}

variable "instance_key" {
  description = "Instance Key"
  default = "terraform"
}

variable "instances_count" {
  description = "Instances Count"
  default = 2
}

variable "subnets_count" {
  description = "Subnets Count"
  default = 3
}

variable "subnets_size" {
  description = "Subnets Size"
  default = 8
}