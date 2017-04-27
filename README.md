# docker-concourse
This is a tweaked version of the official upstream concourse image.

We didn't want to use volumes to set the SSH keys so we pull them down from an S3 bucket. All environment variables are the same as the official concourse image. We only added one extra and that is `_CONCOURSE_KEYS_S3`, that expects as input the following format `s3://<bucket_name>`
