FROM concourse/concourse

# This is the release of Vault to pull in.
ARG VAULT_VERSION=0.9.0

ADD entrypoint.sh /opt/entrypoint.sh

RUN apt-get update && \
    apt-get install -y python curl unzip gnupg && \
    rm -rf /var/lib/apt/lists/* && \
    curl -s "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    mkdir -p /concourse-keys && \
    chmod +x /opt/entrypoint.sh && \
    curl -s "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" -o "vault_${VAULT_VERSION}_linux_amd64.zip" && \
    curl -s "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS" -o "vault_${VAULT_VERSION}_SHA256SUMS" && \
    curl -s "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig" -o "vault_${VAULT_VERSION}_SHA256SUMS.sig" && \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C && \
    gpg --batch --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS && \
    grep vault_${VAULT_VERSION}_linux_amd64.zip vault_${VAULT_VERSION}_SHA256SUMS | sha256sum -c && \
    unzip -d /bin vault_${VAULT_VERSION}_linux_amd64.zip

ENTRYPOINT [ "/opt/entrypoint.sh" ]
