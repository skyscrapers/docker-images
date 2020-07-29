FROM alpine:latest
ARG KUBEAUDIT_BIN_PATH=kubeaudit
COPY ${KUBEAUDIT_BIN_PATH} /bin/
ENTRYPOINT ["/bin/kubeaudit"]
