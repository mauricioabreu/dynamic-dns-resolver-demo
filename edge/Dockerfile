FROM openresty/openresty:bionic

RUN apt-get update \
  && apt-get install -y \
    dnsutils git iputils-ping tcpdump telnet \
  && mkdir /src \
  && cd /src \
  && git config --global url."https://".insteadOf git:// \
  && luarocks install lua-resty-resolver \
  && rm -Rf /src