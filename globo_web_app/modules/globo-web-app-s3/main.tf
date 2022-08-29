## aws_s3_bucket
resource "aws_s3_bucket" "web_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  policy        = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.elb_service_account_arn}"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/alb-logs/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/alb-logs/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${var.bucket_name}"
    }
  ]
}
    POLICY

  tags = var.common_tags

}

## aws_s3_iam_role
resource "aws_iam_role" "allow_nginx_s3" {
  name = "${var.bucket_name}-allow_nginx_s3"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.common_tags


}

## aws_s3_iam_role_policy
resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${var.bucket_name}_allow_all"
  role = aws_iam_role.allow_nginx_s3.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
    }
  ]
}
EOF
}

## aws_s3_iam_instance_profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.bucket_name}-instance_profile"
  role = aws_iam_role.allow_nginx_s3.name
}