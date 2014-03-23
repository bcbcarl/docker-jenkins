FROM debian:wheezy
MAINTAINER Carl X. Su <bcbcarl@gmail.com>

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y wget openjdk-7-jre-headless && \
  wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add - && \
  echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y jenkins && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD jenkins /usr/local/bin/

EXPOSE 8080

CMD ["/usr/local/bin/jenkins"]