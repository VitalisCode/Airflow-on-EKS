resource "aws_efs_file_system" "this" {
  encrypted       = true
  throughput_mode = "elastic"
  tags            = merge(var.tags, { Name = var.name })
}

resource "aws_efs_mount_target" "this" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_ids
}

resource "aws_efs_access_point" "airflow" {
  file_system_id = aws_efs_file_system.this.id
  posix_user {
    gid = 50000
    uid = 50000
  }
  root_directory {
    path = "/airflow"
    creation_info {
      owner_gid   = 50000
      owner_uid   = 50000
      permissions = "0755"
    }
  }
  tags = merge(var.tags, { Name = "${var.name}-airflow" })
}
