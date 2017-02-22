FROM ubuntu:16.04 
MAINTAINER Dinesh V

RUN apt-get update && apt-get install -y openssh-server supervisor sudo
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN apt-get install -y wget net-tools vim
RUN apt-get install -y default-jre

RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
RUN sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN sudo apt-get update
RUN sudo apt-get install -y jenkins


COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#COPY supervisord.conf /etc/supervisord.conf

EXPOSE 22
EXPOSE 8080

#ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-2.b15.el7_3.x86_64/jre
ENV JENKINS_HOME /var/lib/jenkins

#CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/bin/supervisord"]
