module outputhandler;

import std.stdio;
import std.format;

void overwriteLine(string text) {
    writeln(UP_LEFT, text);
}

string moveCursorUpleft() pure {
    return UP_LEFT;
}

string red(string text) pure {
    return format("%s%s%s", RED, text, DEFAULT);
}

string green(string text) pure {
    return format("%s%s%s", GREEN, text, DEFAULT);
}

string yellow(string text) pure {
    return format("%s%s%s", YELLOW, text, DEFAULT);
}

private const RED = "\033[0;31m";
private const GREEN = "\033[0;32m";
private const YELLOW = "\033[0;33m";
private const DEFAULT = "\033[0m";
private const UP_LEFT = "\r\033[1A\033[0K";
