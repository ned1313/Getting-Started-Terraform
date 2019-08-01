variable "name" {}
variable "tags" {
    default = {}
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"
  acl = "private"
  force_destroy = "true"

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.s3.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.name}",
                "arn:aws:s3:::${var.name}/*"
            ]
        }
    ]
}
EOF

 tags = "${merge(var.tags, map("Name", format("%s-web-bucket", var.name)))}"
}

resource "aws_iam_user" "s3" {
    name = "${var.name}-s3"
    force_destroy = "true"
}

resource "aws_iam_access_key" "s3" {
    user = "${aws_iam_user.s3.name}"
}

resource "aws_iam_user_policy" "s3_policy" {
    name = "${var.name}-s3-policy"
    user = "${aws_iam_user.s3.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${var.name}",
        "arn:aws:s3:::${var.name}/*"
      ]
    }
  ]
}
EOF
}

output "iam_access_key_id" {
  value = "${aws_iam_access_key.s3.id}"
}
output "iam_access_key_secret" {
  value = "${aws_iam_access_key.s3.secret}"
}
output "bucket" {
    value = "${aws_s3_bucket.bucket.bucket}"
}
output "bucket_id" {
    value = "${aws_s3_bucket.bucket.id}"
}