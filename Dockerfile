# Dockerfile for ubuntu trusty (14.04) running ms visual studio code
FROM ubuntu:trusty
MAINTAINER Gary Ritzer <gwritz@gmail.com>

WORKDIR /usr/local
ENV HOME /home/user
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin

COPY usr/local/bin/vscode /usr/local/bin/vscode

# Install visual studio code
RUN apt-get update && apt-get install -y software-properties-common && \
  add-apt-repository ppa:ubuntu-lxc/lxd-stable && \
  apt-get update && apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  git \
  golang \
  libc6-dev \
  nodejs \
  npm \
  unzip \
  wget \
  libasound2 \
  libgconf-2-4 \
  libgnome-keyring-dev \
  libgtk2.0-0 \
  libnss3 \
  libpci3 \
  libxss1 \
  libxtst6 \
  libcanberra-gtk-module \
  libnotify4 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && npm update -g && \
  wget https://go.microsoft.com/fwlink/?LinkID=620884 --output-document=/usr/local/vscode.tgz && \
  tar -xzvf vscode.tgz && \
  useradd -g adm --create-home --home-dir $HOME user && chown -R user:adm $HOME && \
  go get -u github.com/golang/lint/golint && \
  go get -u github.com/rogpeppe/godef

WORKDIR $HOME
ENTRYPOINT [ "/usr/local/bin/vscode" ]

