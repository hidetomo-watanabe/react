FROM node
MAINTAINER hidetomo

# create user
RUN useradd hidetomo
RUN mkdir /home/hidetomo && chown hidetomo:hidetomo /home/hidetomo

# sudo
RUN apt-get -y update
RUN apt-get -y install sudo
RUN echo "hidetomo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install react
RUN npm install -g create-react-app

# change user and dir
USER hidetomo
WORKDIR /home/hidetomo
ENV HOME /home/hidetomo

# alias
RUN echo "alias ls='ls --color'" >> .bashrc
RUN echo "alias ll='ls -la'" >> .bashrc

# common apt-get
RUN sudo apt-get -y install vim
RUN sudo apt-get -y install less

# change dir
RUN create-react-app my_app
WORKDIR /home/hidetomo/my_app

# add sample
RUN rm -f src/*
RUN touch src/index.css
RUN touch src/index.js
RUN echo "import React from 'react';" >> src/index.js
RUN echo "import ReactDOM from 'react-dom';" >> src/index.js
RUN echo "import './index.css';" >> src/index.js

# change dir
WORKDIR /home/hidetomo

# start
COPY start.sh start.sh
RUN sudo chown hidetomo:hidetomo start.sh
CMD ["/bin/bash", "/home/hidetomo/start.sh"]
