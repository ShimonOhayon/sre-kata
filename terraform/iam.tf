resource "aws_iam_role" "role" {
  name               = "${var.service_name}-role"
  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": [
           "build.apprunner.amazonaws.com"
        ]
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "apprunner-attach" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}
