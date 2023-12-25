FROM ubuntu:latest

# Update and upgrade the system
RUN apt update -y && apt upgrade -y

# Install required dependencies when installing from GitHub
RUN apt install git -y \
    && apt install make -y \
    && apt install automake -y \
    && apt install libtool -y \
    && apt install flex -y \
    && apt install bison -y \
    && apt install pkgconf -y \
    && apt install cmake -y

# Install required dependencies
RUN apt install libpopt-dev -y \
    && apt install zlib1g-dev -y \
    && apt install openjdk-11-jdk -y \
    && apt install ant -y

# install sylvan & sylvan dependencies 
RUN mkdir -p /usr/ltsmin

WORKDIR /usr/ltsminbin

RUN apt-get update && apt-get install libgmp-dev libhwloc-dev -y

RUN git clone https://github.com/Codermann63/sylvan.git

WORKDIR /usr/ltsminbin/sylvan/build
RUN cmake ..
RUN make
RUN make install
RUN make test
RUN rm -rf /sylvan

WORKDIR /usr/ltsminbin

# PNML dependencies 
RUN apt-get install xml2 libxml2-dev -y
