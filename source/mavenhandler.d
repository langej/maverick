module mavenhandler;

import std.format;
import std.process;
import std.stdio;
import std.array;
import std.string;
import std.algorithm.searching;

import outputhandler;

/**
 * the mavenhandler should start maven and reduce the output to the a useful minimum
 */

void runMaven(string[] args) {
    if (args.length == 0) {
        args = ["clean", "package"];
    }
    args.insertInPlace(0, "mvn");
    auto pipes = pipeProcess(args, Redirect.stdout | Redirect.stderr);
    scope (exit)
        wait(pipes.pid);

    // Store lines of output.
    string[] output;
    foreach (line; pipes.stdout.byLine) {
        writeln(readLine(format("%s", line)));
    }
    // output ~= line.idup;

    // Store lines of errors.
    string[] errors;
    foreach (line; pipes.stderr.byLine)
        writeln("err - ", line); // errors ~= line.idup;
}

string readLine(string line) {
    const ERROR = "[ERROR]";
    const WARNING = "[WARNING]";
    const SUCCESS = "SUCCESS";
    const INFO = "[INFO]";
    string result = "";
    if (line.length > 80)
        line = format("%s...", line[0 .. 75]);
    if (canFind(line, ERROR)) {
        result = format("%s\n", line.replace(ERROR, red("✗")));
    } else if (canFind(line, WARNING)) {
        result = format("%s\n", line.replace(WARNING, yellow("⚠")));
    } else {
        line = line.replace(INFO, "");
        if (canFind(line, SUCCESS)) {
            result = format("%s\n", line.replace(SUCCESS, green(SUCCESS)));
        } else {
            result = format("%s%s", moveCursorUpleft(), line);
        }
    }
    return result;
}
