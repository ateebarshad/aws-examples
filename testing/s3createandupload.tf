terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket111ateeb"

}
resource "aws_s3_object" "object" {
  bucket = "my-tf-test-bucket111ateeb"
  key    = "f111"
  source = "/workspaces/aws-examples/f111"
  depends_on = [aws_s3_bucket.example]

}
resource "aws_s3_bucket_policy" "allow_my_ip" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowAccessFromSpecificIP"
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.example.arn}/*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "27.4.82.1/32"  # replace with your IP
          }
        }
      }
    ]
  })
}