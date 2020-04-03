import std.stdio;
import std.string;
import std.process;
import std.algorithm.searching;
import core.stdc.stdlib;

import filehandler;
import parser;
import mavenhandler;
import outputhandler;

void main(string[] args) {
	auto splitted = args.split("--");

	parseArgs(splitted[0]);
	string[] mavenArgs = null;
	if (splitted.length > 1) {
		mavenArgs = splitted[1];
	}
	writeln("[1/2] compile to pom.xml ..");
	string pomContent = getFileContent("pom.mav");
	writeContentToFile("pom.xml", join(createXml(pomContent).pretty(4), "\n"));
	writeln(moveCursorUpleft(), green("[1/1] compile to pom.xml > ✓ done"),
			" > [2/2] run maven ..\n");
	runMaven(mavenArgs);
}

private void parseArgs(string[] args) {
	const bool helpWanted = canFind(args, "help") || canFind(args, "-h") || canFind(args, "--help");
	if (helpWanted) {
		writeln(helpText);
		exit(EXIT_SUCCESS);
	}
	const bool initWanted = canFind(args, "init") || canFind(args, "-i") || canFind(args, "--init");
	if (initWanted) {
		writeContentToFile("pom.mav", initContent);
		exit(EXIT_SUCCESS);
	}

}

/**
 * help text for usage of the app
 */
const string helpText = "
Usage: maverick [options] -- [maven arguments]

options:
	help, -h, --help	=> display this help page
	init, -i, --init	=> create initial pom file

maven arguments:
	as default `clean install` is used but
	you can use everything you would use with maven. 
	The whole string will be directed to maven

	for example:
		`maverick -- clean package -DskipTests`
";

/**
 * Content for inital pom
 */
const string initContent = "
modelVersion 4.0

groupId com.example
artifactId Example
version 0.0.1-SNAPSHOT

dependencies
    com.example Test 0.0.1-SNAPSHOT
";
