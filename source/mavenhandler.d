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

    foreach (line; pipes.stdout.byLine) {
        readLine(format("%s", line));
    }

    // Store lines of errors.
    string[] errors;
    foreach (line; pipes.stderr.byLine)
        errors ~= line.idup;
}

private void readLine(string line) {
    const ERROR = "[ERROR]";
    const WARNING = "[WARNING]";
    const SUCCESS = "SUCCESS";
    const INFO = "[INFO]";
    const splitted = line.split(" ");
    if (splitted.length > 1 && !canFind(line, dashedLine)) {
        if (canFind(line, ERROR)) {
            writeln(ERASE_LINE, format("%s", line.replace(ERROR, red("✗"))));
        } else if (canFind(line, WARNING)) {
            writeln(ERASE_LINE, format("%s", line.replace(WARNING, yellow("⚠"))));
        } else {
            line = line.replace(INFO, "");
            if (canFind(line, SUCCESS)) {
                writeln(ERASE_LINE, format("%s", line.replace(SUCCESS, green(SUCCESS))));
            } else if (canFind(line, "Total time")) {
                writeln(ERASE_LINE, line.replace(INFO, ""));
            } else if (canFind(line, "Finished at")) {
                writeln(ERASE_LINE, line.replace(INFO, ""));
            } else {
                if (line.length > 100)
                    line = format("%s ...", line[0 .. 96]);
                writeln(ERASE_LINE, line, PREVIOUS);
            }
        }
    }
}

private const dashedLine = "---------------------------------------------------------------------";
