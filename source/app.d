import std.stdio;
import std.string;

import filehandler;
import parser;
import mavenhandler;

void main(string[] args)
{
	if (args.length == 1)
	{
		writeln("no arguments..");
	}
	else if (args.length == 2)
	{
		writeln("one argument..");
		switch (args[0])
		{
		case "help":
			writeln(help);
			break;
		default:
			writeln(help);
			break;
		}
	}
	else
	{
		string fileName = args[1];
		string content = getFileContent(fileName);
		writeln(content);
		writeln(join(createXml(content).pretty(4), "\n"));
	}
}
/**
 * help text for usage of the app
 */
const string help = "
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
