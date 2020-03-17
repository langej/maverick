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
content="mixin dependency(group, artifact, version)
	dependency
		groupId= group
		artifactId= artifact
		version= version

doctype xml
project
	modelVersion 4.0.0
	groupId com.example
	artifactId test
	version 0.0.1-SNAPSHOT"
echo "$content" > $PWD/pom.pug
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
