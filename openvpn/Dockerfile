FROM kylemanna/openvpn:latest

RUN apk add vault jq libcap --no-cache && setcap cap_ipc_lock= /usr/sbin/vault && chmod +rx /usr/sbin/vault
