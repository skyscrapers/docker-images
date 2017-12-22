# Teleport Docker image

This image will run [Teleport](https://gravitational.com/teleport/). Configuration can be tweaked with the following environment variables:

- `$ENABLE_AUTH` (optional): Toggle to enable or disable Teleport `auth` role. Defaults to "yes", set to "no" to disable
- `$ENABLE_PROXY` (optional): Toggle to enable or disable Teleport `proxy` role. Defaults to "yes", set to "no" to disable
- `$CLUSTER_NAME` (**mandatory** if `$ENABLE_AUTH` is set to `"yes"`): Name for the Teleport cluster, required to provide continuity in case you want to run multiple `auth` containers or new containers are launched in the future.
- `$AUTH_SERVERS` (**mandatory** if `$ENABLE_PROXY` is set to `"yes"`): Space-separated list of auth server addresses (including the port). This is required if the `proxy` role is enabled. Example: `AUTH_SERVERS="127.0.0.1:3025"`
- `$DYNAMODB_TABLE` (**mandatory** if `$ENABLE_AUTH` is set to `"yes"`): Name of the DynamoDB table to use, Teleport will automatically create it if doesn't exist.
- `$DYNAMODB_REGION` (optional): Region where to deploy the DynamoDB table. Defaults to `eu-west-1`
- `$TOKENS` (optional): Space-separated list of static tokens to configure for the `auth` server. See the Teleport documentation on static tokens [here](https://gravitational.com/teleport/docs/2.3/admin-guide/#static-tokens).
