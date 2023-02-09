FROM jenkins/jenkins:2.375.3 as base

USER root

RUN apt-get update 

USER jenkins