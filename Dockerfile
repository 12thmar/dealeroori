FROM phusion/baseimage:0.9.9
MAINTAINER Seid Adem <seid.adem@gmail.com>
#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu precise main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu precise-updates main universe\n" >> /etc/apt/sources.list

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    wget \
    git \
    build-essential \
    libssl-dev \
    curl \
    libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

USER root
ENV HOME /root
ENV NODE_VER v0.10.31


# Install NVM
RUN git clone https://github.com/creationix/nvm.git $HOME/.nvm && \
    echo ". $HOME/.nvm/nvm.sh" >> /etc/bash.bashrc  
RUN /bin/bash -c '. $HOME/.nvm/nvm.sh && nvm install $NODE_VER && nvm use $NODE_VER && nvm alias default $NODE_VER && ln -s $HOME/.nvm/$NODE_VER/bin/node /usr/bin/node && ln -s $HOME/.nvm/$NODE_VER/bin/npm /usr/bin/npm'

RUN cd $HOME/.nvm/$NODE_VER && \
    cp -prf bin/* /usr/local/bin/ && \
    cp -prf lib/* /usr/local/lib/ && \
    cp -prf share/* /usr/local/share/

RUN npm install -g grunt-cli
