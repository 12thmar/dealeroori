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

USER root
ENV HOME /root
ENV NODE_VER v0.10.31


# Install NVM
RUN git clone https://github.com/creationix/nvm.git $HOME/.nvm && \
    echo ". $HOME/.nvm/nvm.sh" >> /etc/bash.bashrc  
RUN /bin/bash -c ". $HOME/.nvm/nvm.sh 
                  && nvm install $NODE_VER 
                  && nvm use $NODE_VER
                  && nvm alias default $NODE_VER 
                  && ln -s /.nvm/$NODE_VER/bin/node /usr/bin/node 
                  && ln -s /.nvm/$NODE_VER/bin/npm /usr/bin/npm"

##

##    nvm use $NODE_VER && \
##    nvm alias default $NODE_VER


# Install NVM
#RUN git clone https://github.com/creationix/nvm.git $HOME/.nvm && \
#   echo '\n#The Following loads nvm, and install Node.js which version is assigned to $NODE_ENV' && \
#   echo 'source ~/.nvm/nvm.sh' && \
#   echo 'echo "Installing node@${NODE_VER}, this may take several minutes..."' && \
#   echo 'nvm install ${NODE_VER}' && \
#   echo 'nvm alias default ${NODE_VER}' && \
#   echo 'echo "Install node@${NODE_VER} finished."'
## ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
## CMD ["bash"]


##RUN echo '\n#The Following loads nvm, and install Node.js which version is assigned to $NODE_ENV' >> $HOME/.profile
##RUN echo '. ~/.nvm/nvm.sh' >> $HOME/.profile
##RUN echo 'echo "Installing node@${NODE_VER}, this may take several minutes..."' >> $HOME/.profile
##RUN echo 'nvm install ${NODE_VER}' >> $HOME/.profile
##RUN echo 'nvm alias default ${NODE_VER}' >> $HOME/.profile
##RUN echo 'echo "Install node@${NODE_VER} finished."' >> $HOME/.profile
## ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
## CMD ["bash"]


##RUN echo "source ~/nvm/nvm.sh" 

### Install nvm version node.js
##RUN sudo "~/nvm/nvm.sh"
##    && nvm install v0.10.31 
##    && nvm use v0.10.31 
##    && nvm alias default v0.10.31

# Install node.js using nvm
#RUN ln -s /.nvm/v0.10.18/bin/node /usr/bin/node 
#    && ln -s /.nvm/v0.1018/bin/npm /usr/bin/npm

# Install package managers
#RUN npm install -g sm

#RUN npm install -g requirejs
#RUN npm install -g grunt-cli
#RUN npm install -g karma
#RUN npm install -g request
#RUN npm install -g protractor
