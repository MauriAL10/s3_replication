resource "aws_iam_policy" "s3_replication_policy" {
  name        = "s3-replication-policy"
  description = "Policy to allow S3 replication between two buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetReplicationConfiguration", "s3:ListBucket"]
        Resource = "arn:aws:s3:::${var.origin_bucket}"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObjectVersionForReplication", "s3:GetObjectVersionAcl", "s3:GetObjectVersionTagging"]
        Resource = "arn:aws:s3:::${var.origin_bucket}/*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ReplicateObject", "s3:ReplicateDelete", "s3:ReplicateTags"]
        Resource = "arn:aws:s3:::${var.destination_bucket}/*"
      }
    ]
  })
}

resource "aws_iam_role" "s3_replication_role" {
  name               = "s3-replication-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_replication_policy_attachment" {
  policy_arn = aws_iam_policy.s3_replication_policy.arn
  role       = aws_iam_role.s3_replication_role.name
}
