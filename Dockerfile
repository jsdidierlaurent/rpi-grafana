FROM resin/rpi-raspbian:jessie
LABEL maintainer "Jean-Sébastien Didierlaurent <js.didierlaurent@gmail.com>"

RUN apt-get update && \
    apt-get install \
    curl \
    libfontconfig \ 
    ca-certificates \
    wget \
    git && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -s https://packagecloud.io/install/repositories/pithings/rpi/script.deb.sh | bash

RUN mkdir -p /var/lib/grafana
RUN mkdir -p /var/log/grafana

RUN wget https://github.com/fg2it/grafana-on-raspberry/releases/download/v4.2.0/grafana_4.2.0_armhf.deb && \
    dpkg -i grafana_4.2.0_armhf.deb && \
    rm -f grafana_4.2.0_armhf.deb

EXPOSE 3000

VOLUME ["/etc/grafana","/var/log/grafana","/var/lib/grafana"]

WORKDIR /usr/share/grafana
CMD ["/usr/sbin/grafana-server","-config","/etc/grafana/grafana.ini","cfg:default.paths.logs=/var/log/grafana","cfg:default.paths.data=/var/lib/grafana"]