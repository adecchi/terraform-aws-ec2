######################
# KEY PAIR RESOURCES #
######################
resource "aws_key_pair" "deployer_key" {
  count      = var.create_key_name && var.public_key != null && var.key_name != null ? 1 : 0
  key_name   = var.key_name
  public_key = var.public_key
}

#################
# EC2 RESOURCES #
#################
resource "aws_instance" "instance" {
  count                       = var.key_name != null || (var.create_key_name && length(aws_key_pair.deployer_key) > 0) ? var.amount_instances : 0
  ami                         = var.ami
  instance_type               = var.instance_type
  user_data                   = var.user_data
  subnet_id                   = var.subnet_id
  key_name                    = (var.create_key_name && var.public_key == null && var.key_name != null) ? aws_key_pair.deployer_key[count.index].id : var.key_name
  monitoring                  = var.monitoring
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  ipv6_address_count          = var.ipv6_address_count
  ipv6_addresses              = var.ipv6_addresses
  ebs_optimized               = var.ebs_optimized
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }
  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }
  disable_api_termination = var.disable_api_termination
  tags = merge(
    {
      "Name" = var.amount_instances > 1 || var.use_name_suffix ? format("%s${var.name_suffix_format}", var.name, count.index + 1) : var.name
    },
    var.tags,
  )
}