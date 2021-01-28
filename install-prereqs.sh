#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo apt-get -y dist-upgrade
sudo apt-get install -y --no-install-recommends \
        software-properties-common \
        freetds-bin \
        krb5-user \
        ldap-utils \
        libffi6 \
        libsasl2-2 \
        libsasl2-modules \
        libssl1.1 \
        locales  \
        lsb-release \
        sasl2-bin \
        sqlite3 \
        unixodbc \
	python3-venv \
	libpq-dev
sudo add-apt-repository -yppa:deadsnakes/ppa
sudo apt-get install -y python3.8 python3.8-dev python3.8-venv
sudo apt-get install -y build-essential
sudo apt-get install -y postgresql postgresql-contrib

