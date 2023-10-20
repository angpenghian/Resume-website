# output "masternode_server" {
#   description = "The public IP of masternode_server"
#   value       = aws_eip.masternode_eip.public_ip
# }

# output "node01_server" {
#   description = "The public IP of node01_server"
#   value       = aws_eip.node01_server_eip.public_ip
# }

# output "jenkis_server" {
#   description = "The public IP of jenkins_server"
#   value       = var.create_jenkins_server_and_route53_rule ? aws_eip.jenkins_server_eip[0].public_ip : "N/A"
# }

# output "sonarqube_server" {
#   description = "The public IP of sonarqube_server"
#   value       = var.create_sonarqube_server_and_route53_rule ? aws_eip.sonarqube_server_eip[0].public_ip : "N/A"
# }