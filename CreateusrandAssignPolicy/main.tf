provider "aws" {
  region = "us-east-1"
}

# 1️⃣ Create an IAM User
resource "aws_iam_user" "example_user" {
  name = "devops-user"
  path = "/"
}

# 2️⃣ Enable Console Access for the user
resource "aws_iam_user_login_profile" "example_login" {
  user                    = aws_iam_user.example_user.name
  
  password_reset_required = false
}

# 3️⃣ Create a Customer Managed Policy (Full S3 Access)
resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "S3FullAccessPolicy"
  description = "Custom policy providing full access to all S3 resources"
  policy      = file("policy.json")
}

# 4️⃣ Attach the S3 Full Access (Customer Managed Policy)
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

# 5️⃣ Add an Inline Policy (Full EC2 Access)
resource "aws_iam_user_policy" "inline_ec2_policy" {
  name = "InlineEC2FullAccess"
  user = aws_iam_user.example_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ec2:*"
        Resource = "*"
      }
    ]
  })
}
