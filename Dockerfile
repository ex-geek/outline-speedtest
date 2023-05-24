FROM ubuntu:bionic

RUN apt-get update && apt-get install -y curl wget unzip && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt-get install -y speedtest && \
    mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun && \
    cat /dev/net/tun && \
    apt-get install -y uml-utilities && \
    tunctl -t outline-tap0 && \
    wget -q https://github.com/Jigsaw-Code/outline-go-tun2socks/releases/download/v3.2.0/linux.zip && \
    unzip linux.zip && \
    wget -q https://raw.githubusercontent.com/ex-geek/outline-speedtest/main/entrypoint.sh && \
    chmod 755 ./entrypoint.sh

ENTRYPOINT ./entrypoint.sh