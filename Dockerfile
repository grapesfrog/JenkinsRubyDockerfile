
###########################################################################
# Creates a base Fedora image with Jenkins and plugins to run ruby builds #
###########################################################################

# Use the fedora base image
FROM fedora:latest 

MAINTAINER gmollison <grapesfrog@gmail.com>

# Update the system
RUN yum -y update;yum clean all



##########################################################
# Install Java JDK
##########################################################
RUN yum -y install java-1.7.0-openjdk
ENV JAVA_HOME /usr/lib/jvm/jre


####################################################
# Install pre reqs
####################################################
RUN yum install -y   g++  which curl  unzip openssl openssl-devel make gcc-c++ glibc-devel

# install ruby and nodejs
RUN yum  -y install ruby
RUN yum  -y install nodejs npm


#####################################
#  Installl Ruby gems
#####################################
RUN gem install rspec rake rails bundler ci_reporter --no-document


######################################
#  Install jenkins & git
######################################

ADD http://pkg.jenkins-ci.org/redhat/jenkins.repo /etc/yum.repos.d/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum -y install jenkins
RUN yum -y install git

ENV JENKINS_HOME  /usr/local/jenkins
########################################################################
# Install jenkins plugins <- need more efficient way of doing this step
########################################################################
ADD https://updates.jenkins-ci.org/latest/scm-api.hpi /var/lib/jenkins/plugins/scm-api.hpi
ADD https://updates.jenkins-ci.org/latest/ssh-agent.hpi /var/lib/jenkins/plugins/ssh-agent.hpi
ADD https://updates.jenkins-ci.org/latest/git-client.hpi /var/lib/jenkins/plugins/git-client.hpi
ADD https://updates.jenkins-ci.org/latest/git.hpi /var/lib/jenkins/plugins/git.hpi
ADD https://updates.jenkins-ci.org/latest/copyartifact.hpi /var/lib/jenkins/plugins/opyartifact.hpi
ADD https://updates.jenkins-ci.org/latest/s3.hpi /var/lib/jenkins/plugins/s3.hpi
ADD https://updates.jenkins-ci.org/latest/github.hpi /var/lib/jenkins/plugins/github.hpi
ADD https://updates.jenkins-ci.org/latest/github-api.hpi  /var/lib/jenkins/plugins/github-api.hpi
ADD https://updates.jenkins-ci.org/latest/github-sqs-plugin.hpi /var/lib/jenkins/plugins/github-sqs-plugin.hpi
ADD https://updates.jenkins-ci.org/latest/ruby-runtime.hpi /var/lib/jenkins/plugins/ruby-runtime.hpi
ADD https://updates.jenkins-ci.org/latest/token-macro.hpi /var/lib/jenkins/plugins/token-macro.hpi
ADD https://updates.jenkins-ci.org/latest/rake.hpi var/lib/jenkins/plugins/rake.hpi
ADD https://updates.jenkins-ci.org/latest/rbenv.hpi /var/lib/jenkins/plugins/rbenv.hpi
ADD https://updates.jenkins-ci.org/latest/rvm.hpi /var/lib/jenkins/plugins/rvm.hpi

RUN chown -R jenkins:jenkins /var/lib/jenkins/plugins

# Install RVM
RUN  curl -L https://get.rvm.io | bash -s stable --ruby


# for main web interface:
EXPOSE 8080 

# will be used by attached slave agents:
EXPOSE 50000

CMD service sshd start ; service jenkins start ; bash
