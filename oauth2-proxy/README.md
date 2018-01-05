# oauth2-proxy Docker image

This will run a [oauth2-proxy](https://github.com/bitly/oauth2_proxy) server, in front of a configurable backend.

The server can be configured either via environment variables or command line flags. Client id and Client secret parameters can be retrieved from Vault providing the following environment variables:

- `$OAUTH_CREDS_VAULT_PATH` (optional): the path in Vault where to retrieve the credentials from. Setting this variable will enable the Vault integration, it's off by default.
- `$VAULT_URL` (mandatory if `$OAUTH_CREDS_VAULT_PATH is` is set): the URL of the Vault server
- `$VAULT_AUTH_METHOD` (optional): the auth method to use to authenticate with Vault. Defaults to `aws`
- `$VAULT_AUTH_PARAM` (mandatory if `$OAUTH_CREDS_VAULT_PATH` is set): the parameters to provide to the Vault auth call.
