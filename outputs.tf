output "ids" {
  description = "List of IDs of instances"
  value       = aws_instance.instance.*.id
}

output "arns" {
  description = "List of ARNs of instances"
  value       = aws_instance.instance.*.arn
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.instance.*.public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.instance.*.public_ip
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.instance.*.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.instance.*.private_ip
}

output "instance_state" {
  description = "List of instance states of instances"
  value       = aws_instance.instance.*.instance_state
}

output "key_name" {
  description = "List of key names of instances"
  value       = aws_instance.instance.*.key_name
}

