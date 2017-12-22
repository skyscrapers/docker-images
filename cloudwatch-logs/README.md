# Cloudwatch Logs Docker image

This image uses the awslogs agent to ship log files to Cloudwatch Logs.

## Usage

You'll need to mount a volume from where the logs will be fetched. Then the different log files are configured via the command arguments.

Example:

```
docker run \
  -v /var/myapp/logs/:/mnt/logs \
  -e AWS_REGION=eu-west-1 \
  skyscrapers/cloudwatch-logs \
  /mnt/logs/my-file.log:my-log-group \
  /mnt/logs/folder/*.log:my-other-group \
  /mnt/logs/more-logs.log:another-group:log-stream-name
```

## Notes

- If you're not using an IAM role, you'll need to provide the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.
- `AWS_REGION` defaults to `eu-west-1`
