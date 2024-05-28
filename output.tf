output "vpc_id" {
  value = aws_vpc.jenkins_vpc.id
}

output "subnet_id" {
  value = aws_subnet.jenkins_subnet.id
}

output "jenkins_instance_id" {
  value = aws_instance.jenkins_instance.id
}

output "jenkins_instance_public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}

output "jenkins_eip" {
  value = aws_eip.jenkins_eip.public_ip
}
