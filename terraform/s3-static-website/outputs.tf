output "masternode_server" {
  description = "The public IP of masternode_server"
  value       = aws_eip.masternode_eip.public_ip
}