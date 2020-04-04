module filehandler;

import std.stdio;
import std.file;
import std.string;
import std.algorithm.searching;

import core.stdc.stdlib;

import outputhandler;

/**
    Tries to read the file and returns the content as string
*/
string getFileContent(string fileName) {
    if (exists(fileName)) {
        string content;
        File file = File(fileName, "r");
        while (!file.eof) {
            string line = file.readln();
            line = line.replace("\t", "  ");
            content ~= line;
        }
        return content;
    } else {
        writeln(yellow("File not found.."));
        return "";
    }
}

void writeContentToFile(string fileName, string content) {
    if (fileName == "pom.mav") {
        if (exists(fileName)) {
            writeln(yellow("pom.mav already exists.."));
            exit(EXIT_FAILURE);
        }
    }
    File file = File(fileName, "w");
    file.write(content);
}

unittest {
    const string result = "modelVersion 4.0

groupId com.example
artifactId Example
version 0.0.1-SNAPSHOT

properties
    property
        test
        foo
        baz

dependencies
    com.example:Test:0.0.1-SNAPSHOT
    com.exmaple:Baz:1.0

build
    plugins
        plugin
            id foo
            executions
                execution first
                execution second
        plugin
            id baz
            executions
                execution first";
    assert(getFileContent("examples/pom.mav") == result);
}

unittest {
    // TODO
}
