FROM ubuntu:latest

RUN apt update 
RUN apt upgrade -y
RUN apt install unzip transmission-daemon openvpn wget curl iputils-ping traceroute -y

WORKDIR /app/

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENV PIA_OPENVPN_URL "https://www.privateinternetaccess.com/openvpn/openvpn.zip"
ENV PIA_OPENVPN_FILE "belgium.ovpn"
ENV PIA_USERNAME "replaceme"
ENV PIA_PASSWORD "replaceme"

ENV TRANSMISSION_USERNAME "transmission"
ENV TRANSMISSION_PASSWORD "transmission"

EXPOSE 9091

CMD [ "/bin/bash", "entrypoint.sh" ]