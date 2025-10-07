resource "aws_s3_bucket" "example111" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}