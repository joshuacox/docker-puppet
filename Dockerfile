FROM ubuntu:trusty
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKER_PUPPET_UPDATED 20150321
RUN apt-get -y update
RUN apt-get -y install ruby-defaults wget git
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install puppet librarian-puppet
