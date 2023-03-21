FROM ubuntu:22.04
MAINTAINER SERFIM T.I.C.

RUN apt update && DEBIAN_FRONTEND=noninteractive apt -y install \
        locales \
        curl \
        lsb-release \
        gnupg2 \
        software-properties-common \
        apt-utils \
        ca-certificates \
        jq \
        python-pip \
        git \
        awscli

ADD serfimtic.cacert.pem /usr/local/share/ca-certificates/serfimtic.cacert.pem
RUN chmod 644 /usr/local/share/ca-certificates/serfimtic.cacert.pem && update-ca-certificates

# Boundary & Vault client
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get -y install boundary vault