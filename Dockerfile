FROM debian:wheezy
MAINTAINER Carl X. Su <bcbcarl@gmail.com>

RUN \
  echo "root:root" | chpasswd && \
  mkdir /var/run/sshd && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y openssh-server && \
  DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y wget python-pip expect iceweasel xvfb openjdk-7-jre-headless && \
  wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add - && \
  echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y jenkins && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  pip install robotframework-selenium2library

ADD jenkins /usr/local/bin/
ADD jenkins-init /usr/local/bin/
ADD run /usr/local/bin/
ADD SimpleTest.txt /opt/robot-demo/

EXPOSE 22
EXPOSE 8080

CMD ["/usr/local/bin/run"]