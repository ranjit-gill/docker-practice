FROM ubuntu:18.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
ENV HIPPO_URL http://download.demo.onehippo.com/7.9.4/HippoCMS-GoGreen-Enterprise-7.9.4.zip
ENV HIPPO_FILE HippoCMS-GoGreen-Enterprise-7.9.4.zip
RUN curl -L $HIPPO_URL -o $HIPPO_FILE
