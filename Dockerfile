#Download Ubuntu 18.04 OS
FROM ubuntu:18.04

#Set Environment Variables
ENV PATH /srv/hippo/bin:$PATH
ENV HIPPO_FILE HippoCMS-Enterprise-7.9.4.zip
ENV HIPPO_FOLDER HippoCMS-GoGreen-Enterprise-7.9.4
ENV HIPPO_URL http://download.demo.onehippo.com/7.9.4/HippoCMS-GoGreen-Enterprise-7.9.4.zip
 
#Create Working Directory
RUN mkdir -p /srv/hippo

#Add Oracle Java Repositories
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get update

#Accept License Agreement for Oracle JDK & Install JDK 8
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-set-default

#Install Packages CURL, DOS2UNIX, UNZIP
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl dos2unix unzip

#Download Hippo CMS Package
RUN curl -L $HIPPO_URL -o $HIPPO_FILE

#Extract the Hippo CMS Package & Provide Environments 
RUN unzip $HIPPO_FILE
RUN mv $HIPPO_FOLDER/tomcat/* /srv/hippo
RUN chmod 700 /srv/hippo* -R
RUN dos2unix /srv/hippo/bin/setenv.sh
RUN dos2unix /srv/hippo/bin/catalina.sh

#Open the Port
EXPOSE 8080

#Start the hippo CMS Application
WORKDIR /srv/hippo
CMD ["catalina.sh", "run"]
