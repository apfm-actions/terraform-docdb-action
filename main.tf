provider "credstash" {
    profile = "credstash"
    region  = var.region
}

data "credstash_secret" "password" {
  name = var.credstash_docdb_password
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = var.cluster_name
  port                            = var.port
  engine                          = "docdb"
  db_subnet_group_name            = aws_docdb_subnet_group.subnet_group.id
  db_cluster_parameter_group_name = var.parameter_group
  vpc_security_group_ids          = split(",", var.security_group_ids)
  storage_encrypted               = var.storage_encrypted
  apply_immediately               = var.apply_immediately

  master_username = var.username
  master_password = data.credstash_secret.password.value

  preferred_backup_window = var.backup_window
  backup_retention_period = var.backup_retention
  skip_final_snapshot     = true

  tags = {
    app   = var.project_name
    owner = var.project_owner
    env   = terraform.workspace
    repo  = var.GITHUB_PROJECT
  }
}

resource "aws_docdb_cluster_instance" "instance" {
  count              = var.instance_count
  identifier_prefix  = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class
  cluster_identifier = aws_docdb_cluster.docdb.id

  tags = {
    app   = var.project_name
    owner = var.project_owner
    env   = terraform.workspace
    repo  = var.GITHUB_PROJECT
  }
}

resource "aws_docdb_subnet_group" "subnet_group" {
  name_prefix = var.cluster_name
  subnet_ids  = split(",", var.subnet_ids)

  tags = {
    app   = var.project_name
    owner = var.project_owner
    env   = terraform.workspace
    repo  = var.GITHUB_PROJECT
  }
}
