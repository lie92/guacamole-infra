output "address" {
  value = aws_instance.vm1.*.private_ip
}