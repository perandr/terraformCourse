resource "aws_iam_role" "t2_micro_bucket_role" {
   name = "t2_micro_bucket_role"
#    assume_role_policy = "${data.aws_iam_policy_document.s3-assume-role-policy.json}"

    assume_role_policy = <<POLICY
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
    POLICY
}

resource "aws_iam_instance_profile" "t2_micro_bucket_instance_profile" {
    name = "t2_micro_bucket_instance_profile"
    role = "${aws_iam_role.t2_micro_bucket_role.name}"
}

# ,
#             {
#                 "Effect": "Allow",
#                 "Action" : [
#                     "s3:*"
#                 ],
#                 "Resource": [
#                     "arn:aws:s3:::t2-micro-bucket",
#                     "arn:aws:s3:::t2-micro-bucket/*"
#                 ]
#             }
resource "aws_iam_policy"  "t2_micro_bucket_role_policy" {
    name = "t2_micro_bucket_role_policy"
#   policy = "${data.aws_iam_policy_document.t2_micro_bucket_access_role_policy_doc.json}"
    policy = <<POLICY
{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action" : [
                    "s3:*"
                ],
                "Resource": "*"
            }
        ]
   }
    POLICY
}

resource "aws_iam_policy_attachment" "role-to-polity-attach" {
    name = "role-to-polity-attach"
    roles = ["${aws_iam_role.t2_micro_bucket_role.name}"]
    policy_arn = "${aws_iam_policy.t2_micro_bucket_role_policy.arn}"
}

# # [
# #                     "arn:aws:s3:::t2-micro-bucket",
# #                     "arn:aws:s3:::t2-micro-bucket/*"
# #                 ]

# data "aws_iam_policy_document" "s3-assume-role-policy" {
#   statement {
#     actions = [ "sts:AssumeRole" ]

#     principals {
#       type = "Service"
#       identifiers = ["s3.amazonaws.com"]
#     }
#   }
# }

# # resource "aws_iam_policy" "t2_micro_bucket_access_role_policy" {
# #   # ... other configuration ...

# #   policy = "${data.aws_iam_policy_document.t2_micro_bucket_access_role_policy_doc.json}"
# # }

# data "aws_iam_policy_document" "t2_micro_bucket_access_role_policy_doc" {
#   statement {
#     effect = "Allow"

#     actions = ["s3:*"]

#     resources = [
#         "${aws_s3_bucket.t2-micro-bucket.arn}",
#         "${aws_s3_bucket.t2-micro-bucket.arn}/*"
#         ]
#   }
# }


# output "namt2_micro_bucket_access_role_policy_doc.json" {
#   value = "${data.aws_iam_policy_document.t2_micro_bucket_access_role_policy_doc.json}"
# }
