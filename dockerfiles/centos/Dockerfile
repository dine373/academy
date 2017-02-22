FROM centos
MAINTAINER Dinesh V

RUN yum update -y
RUN yum install -y openssh-server sudo
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:password' | chpasswd
RUN yum install -y wget net-tools java-1.8.0-openjdk

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
RUN rpm -ivh epel-release-7-9.noarch.rpm
RUN sudo yum install -y supervisor

RUN sudo yum clean all
RUN sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN sudo yum install -y jenkins
RUN sudo chkconfig jenkins on

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 22
EXPOSE 8080

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-2.b15.el7_3.x86_64/jre
ENV JENKINS_HOME /var/lib/jenkins

#CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/bin/supervisord"]
