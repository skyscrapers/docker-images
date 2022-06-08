ARG TF_VERSION=1.1.9

FROM skyscrapers/terraform-resource:${TF_VERSION}

# Spoof terraform into terragrunt
RUN mv /usr/local/bin/terraform /usr/local/bin/terraform_spoof

ARG TERRAGRUNT_PATH

# Install terragrunt as terraform
ADD ${TERRAGRUNT_PATH} /usr/local/bin/terraform
RUN chmod +x /usr/local/bin/terraform && \
  touch /root/terragrunt.hcl # this is to allow GET steps in concourse

ENV TERRAGRUNT_TFPATH=/usr/local/bin/terraform_spoof
