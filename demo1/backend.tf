terraform {
    backend "s3" {
        bucket  = "perandr.terraform-course.bucket"
        key = "terraform-course/state"
        region = "eu-north-1"
        skip_region_validation = true
    }
}
