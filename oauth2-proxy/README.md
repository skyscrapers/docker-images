# oauth2-proxy Docker image

This will run a [oauth2-proxy](https://github.com/bitly/oauth2_proxy) server, in front of a configurable backend.

The server can be configured either via environment variables or command line flags. Client id and Client secret parameters can be retrieved from Vault providing the following environment variables:

- `$OAUTH_CREDS_VAULT_PATH` (optional): the path in Vault where to retrieve the credentials from. Setting this variable will enable the Vault integration, it's off by default.
- `$VAULT_URL` (mandatory if `$OAUTH_CREDS_VAULT_PATH is` is set): the URL of the Vault server
- `$VAULT_AUTH_METHOD` (optional): the auth method to use to authenticate with Vault. Defaults to `aws`
- `$VAULT_AUTH_PARAM` (mandatory if `$OAUTH_CREDS_VAULT_PATH` is set): a comma-separated list of the parameters to provide to the Vault auth call.

## Usage examples

### Without Vault

You just need to run the container with the appropriate parameters for `oauth2_proxy`. You can check the [official documentation](https://github.com/bitly/oauth2_proxy#configuration) for the full configuration options.

```
docker run -p 4180:4180 skyscrapers/oauth2-proxy -provider github -client-id foo -client-secret bar -upstream https://google.com -cookie-secret somethingsecret -email-domain="*"
```

### With Vault

If you want to fetch the client-id and client-secret from a Vault server:

```
docker run -p 4180:4180 -e OAUTH_CREDS_VAULT_PATH=some/path/in/vault -e VAULT_URL=https://vault.example.com -e VAULT_AUTH_PARAM="header_value=vault.example.com,role=some_iam_role_name" skyscrapers/oauth2-proxy -provider github -upstream https://google.com -cookie-secret somethingsecret -email-domain="*"
```

**Note**: this will look for an item in Vault in the path `some/path/in/vault` that contains two keys: `client-id` and `client-secret` with their corresponding values. For example:

```
$ vault read some/path/in/vault
Key                     Value
---                     -----
refresh_interval        768h0m0s
client-id               foo
client-secret           bar
```
