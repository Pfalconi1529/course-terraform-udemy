output "ec2_public_ips" {
  value = {
    for k, instance in aws_instance.public_instance :
    k => instance.public_ip
  }
}