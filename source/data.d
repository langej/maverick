module data;

/// status of the program, which shall be displayed in the bottom line
string status = "";

/// help text for usage of the app
const string helpText = "Usage: maverick [options] -- [maven arguments]

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

/// Content for inital pom
const string initContent = "modelVersion 4.0.0

groupId com.example
artifactId Example
version 0.0.1-SNAPSHOT

dependencies
    com.example Test 0.0.1-SNAPSHOT
";
