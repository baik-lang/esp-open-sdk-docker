FROM ubuntu:trusty
RUN apt-get -y update

RUN apt-get install -y software-properties-common
RUN add-apt-repository multiverse
RUN apt-get -y update
RUN apt-get install -y make unrar autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
    sed git unzip bash help2man wget bzip2
RUN useradd --create-home -s /bin/bash builder
RUN adduser builder sudo
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers 
USER builder
WORKDIR /home/builder
ADD build-esp-open-sdk.sh .
RUN ./build-esp-open-sdk.sh
