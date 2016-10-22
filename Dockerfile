From ubuntu:trusty
MAINTAINER henderbj

env DEBIAN_FRONTEND noninteractive

ENV VERSION v4.20-9608-rtm-2016.04.17

WORKDIR /usr/local/vpnclient

RUN apt-get update &&\
        apt-get -y -q install gcc make wget && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Client/64bit_-_Intel_x64_or_AMD64/softether-vpnclient-${VERSION}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnclient.tar.gz &&\
        tar -xzvf /tmp/softether-vpnclient.tar.gz -C /usr/local/ &&\
        rm /tmp/softether-vpnclient.tar.gz &&\
        make i_read_and_agree_the_license_agreement &&\
        apt-get purge -y -q --auto-remove gcc make wget && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD softether.inp start.sh ./
RUN chmod u+x start.sh

CMD ./start.sh

