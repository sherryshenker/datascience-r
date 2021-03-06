FROM rocker/verse:3.4.4
MAINTAINER support@civisanalytics.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
        curl \
        wget && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# tuck the python client here just in case
COPY ./requirements-python.txt /requirements-python.txt
RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install -r requirements-python.txt && \
    rm -rf ~/.cache/pip && \
    rm -f get-pip.py

RUN Rscript -e "devtools::install_github('civisanalytics/civis-r', ref = 'v1.3.0', upgrade_dependencies = FALSE);"

ENV VERSION=2.5.0 \
    VERSION_MAJOR=2 \
    VERSION_MINOR=5 \
    VERSION_MICRO=0
