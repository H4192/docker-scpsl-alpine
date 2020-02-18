FROM mono:slim

MAINTAINER Worreh, worreh@gmail.com

ENV STEAMCMDDIR /home/container/steamcmd

RUN apt-get update

RUN apt-get -y install  ca-certificates curl openssl git tar bash sqlite fontconfig wget 
    
RUN apt-get -y install lib32gcc1

RUN cert-sync /etc/ssl/certs/ca-certificates.crt

RUN useradd -d /home/container container


WORKDIR /home/container
RUN mkdir ./server && mkdir ./steamcmd
RUN chown -R container:container ./server 

WORKDIR /home/container/steamcmd
RUN wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - 
RUN chown -R container:container /home/container/steamcmd

USER container
ENV  USER=container HOME=/home/container


WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
