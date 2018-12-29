FROM ubuntu:18.04
#RUN DEBIAN_FRONTEND=noninteractive apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
#ENV HIPPO_URL http://download.demo.onehippo.com/7.9.4/HippoCMS-GoGreen-Enterprise-7.9.4.zip
#ENV HIPPO_FILE HippoCMS-GoGreen-Enterprise-7.9.4.zip
#RUN curl -L $HIPPO_URL -o $HIPPO_FILE

#Set Environment Variables
ENV PATH /srv/hippo/bin:$PATH
ENV HIPPO_FILE HippoCMS-Enterprise-7.9.4.zip
ENV HIPPO_FOLDER HippoCMS-Enterprise-7.9.4
ENV HIPPO_URL http://download.demo.onehippo.com/7.9.4/HippoCMS-GoGreen-Enterprise-7.9.4.zip
 
#Create Working Directory
RUN mkdir -p /srv/hippo

#Add Oracle Java Repositories
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-set-default
