resource "aws_s3_bucket" "origin_bucket" {
  provider = aws.origin
  bucket   = var.origin_bucket

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "destination_bucket" {
  provider = aws.destination
  bucket   = var.destination_bucket

  versioning {
    enabled = true
  }
}
