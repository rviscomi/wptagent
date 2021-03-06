# FROM debian:jessie-slim
FROM ubuntu

RUN apt-get update && \
  apt-get install -y \
    wget \
    curl \
    python \
    python-pip \
    xvfb \
    imagemagick \
    python-dev \
    zlib1g-dev \
    libjpeg-dev \
    psmisc \
    dbus-x11 \
    sudo \
    kmod \
    ffmpeg \
    net-tools \
    tcpdump

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt-get update && \
  apt-get install -y \
    google-chrome-stable \
    nodejs

RUN npm install -g lighthouse

RUN pip install \
    dnspython \
    monotonic \
    pillow \
    psutil \
    requests \
    ujson \
    websocket-client \
    xvfbwrapper

COPY wptagent.py /wptagent/wptagent.py
COPY internal /wptagent/internal
COPY docker/linux-headless/entrypoint.sh /wptagent/entrypoint.sh
COPY docker/linux-headless/browsers.ini /wptagent/browsers.ini

WORKDIR /wptagent

CMD ["/bin/bash", "/wptagent/entrypoint.sh"]
