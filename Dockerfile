FROM ubuntu:bionic

RUN apt-get update && apt-get install -y curl wget unzip uml-utilities
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
RUN apt-get install -y speedtest
RUN tunctl -t outline-tap0
RUN wget -q https://github.com/Jigsaw-Code/outline-go-tun2socks/releases/download/v3.2.0/linux.zip
RUN unzip linux.zip
RUN wget -q https://raw.githubusercontent.com/ex-geek/outline-speedtest/main/entrypoint.sh
RUN chmod 755 ./entrypoint.sh

ENTRYPOINT ./entrypoint.sh