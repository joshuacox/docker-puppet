FROM    debian:wheezy
MAINTAINER Josh Cox <josh 'at' webhosting coop>

RUN apt-get -y update
RUN apt-get -y install rubygems 
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install puppet librarian-puppet
