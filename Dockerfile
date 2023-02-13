FROM jenkins/jenkins:2.375.3 as base

USER root

RUN apt-get update 

# Copies the config into the folder
COPY config.yaml /var/jenkins_home/config.yaml


# Disable the startup wizard
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# Pre-configure the admin user
#ENV JENKINS_OPTS=--argumentsRealm.roles.user=admin --argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin

# Install Plugins for Jenkins from plugins file
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
WORKDIR /usr/share/jenkins/ref
RUN jenkins-plugin-cli -f plugins.txt

EXPOSE 8080

USER jenkins
CMD ["/sbin/tini","--","/usr/local/bin/jenkins.sh"]