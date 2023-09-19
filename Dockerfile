FROM amazonlinux:2
USER root

# Install dependencies

# WORKDIR = directory int the container, changes the current directory.

#added the working directory /app/
WORKDIR /app/
COPY setup.sh .
RUN yum update -y && \
    ./setup.sh && \
    yum -y clean all

WORKDIR /app/
COPY . .
WORKDIR /app/activemq-perftest 
COPY  openwire-producer.properties .
COPY  openwire-consumer.properties .

EXPOSE 80

CMD ["echo","Hello World.....from my first Aamzon MQ activeMQ container image"]