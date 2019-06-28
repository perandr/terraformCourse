resource "aws_s3_bucket" "t2-micro-bucket" {
    bucket = "t2-micro-bucket"
    region = "${var.AWS_REGION}"
  
}

output "s3-t2-micro-bucket" {
  value = "${aws_s3_bucket.t2-micro-bucket.arn}"
}
