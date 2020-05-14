provider "credstash" {
  
}

data "credstash_secret" "password" {
  name = "${var.credstash_docdb_password}"
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = "${var.cluster_name}"
  engine                          = "docdb"
  db_subnet_group_name            = "${aws_docdb_subnet_group.subnet_group.id}"
  db_cluster_parameter_group_name = "${var.parameter_group}"
  vpc_security_group_ids          = "${split(",", var.security_group_ids)}"
  enabled_cloudwatch_logs_exports = "${split(",", var.cloudwatch_log_types)}"
  
  master_username = "${var.cluster_identifier}-admin"
  master_password = "${data.credstash_secret.password.value}"

  preferred_backup_window = "${var.backup_window}"
  backup_retention_period = "${var.backup_retention}" 

  tags = {
    project = "${var.project}"
    owner   = "${var.owner}"
    email   = "${var.email}"
  }
}

resource "aws_docdb_cluster_instance" "instance" {
  count             = "${var.instance_count}"
  identifier_prefix = "${aws_docdb_cluster.docdb.id}"
  instance_class    = "${var.instance_class}"
  cluster_identifier = "${aws_docdb_cluster.docdb.id}"

  tags = {
    project = "${var.project}"
    owner   = "${var.owner}"
    email   = "${var.email}"
  }
}

resource "aws_docdb_subnet_group" "subnet_group" {
  name_prefix = "${var.cluster_identifier}"
  subnet_ids  = "${var.subnet_id_private}"

  tags = {
    project = "${var.project}"
    owner   = "${var.owner}"
    email   = "${var.email}"
  }
}