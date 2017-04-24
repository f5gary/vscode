# Dockerfile for ubuntu trusty (14.04) running ms visual studio code
FROM ubuntu:trusty
MAINTAINER Gary Ritzer <garyr@f5.com>

# Install visual studio code
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-lxc/lxd-stable
RUN apt-get update && apt-get install -y \
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
  libxtst6 \
  libcanberra-gtk-module \
  libnotify4
RUN rm -rf /var/lib/apt/lists/* && npm update -g
RUN wget https://go.microsoft.com/fwlink/?LinkID=620884 --output-document=/usr/local/vscode.zip
RUN unzip /usr/local/vscode.zip -d /usr/local/
ENV HOME /home/user
RUN useradd -g adm --create-home --home-dir $HOME user && chown -R user:adm $HOME
COPY usr/local/bin/vscode /usr/local/bin/vscode
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
RUN go get -u github.com/golang/lint/golint
RUN go get -u github.com/rogpeppe/godef

WORKDIR $HOME
ENTRYPOINT [ "/usr/local/bin/vscode" ]

