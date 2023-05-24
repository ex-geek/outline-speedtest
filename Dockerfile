FROM ubuntu:bionic

RUN apt-get update && apt-get install -y curl wget unzip
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
RUN apt-get install -y speedtest
#RUN mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun
RUN apt-get install -y uml-utilities
RUN wget -q https://github.com/Jigsaw-Code/outline-go-tun2socks/releases/download/v3.2.0/linux.zip
RUN unzip linux.zip
RUN wget -q https://raw.githubusercontent.com/ex-geek/outline-speedtest/main/entrypoint.sh
RUN chmod 755 ./entrypoint.sh

ENTRYPOINT ./entrypoint.sh