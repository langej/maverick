#!/bin/bash

compile() {
	echo ">> compile to xml"
	pug -P $PWD/pom.pug
	mv $PWD/pom.html $PWD/pom.xml
}

start_maven() {
	echo ">> start maven"
	mvn -f $PWD/pom.xml clean install
}

check_requirements() {
	if ! hash pug &> /dev/null; then
		echo "please install pug first.."
		exit 1
	fi
	if ! hash mvn &> /dev/null; then
		echo "please install maven first.."
		exit 1
	fi
}

check_requirements

if [[ $1 == "init" ]]; then
	if [[ ! -e "$PWD/pom.pug" ]]; then
		echo $'doctype xml\nproject\n\tmodelVersion 4.0.0\n\tgroupId\n\tartifactId\n\tversion 0.0.1-SNAPSHOT' > $PWD/pom.pug
	else
		echo "pom already exists.."
	fi
	exit 1
fi

if [[ -e "$PWD/pom.pug" ]]; then
	compile
else
	echo "no pom.pug to compile..."
fi

if [[ -e "$PWD/pom.xml" ]]; then
	start_maven
else
	echo "need a pom.xml to start maven..."
fi
