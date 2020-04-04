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
    string[] readline;
    foreach (line; pipes.stdout.byLine) {
        readLine(format("%s", line));
    }
    // output ~= line.idup;

    // Store lines of errors.
    string[] errors;
    foreach (line; pipes.stderr.byLine)
        writeln("err - ", line); // errors ~= line.idup;
}

private void readLine(string line) {
    const ERROR = "[ERROR]";
    const WARNING = "[WARNING]";
    const SUCCESS = "SUCCESS";
    const INFO = "[INFO]";
    string result = "";
    if (line.length > 100)
        line = format("%s ...", line[0 .. 96]);
    string[] splitted = line.split(" ");
    if (splitted.length > 1 && !canFind(line,
            "---------------------------------------------------------------------")) {
        if (canFind(line, ERROR)) {
            writeln(PREVIOUS, ERASE_LINE, format("%s", line.replace(ERROR, red("✗"))), "\n");
        } else if (canFind(line, WARNING)) {
            writeln(PREVIOUS, ERASE_LINE, format("%s", line.replace(WARNING,
                    yellow("⚠"))), "\n");
        } else {
            line = line.replace(INFO, "");
            if (canFind(line, SUCCESS)) {
                writeln(PREVIOUS, ERASE_LINE, format("%s",
                        line.replace(SUCCESS, green(SUCCESS))), "\n");
            } else if (canFind(line, "Total time")) {
                writeln(PREVIOUS, ERASE_LINE, line.replace(INFO, ""), "\n");
            } else if (canFind(line, "Finished at")) {
                writeln(PREVIOUS, ERASE_LINE, line.replace(INFO, ""), "\n");
            } else {
                writeln(ERASE_LINE, line, PREVIOUS);
            }
        }
    }
}
