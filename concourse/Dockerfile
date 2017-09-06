FROM concourse/concourse

ADD download-keys.sh /opt/download-keys.sh

RUN apt-get update && \
    apt-get install -y python curl unzip && \
    rm -rf /var/lib/apt/lists/* && \
    curl -s "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    mkdir -p /concourse-keys && \
    chmod +x /opt/download-keys.sh

ENTRYPOINT [ "/opt/download-keys.sh" ]
