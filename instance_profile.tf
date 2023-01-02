resource "aws_iam_role" "code-ec2-instance-profile" {
  name               = "code-ec2-instance-profile"
  path               = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_policy" "code-ec2-permissions" {
  name        = "code-ec2-permissions"
  path        = "/"
  description = "Policy for EC2 instances where Code Deploy would deploy the code"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::nibr-useast1-as-search-code-deploy-dev/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "code-ec2-permissions-policy-attachment" {
  policy_arn = aws_iam_policy.code-ec2-permissions.arn
  role       = aws_iam_role.code-ec2-instance-profile.name
}
resource "aws_iam_instance_profile" "searchs-api-instance-profile" {
  name = "searchs-api-instance-profile"
  role = "code-ec2-instance-profile" # The role is created in infrastructure template
}

#https://github.com/hashicorp/terraform/issues/15341
