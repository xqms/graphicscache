# Base image for the Ubuntu CI jobs (published as xqms/ubuntu_texlive:<version>).
# Build with ci/build.sh.
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get -y --no-install-recommends install \
    texlive-base \
    texlive-latex-extra \
    texlive-extra-utils \
    libfile-copy-recursive-perl \
    libwww-mechanize-perl \
    libhtml-format-perl \
    cm-super \
    zip \
    tar \
    ghostscript && \
  rm -rf /var/lib/apt/lists/*
