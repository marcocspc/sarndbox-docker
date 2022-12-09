FROM ubuntu:18.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
ARG DISPLAY
ENV DISPLAY $DISPLAY
ENV TZ=America/Fortaleza

RUN apt-get update
RUN apt-get install -y sudo\
                       wget\
                       tzdata\
                       fonts-freefont-ttf\
                       mlocate\
                       mesa-utils

RUN mkdir /data
ADD http://web.cs.ucdavis.edu/~okreylos/ResDev/Vrui/Build-Ubuntu.sh /data
RUN mkdir -p /etc/udev/rules.d
RUN chmod +x /data/Build-Ubuntu.sh
RUN sed -i "s/sudo apt-get install $PREREQUISITE_PACKAGES/sudo apt-get install -y $PREREQUISITE_PACKAGES/g" /data/Build-Ubuntu.sh
RUN sed -e "/\/bin\/ShowEarthModel/ s/^#*/#/" -i /data/Build-Ubuntu.sh 
RUN /data/Build-Ubuntu.sh

RUN sed -i "s/autoScreenSize true/autoScreenSize false/g" /usr/local/etc/Vrui-8.0/Vrui.cfg
RUN cat /usr/local/etc/Vrui-8.0/Vrui.cfg 

ADD http://web.cs.ucdavis.edu/~okreylos/ResDev/Kinect/Kinect-3.10.tar.gz /data/src/
RUN cd /data/src && tar xvf Kinect-3.10.tar.gz
RUN cd /data/src/Kinect-3.10 && make && make install && make installudevrules

ADD http://web.cs.ucdavis.edu/~okreylos/ResDev/SARndbox/SARndbox-2.8.tar.gz /data/src/
RUN cd /data/src && tar xvf SARndbox-2.8.tar.gz 
RUN cd /data/src/SARndbox-2.8 && make 

RUN ls /usr/local/bin
RUN ls /data/src/SARndbox-2.8/bin

FROM base as nvidia

ARG DRIVER_URL

#Got this from https://github.com/mviereck/x11docker/issues/127#issuecomment-464875030
RUN apt-get install --no-install-recommends -y kmod \
                                               xz-utils \
                                               wget \
                                               ca-certificates 

RUN wget $DRIVER_URL -O /tmp/NVIDIA-installer.run 
RUN sh /tmp/NVIDIA-installer.run \
        --accept-license --no-runlevel-check --no-questions --no-backup --ui=none \
        --no-kernel-module --no-kernel-module-source --no-nouveau-check --no-nvidia-modprobe && \
    rm /tmp/NVIDIA-installer.run 

RUN apt-get remove -y kmod xz-utils wget ca-certificates 

RUN apt-get autoremove -y
