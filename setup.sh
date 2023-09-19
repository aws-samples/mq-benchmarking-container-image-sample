#!/bin/bash
echo $(ls -CF)

cd /app
echo "Installing jq..."
yum install -y jq > /dev/null 2>&1
yum install wget -y
yum install subversion -y > /dev/null 2>&1
yum install mod_dav_svn -y > /dev/null 2>&1
yum install maven -y /dev/null 2>&1 
yum install yum install unzip -y > /dev/null 2>&1
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip > /dev/null 2>&1
rm -f awscliv2.zip > /dev/null 2>&1

./aws/install


java_version=`java -version |& awk -F '"' '/version/ {print $2}'`
if [[ "$java_version" =~ .*1\.8.*  ]]; then
    echo "Java is up to date"
else 
    echo "Updating java to 1.8..."
    wget https://d3pxv6yz143wms.cloudfront.net/8.222.10.1/java-1.8.0-amazon-corretto-devel-1.8.0_222.b10-1.x86_64.rpm > /dev/null 2>&1
    yum localinstall -y java-1.8.0-amazon-corretto-devel-1.8.0_222.b10-1.x86_64.rpm > /dev/null 2>&1
fi

echo "export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))" >> ~/.bashrc
source ~/.bashrc

mvn_version=`mvn -version |& awk '/Apache Maven/ {print $3 }'`
if [[ "$mvn_version" =~ .*3\.6.* ]]; then
    echo "Maven is up to date"
else 
    echo "Updating maven to 3.6..."
    wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz > /dev/null 2>&1
    tar zxvf apache-maven-3.8.6-bin.tar.gz > /dev/null 2>&1
    echo "export PATH=/app/apache-maven-3.6.1/bin:$PATH" >> ~/.bashrc
fi

svn checkout http://svn.apache.org/repos/asf/activemq/sandbox/activemq-perftest/ /app/activemq-perftest > /dev/null 2>&1

if [[ -d /app/activemq-perftest ]];
then
    echo "Installing maven performance plugin..."
    #svn checkout http://svn.apache.org/repos/asf/activemq/sandbox/activemq-perftest/ /app/activemq-perftest > /dev/null 2>&1
    sed -i 's/5.8-SNAPSHOT/5.15.9/g' /app/activemq-perftest/pom.xml 
    mkdir /app/activemq-perftest/reports 
else 
    echo "Maven performance tool does not exist"
fi

source ~/.bashrc
echo "Done."
