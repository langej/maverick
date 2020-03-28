module filehandler;

import std.stdio;
import std.file;
import std.string;
import std.algorithm.searching;

/**
    Tries to read the file and returns the content as string
*/
string getFileContent(string fileName)
{
    if (exists(fileName))
    {
        string content;
        File file = File(fileName, "r");
        while (!file.eof)
        {
            string line = file.readln();
            line = line.replace("\t", "  ");
            content ~= line;
        }
        return content;
    }
    else
    {
        writeln("File not found..");
        return "";
    }
}

unittest
{
    const string result = "project
    modelVersion 4.0

    groupId com.example
    artifactId Example
    version 0.0.1-SNAPSHOT

    dependencies
        dependency com.example:Test:0.0.1-SNAPSHOT";
    assert(getFileContent("examples/pom.pug") == result);
}

void writeContentToFile(string fileName, string content)
{
    // TODO
}

unittest
{
    // TODO
}
