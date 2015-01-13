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
  && rm -rf /var/lib/apt/lists/*

# Install NVM
RUN git clone https://github.com/creationix/nvm.git ~/nvm
RUN echo "source ~/nvm/nvm.sh" 

# Install nvm version node.js
RUN sudo "~/nvm/nvm.sh"
    && nvm install v0.10.31 
    && nvm use v0.10.31 
    && nvm alias default v0.10.31

# Install node.js using nvm
RUN ln -s /.nvm/v0.10.18/bin/node /usr/bin/node 
    && ln -s /.nvm/v0.1018/bin/npm /usr/bin/npm

# Install package managers
RUN npm install -g sm

RUN npm install -g requirejs
RUN npm install -g grunt-cli
RUN npm install -g karma
RUN npm install -g request
RUN npm install -g protractor
