import std.stdio;
import std.string;
import std.process;
import std.algorithm.searching;
import core.stdc.stdlib;

import filehandler;
import parser;
import mavenhandler;
import outputhandler;
import data;

void main(string[] args) {
	auto splitted = args.split("--");

	parseArgs(splitted[0]);
	string[] mavenArgs = null;
	if (splitted.length > 1) {
		mavenArgs = splitted[1];
	}
	status = "[1/2] compile to pom.xml ..";
	string pomContent = getFileContent("pom.mav");
	writeContentToFile("pom.xml", join(parsePomAndCreateXml(pomContent).pretty(4), "\n"));
	status = format("%s%s%s%s", PREVIOUS, ERASE_LINE,
			green(" [1/2] compile to pom.xml ➜  ✓ done 🞂"), " [2/2] run maven ..");
	runMaven(mavenArgs);
	status = format("%s%s%s%s", PREVIOUS, ERASE_LINE,
			green("[1/2] compile to pom.xml ➜  ✓ done 🞂"),
			green(" [2/2] run maven ➜  ✓ done "));
	writeln("\n", status);
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
