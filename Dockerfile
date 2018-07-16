FROM debian
LABEL MAINTAINER Cyrille Nofficial  "cynoffic@cyrilix.fr"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q build-essential\
                    netcat \
                    cmake libboost-dev libboost-thread-dev libboost-system-dev \
                    libsqlite3-dev curl libcurl4-openssl-dev libusb-dev \
                    zlib1g-dev libssl-dev git\
                    libudev-dev \
                    mplayer2 \
                    python3 \
                    python \
                    python-dev \
                    python-libxml2 \
                    libxml2-dev \
                    python-pip \
                    python3-pip \
                    libxslt-dev \
                    lib32z1-dev \
                    libboost-python-dev \
                    wget \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*

# Rebuild cmake because stable version (3.0.2) incompatible with openssl
RUN wget -O- https://cmake.org/files/v3.5/cmake-3.5.2.tar.gz | tar xzv \
            && cd cmake-3.5.2 \
            && ./configure --prefix=/opt/cmake \
            && make \
            && make install \
            && cd ../


#Compile OpenZWave
RUN git clone https://github.com/OpenZWave/open-zwave.git ;\
    ln -s open-zwave open-zwave-read-only ; \
    cd open-zwave; \
    make; cd ..

