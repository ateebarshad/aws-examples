provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "example_user" {
  name = "ateebtf"
}
resource "aws_iam_user_login_profile" "example_login" {
  user                    = aws_iam_user.example_user.name
  password_reset_required = true
}