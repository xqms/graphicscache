FROM ubuntu:20.04

# Disable interactive questions
ENV DEBIAN_FRONTEND=noninteractive

# Install TeX Live
RUN apt-get update && apt-get -y install texlive-latex-base texlive-latex-extra && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

