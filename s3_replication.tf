resource "aws_s3_bucket_replication_configuration" "replication_configuration" {
  bucket = aws_s3_bucket.origin_bucket.id

  rule {
    id     = "replication-rule"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination_bucket.arn
      storage_class = "STANDARD"
    }

    source_selection_criteria {
      sse_kms_encrypted_objects {
        status = "Enabled"
      }
    }
  }

  role = aws_iam_role.s3_replication_role.arn
}
