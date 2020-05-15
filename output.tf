output "documentdb_name" {
  description = "Name of the created documentdb cluster"
  value = "${aws_docdb_cluster.docdb.id}"
}

output "documentdb_arn" {
  description = "ARN of the created documentdb cluster"
  value = "${aws_docdb_cluster.docdb.arn}"
}

output "documentdb_endpoint" {
  description = "The DNS address of the DocDB instance"
  value = "${aws_docdb_cluster.docdb.endpoint}"
}

output "documentdb_reader_endpoint" {
  description = "A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas"
  value = "${aws_docdb_cluster.docdb.reader_endpoint}"
}
