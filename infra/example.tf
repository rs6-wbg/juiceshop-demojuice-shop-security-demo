resource "aws_s3_bucket" "bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"  # insecure!
}
