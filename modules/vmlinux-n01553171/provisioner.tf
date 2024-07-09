# locals {
#   vm_public_ips = {
#     for key, nic in azurerm_network_interface.nic : key => azurerm_public_ip.ip[key].ip_address
#   }
# }


# resource "null_resource" "show_hostname" {
#   for_each = azurerm_virtual_machine.vm

#   provisioner "remote-exec" {
#     inline = [
#       "/usr/bin/hostname"
#     ]

#     connection {
#       type        = "ssh"
#       user        = var.admin_username
#       private_key = file("/home/azmatpathan/id_rsa")
#       host        = local.vm_public_ips[each.key]
#     }
#   }
# }
