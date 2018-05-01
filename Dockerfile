FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade

RUN apt-get -y install git python-virtualenv curl wget sudo net-tools

RUN apt-get -y install build-essential ipython python-setuptools python-pip python-dev libssl-dev libffi-dev couchdb pkg-config libssl-dev libffi-dev libxml2-dev libxslt1-dev libfreetype6-dev libpng-dev


WORKDIR /root
RUN git clone https://github.com/infobyte/faraday.git faraday-dev
WORKDIR ./faraday-dev
RUN sed -i '22i\    return True' utils/user_input.py
RUN ./install.sh

RUN ./faraday-server.py

RUN service couchdb start
RUN couchdb -b
RUN sleep 2
RUN netstat -tulpn

RUN ./faraday-server.py
