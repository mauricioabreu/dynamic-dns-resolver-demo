FROM ubuntu/nginx:latest

RUN apt-get update \
    && apt-get install -y libnss3-tools wget

RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64

RUN cp mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert && chmod +x /usr/local/bin/mkcert

RUN mkcert -install

RUN mkcert ddnsr-demo.com "*.ddnsr-demo.com" localhost 127.0.0.1 ::1