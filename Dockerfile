FROM python:2.7.16-slim-stretch

LABEL MAINTAINER "João Maia <joao@joaovrmaia.com>"

WORKDIR /opt

ENV APT_PKGS="\
    gcc python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev \
    build-essential vim tmux htop wget netcat nmap iptables wireshark sudo \
    apache2-utils curl iproute2 python-setuptools python-pip python-eventlet \
    python-lxml python-msgpack lsb-release tcpdump openvswitch-testcontroller \
    net-tools vim xterm terminator iputils-ping iceweasel" \
    DEBIAN_FRONTEND=noninteractive \
    RYU_BASE_URL=https://github.com/osrg/ryu/archive \
    RYU_VERSION=4.32 \
    MININET_BASE_URL=https://github.com/mininet/mininet/archive \
    MININET_VERSION=2.2.2

RUN apt update \
    && apt dist-upgrade -y \
    && apt install -y --no-install-recommends ${APT_PKGS} \
    && rm -rf /var/lib/apt/lists/* \
    && curl -kL ${RYU_BASE_URL}/v${RYU_VERSION}.tar.gz | tar -xvz \
    && mv ryu-${RYU_VERSION} ryu \
    && cd ryu \
    && pip install -r tools/pip-requires \
    && python setup.py install \
    && cd - \
    && curl -kL ${MININET_BASE_URL}/${MININET_VERSION}.tar.gz | tar -xvz \
    && mv mininet-${MININET_VERSION} mininet \
    && cd mininet \
    && mkdir -p /usr/share/man/man1 \
    && ./util/install.sh -a \
    && update-rc.d openvswitch-switch enable \
    && ln -s /usr/bin/ovs-testcontroller /usr/bin/ovs-controller \
    && cd /opt \
    && cp -r mininet/examples . \
    && rm -rf mininet
