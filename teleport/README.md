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
- `$LOG_OUTPUT` (optional): Logging configuration, possible output values are `stdout`, `stderr` and `syslog`. Defaults to `stdout`
- `$LOG_SEVERITY` (optional): Logging configuration, possible severity values are `INFO`, `WARN` and `ERROR`. Defaults to `ERROR`
- `$CREATE_ADMIN_USER` (optional): If set to `"yes"` it will create a teleport user named admin and put the login url in the logs. Defaults to `"yes"`
- `$ADVERTISE_EC2_IP` (optional): If set to `"yes"` it will set the teleport `advertise_ip` configuration with the IP of the EC2 host this container is running. It'll use `curl -s http://169.254.169.254/latest/meta-data/local-ipv4` to fetch the IP address. Defaults to `"yes"`
- `$SESSION_RECORDING` (optional): Optional setting for configuring session recording. Check the [Teleport documentation](https://gravitational.com/teleport/docs/2.4/admin-guide/#configuration) for more info. Defaults to `"on"`

## Administration commands in auth server (tctl)

Depending on where you run this Docker image, it can be challenging to issue `tctl` administrative commands, as right now you have to run them from within the `auth` server. There's [some work being done](https://github.com/gravitational/teleport/issues/1525) to be able to run `tctl` remotely, but it's not yet implemented.

To overcome this limitation, this image can create an initial admin user in the Teleport cluster, so you can use it to ssh into the `auth` server using Teleport itself and run `tctl`. To achieve this you'll need to run both `auth` and `node` in the same container (set `$ENABLE_AUTH="yes"` and `$ENABLE_NODE="yes"`), so the `auth` server registers itself as a node in the Teleport cluster. You'll also need to set `$CREATE_ADMIN_USER="yes"` (it's like that by default), this will create the admin user on the first boot, if it's not already created, and will output the signup url to `stdout`.

Also note that, by default, the container will use the EC2 private IP address to register to the Teleport cluster. You can turn off this behavior by setting `$ADVERTISE_EC2_IP="no"`, then the auth server will report with the localhost IP address `127.0.0.1`.
