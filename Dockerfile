FROM alpine:3.7

MAINTAINER SSR

RUN apk add --update --no-cache --virtual=run-deps \
    openssl \
    ca-certificates \
    py-dnspython \
    certbot \
    tzdata \
    py2-pip

RUN pip install -U setuptools pip && \
    pip install certbot-dns-route53

WORKDIR /

VOLUME /etc/letsencrypt

RUN mkdir /root/certbot-route53

COPY certbot-route53/ /root/certbot-route53/

RUN chmod +x /root/certbot-route53/*.sh

ENTRYPOINT ["/root/certbot-route53/main.sh"]
