#!/bin/bash

progs="(pacman -Qet && pacman -Qm) | sort -u"
intj=`(pacman -Qet && pacman -Qm) | sort -u | grep intellij`
if [ -z "$intj" ]
then
	yay intellij
fi
maven=`(pacman -Qet && pacman -Qm) | sort -u| grep maven`
if [ -z "$maven" ]
then
	sudo pacman -S maven	
fi
docker=`(pacman -Qet && pacman -Qm) | sort -u | grep docker`
if [ -z "$docker" ]
then
	sudo pacman -S docker
	sudo groupadd docker
	sudo usermod -aG docker $USER
	systemctl reboot
fi

sudo systemctl start docker
sudo systemctl enable docker

docker run hello-world
docker pull centos/postgresql-96-centos7


# Postgres docker usage
# $ docker run -d --name postgresql_database -e POSTGRESQL_USER=user -e POSTGRESQL_PASSWORD=pass -e POSTGRESQL_DATABASE=db -p 5432:5432 rhscl/postgresql-96-rhel7


