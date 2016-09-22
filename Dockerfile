FROM ubuntu:14.04
MAINTAINER Marcelo Corpucci <mcorpucci@gmail.com>

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3.4 python3-pip wget libffi-dev libssl-dev python3-pyside git

RUN pip3 install errbot sleekxmpp pyasn1 pyasn1-modules slackclient setuptools --upgrade

RUN mkdir /opt/spencer
RUN mkdir /opt/spencer/plugins
RUN git clone git://github.com/MarceloCorpucci/spencer-errbot.git /opt/spencer/plugins
RUN mkdir /opt/spencer/data
RUN touch /opt/spencer/config.py
RUN echo " \n\
import logging \n\
BACKEND = 'Slack' \n\
BOT_DATA_DIR = r'/opt/spencer/data' \n\
BOT_EXTRA_PLUGIN_DIR = '/opt/spencer/plugins' \n\
BOT_LOG_FILE = r'/opt/spencer/errbot.log' \n\
BOT_LOG_LEVEL = logging.DEBUG \n\
BOT_IDENTITY = { \n\
    'token' : 'xoxb-75459192881-6Bqjjjws25YnDVAv14yYVjoI', \n\
} \n\
BOT_ADMINS = ('@corpu', ) \n\ 
" >> /opt/spencer/config.py

RUN errbot