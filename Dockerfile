# Made based on original version:
# https://github.com/andresriancho/w3af/blob/master/extras/docker/Dockerfile
# See README for why

FROM ubuntu:16.04

# Initial setup
RUN mkdir /home/w3af
WORKDIR /home/w3af

# Update before installing any package
RUN apt-get update -y
RUN apt-get upgrade -y

# Install basic and GUI requirements, python-lxml because it doesn't compile correctly from pip
RUN apt-get install -y python-pip build-essential libxslt1-dev libxml2-dev libsqlite3-dev \
                       libyaml-dev python-dev git python-lxml wget libssl-dev \
                       xdot ca-certificates libffi-dev

# Get and install pip
RUN pip install --upgrade pip

# Pypi dependencies
RUN pip install clamd==1.0.1 PyGithub==1.21.0 GitPython==0.3.2.RC1 pybloomfiltermmap==0.3.14 \
        esmre==0.3.1 phply==0.9.1 nltk==3.0.1 chardet==2.1.1 pdfminer==20140328 \
        futures==2.1.5 pyOpenSSL==0.15.1 scapy-real==2.2.0-dev guess-language==0.2 \
        cluster==1.1.1b3 msgpack-python==0.4.4 python-ntlm==1.0.1 halberd==0.2.4 \
        darts.util.lru==0.5 ndg-httpsclient==0.3.3 pyasn1==0.1.7 Jinja2==2.7.3 \
        vulndb==0.0.17 markdown==2.6.1 psutil==2.2.1 mitmproxy==0.12.1 \
        ruamel.ordereddict==0.4.8 Flask==0.10.1 PyYAML==3.11 \
        termcolor tldextract tblib pyclamd

# Add the w3af user
RUN useradd w3af -d /home/w3af
RUN chown w3af /home/w3af

# Clone w3af from official repo
RUN git clone https://github.com/andresriancho/w3af.git /home/w3af/w3af

# Comment out runtime check for dependencies (the approach feels wrong tbh)
RUN sed 's/    dependency_check\(\)/    # dependency_check\(\)/g' -i /home/w3af/w3af/w3af_api
RUN sed 's/    dependency_check\(\)/    # dependency_check\(\)/g' -i /home/w3af/w3af/w3af_console

# Switch to non-privileged user
USER w3af

WORKDIR /home/w3af/w3af
