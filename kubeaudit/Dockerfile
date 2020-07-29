ARG KUBEAUDIT_BIN_PATH=kubeaudit
FROM alpine:latest
COPY ${KUBEAUDIT_BIN_PATH} /bin/
ENTRYPOINT ["/bin/kubeaudit"]
