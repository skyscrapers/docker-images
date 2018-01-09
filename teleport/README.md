# Teleport Docker image

This image will run [Teleport](https://gravitational.com/teleport/). Configuration can be tweaked with the following environment variables:

- `$ENABLE_AUTH` (optional): Toggle to enable or disable Teleport `auth` role. Defaults to "yes", set to "no" to disable
- `$ENABLE_PROXY` (optional): Toggle to enable or disable Teleport `proxy` role. Defaults to "yes", set to "no" to disable
- `$ENABLE_NODE` (optional): Toggle to enable or disable Teleport `node` role. Defaults to "no", set to "yes" to enable
- `$CLUSTER_NAME` (**mandatory** if `$ENABLE_AUTH` is set to `"yes"`): Name for the Teleport cluster, required to provide continuity in case you want to run multiple `auth` containers or new containers are launched in the future
- `$AUTH_SERVERS` (**mandatory** if `$ENABLE_PROXY` is set to `"yes"`): Space-separated list of auth server addresses (including the port). This is required if the `proxy` role is enabled. Example: `AUTH_SERVERS="127.0.0.1:3025"`
- `$AUTH_TOKEN` (**mandatory** if `$ENABLE_AUTH` is set to `"no"`): token to use to register with the auth server. It only applies in a standalone proxy server.
- `$DYNAMODB_TABLE` (**mandatory** if `$ENABLE_AUTH` is set to `"yes"`): Name of the DynamoDB table to use, Teleport will automatically create it if doesn't exist
- `$DYNAMODB_REGION` (optional): Region where to deploy the DynamoDB table. Defaults to `eu-west-1`
- `$TOKENS` (optional): Space-separated list of static tokens to configure for the `auth` server. See the Teleport documentation on static tokens [here](https://gravitational.com/teleport/docs/2.3/admin-guide/#static-tokens)
- `$DATA_DIR` (optional): Teleport `data_dir`. Defaults to `/var/lib/teleport`
- `$LOG_OUTPUT` (optional): Logging configuration, possible output values are `stdout`, `stderr` and `syslog`. Defaults to `stdout`
- `$LOG_SEVERITY` (optional): Logging configuration, possible severity values are `INFO`, `WARN` and `ERROR`. Defaults to `ERROR`
- `$CREATE_ADMIN_USER` (optional): If set to `"yes"` it will create a teleport user named admin and put the login url in the logs. Defaults to `"yes"`
- `$ADVERTISE_EC2_IP` (optional): If set to `"yes"` it will set the teleport `advertise_ip` configuration with the IP of the EC2 host this container is running. It'll use `curl -s http://169.254.169.254/latest/meta-data/local-ipv4` to fetch the IP address. Defaults to `"yes"`
