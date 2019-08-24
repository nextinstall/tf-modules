output "id" {
  description = "List of IDs of instances"
  value       = ["${aws_instance.instance.*.id}"]
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = ["${aws_instance.instance.*.private_ip}"]
}
