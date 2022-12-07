FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Fortaleza

RUN apt-get update
RUN apt-get install -y sudo\
                       wget\
                       tzdata

RUN apt-get install -y build-essential\
                       g++\
                       libudev-dev\
                       libdbus-1-dev\
                       libusb-1.0-0-dev\
                       zlib1g-dev\
                       libssl-dev\
                       libpng-dev\
                       libjpeg-dev\
                       libtiff-dev\
                       libasound2-dev\
                       libspeex-dev\
                       libopenal-dev\
                       libv4l-dev\
                       libdc1394-22-dev\
                       libtheora-dev\
                       libbluetooth-dev\
                       libfreetype6-dev\
                       libxi-dev\
                       libxrandr-dev\
                       mesa-common-dev\
                       libgl1-mesa-dev\
                       libglu1-mesa-dev

RUN mkdir /data
RUN cd /data && wget https://web.cs.ucdavis.edu/~okreylos/ResDev/Vrui/$VRUI_VERSION.tar.gz
RUN cd /data && tar xvf $VRUI_VERSION.tar.gz
RUN cd /data/$VRUI_VERSION && make
