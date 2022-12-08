FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Fortaleza

RUN apt-get update
RUN apt-get install -y sudo\
                       wget\
                       tzdata\
                       fonts-freefont-ttf

RUN mkdir /data
ADD http://web.cs.ucdavis.edu/~okreylos/ResDev/Vrui/Build-Ubuntu.sh /data
RUN chmod +x /data/Build-Ubuntu.sh
RUN sed -i "s/sudo apt-get install $PREREQUISITE_PACKAGES/sudo apt-get install -y $PREREQUISITE_PACKAGES/g" /data/Build-Ubuntu.sh
RUN /data/Build-Ubuntu.sh

WORKDIR /data
ENTRYPOINT /bin/bash
