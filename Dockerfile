FROM alpine

RUN apk update && \
    apk add bash && \
    apk add tcpdump && \
    apk add automake && \
    apk add autoconf && \
    apk add gettext && \
    apk add gcc && \
    apk add g++ && \
    apk add pkgconf && \
    apk add libpcap && \
    apk add libcap-dev && \
    apk add make && \
    mkdir smcroute

COPY . /smcroute/

WORKDIR /smcroute

RUN ./autogen.sh && \
    ./configure --prefix=/usr/local --sysconfdir=/etc --runstatedir=/var/run && \
    make -j5 && \
    make install-strip

WORKDIR /

#COPY smcroute-eth0-cni-bridge.conf /etc/smcroute.conf
#COPY smcroute-eth0-l2-bridge.conf /etc/smcroute.conf
COPY smcroute-eth0-l3-bridge.conf /etc/smcroute.conf

RUN apk del g++ && \
    apk del gcc

ENTRYPOINT [ "bash" ]
#ENTRYPOINT [ "/usr/local/sbin/smcrouted", "-n", "-N", "-l", "debug" ]

