FROM phusion/baseimage:0.9.22
MAINTAINER Perry Street Software

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-add-repository ppa:brightbox/ruby-ng -y
RUN apt-get update && apt-get install -y ruby2.4 ruby2.4-dev git-core build-essential zlib1g-dev
RUN apt-get install -y wget curl telnet

RUN gem install bundler
RUN cd /opt

COPY . /opt/localstack_ruby_client/
RUN cd /opt/localstack_ruby_client ; bundle install

WORKDIR /opt/localstack_ruby_client
