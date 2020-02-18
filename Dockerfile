FROM mono:slim

MAINTAINER Worreh, worreh@gmail.com

ENV STEAMCMDDIR /home/container/steamcmd

RUN apt-get update && \
    apt-get -y install  ca-certificates curl openssl git tar bash sqlite fontconfig wget && \
    apt-get -y install lib32gcc1 && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    useradd -d /home/container container && \
    mkdir -p /home/container/steamcmd && \
    cd $STEAMCMDDIR && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - && \
    chown -R container:container /home/container && \
    chmod +x /home/container/steamcmd/steamcmd.sh
    
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
