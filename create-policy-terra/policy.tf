provider "aws" {
}

# Create an IAM policy using the external JSON file
resource "aws_iam_policy" "ec2_full_access_policy" {
  name        = "tfEC2FullAccessPolicy"
  description = "Custom policy that allows full access to all EC2 resources"
  policy      = file("p1.json")
}
