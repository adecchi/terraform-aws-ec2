###########################
# VARIABLES KEY RESOURCES #
###########################
variable "key_name" {
  description = "Key Name to Create"
  type        = string
  default     = null
}

variable "public_key" {
  description = "The public Key to upload"
  type        = string
  default     = null
}

variable "create_key_name" {
  description = "Should be true to create the Public Key"
  type        = bool
  default     = false
}

#################################
# VARIABLES INSTANCES RESOURCES #
#################################
variable "name" {
  description = "Name to be used as prefix"
  type        = string
}

variable "use_name_suffix" {
  description = "Append numerical suffix to instance name"
  type        = bool
  default     = false
}

variable "name_suffix_format" {
  description = "Numerical suffix format used as the volume and EC2 instance name suffix"
  type        = string
  default     = "-%d"
}

variable "amount_instances" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type, ex: T3"
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "A list of VPC Subnet IDs to launch in"
  #type        = list(string)
  default = []
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled. You will be charged"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to attach to the EC2. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = null
}

variable "ipv6_address_count" {
  description = "IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  type        = number
  default     = null
}

variable "ipv6_addresses" {
  description = "list of one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance."
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "Add additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Instance Store volumes on the instance"
  type        = list(map(string))
  default     = []
}

variable "network_interface" {
  description = "Network interfaces to be attached to the instance"
  type        = list(map(string))
  default     = []
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A list of tags to assign to the resource"
  type        = map(string)
  default     = {}
}


