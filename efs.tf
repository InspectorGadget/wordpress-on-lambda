# Create EFS
resource "aws_efs_file_system" "efs" {
  depends_on = [
    aws_security_group.lambda
  ]

  tags = {
    Name = "${var.project_name} - EFS"
  }
}

# Create EFS Mount Target on all Private Subnets
resource "aws_efs_mount_target" "efs" {
  depends_on = [
    aws_efs_file_system.efs,
    aws_security_group.lambda
  ]

  count          = length(data.aws_subnets.private.ids)
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = data.aws_subnets.private.ids[count.index]

  security_groups = [
    aws_security_group.lambda.id
  ]
}

# Create Access Point
resource "aws_efs_access_point" "efs" {
  depends_on = [
    aws_efs_file_system.efs,
    aws_efs_mount_target.efs
  ]

  file_system_id = aws_efs_file_system.efs.id

  posix_user {
    uid = 0
    gid = 0
  }

  root_directory {
    path = "/"

    creation_info {
      owner_uid   = 0
      owner_gid   = 0
      permissions = "777"
    }
  }
}
