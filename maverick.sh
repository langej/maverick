#!/bin/bash

overwrite_line() { echo -e "\r\033[1A\033[0K$@"; }

compile() {
echo "[1/2] compile to xml"
file=`cat $PWD/pom.pug`
text="mixin dependency(group, artifact, version)
	dependency
		groupId= group
		artifactId= artifact
		version= version

doctype xml
$file"
echo "$text" | pug -Ps > pom.xml
}

start_maven() {
	overwrite_line "[2/2] run maven"
	echo -e '\r'
	while read -r line
	do
		if [[ $line == *"ERROR"* ]]; then
			echo -e "\033[0;31m$line\r"
		elif [[ $line == *"BUILD SUCCESS"* ]]; then
			echo -e "\033[0;32m$line\n"
		elif [[ $line == *"Total time"* ]]; then
			echo -e "\033[0m$line\r"
		elif [[ $line == *"Finished at"* ]]; then
			echo -e "\033[0m$line\n"
		else
			overwrite_line "$line"
		fi
	done < <(mvn -f $PWD/pom.xml clean install)
	echo -e "[[ finshed work! ]]"
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
content="project
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
	echo "need a pom.xml to run maven..."
fi
