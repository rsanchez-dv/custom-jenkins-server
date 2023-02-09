FROM jenkins/jenkins:2.375.3 as base

USER root

RUN apt-get update 
# Disable the startup wizard
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# Pre-configure the admin user
#ENV JENKINS_OPTS=--argumentsRealm.roles.user=admin --argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin

# Install Plugins for Jenkins from plugins file
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
WORKDIR /usr/share/jenkins/ref
RUN jenkins-plugin-cli -f plugins.txt

USER jenkins