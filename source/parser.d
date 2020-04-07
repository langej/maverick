module parser;

import std.string;
import std.array;
import std.xml;
import std.ascii;
import std.algorithm.searching;
import std.algorithm;
import std.container;

import std.stdio;

/**
    author: langej

    parses the content and creates a xml document of it.
 
    params:
        content = the content of the pom.mav file

    returns:
        xml document from package std.xml
 */
Document parsePomAndCreateXml(string content) {
    auto doc = new Document(new Tag("project"));
    string[] lines = content.lineSplitter().array;

    ParseElement last;

    foreach (idx, line; lines) {
        auto level = getIndentationLevel(line);
        auto items = strip(line).split(" ");
        if (items.length > 0) {
            if (items[0] == "#") {
                continue;
            }
            auto element = new Element(items[0]);
            if (items.length > 1) {
                element ~= new Text(items[1]);
            }
            if (level == 0 || is(last)) {
                doc ~= element;
                last = new ParseElement(level, element, null);
            } else {
                if (level > last.level) {
                    if (last.element.tag.name == "dependencies" && element.tag.name != "dependency") {
                        element = parseDependency(line);
                    }
                    last.element ~= element;
                    last = new ParseElement(level, element, last);
                } else if (level == last.level) {
                    if (last.parent.element.tag.name == "dependencies"
                            && element.tag.name != "dependency") {
                        element = parseDependency(line);
                    }
                    last.parent.element ~= element;
                    last = new ParseElement(level, element, last.parent);
                } else if (level < last.level) {
                    while (level < last.level) {
                        last = last.parent;
                    }
                    last.parent.element ~= element;
                    last = new ParseElement(level, element, last.parent);
                }
            }
        }
    }
    return doc;
}

private Element parseDependency(string line) {
    line = strip(line);
    Element dependency = new Element("dependency");
    string[] splitted;
    if (line.split(":").length >= 3) {
        splitted = line.split(":");
    } else if (line.split(" ").length >= 3) {
        splitted = line.split(" ");
    } else {
        throw new Exception("cant parse dependency");
    }
    dependency ~= new Element("groupId", splitted[0]);
    dependency ~= new Element("artifactId", splitted[1]);
    dependency ~= new Element("version", splitted[2]);
    if (splitted.length > 3) {
        if (isScope(splitted[3]))
            dependency ~= new Element("scope", splitted[3]);
        else
            dependency ~= new Element("type", splitted[3]);
    }
    if (splitted.length > 4) {
        if (isScope(splitted[4]))
            dependency ~= new Element("scope", splitted[4]);
        else
            dependency ~= new Element("type", splitted[4]);
    }
    // TODO add exclusions
    return dependency;
}

private bool isScope(string el) {
    auto scopes = ["compile", "provided", "runtime", "test", "system", "import"];
    return canFind(scopes, el);
}

private auto getIndentationLevel(string line) {
    return countUntil!(isAlpha)(line);
}

private class ParseElement {
    long level;
    Element element;
    ParseElement parent;

    this(long level, Element element, ParseElement parent) {
        this.level = level;
        this.element = element;
        this.parent = parent;
    }
}

unittest {
    string expected = "<project>
    <modelVersion>4.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>Example</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <properties>
        <java.compile.target>1.8</java.compile.target>
    </properties>
    <dependencies>
        <dependency>
            <groupId>com.example</groupId>
            <artifactId>Test</artifactId>
            <version>0.0.1-SNAPSHOT</version>
        </dependency>
    </dependencies>
</project>";
    string input = "modelVersion 4.0

groupId com.example
artifactId Example
version 0.0.1-SNAPSHOT

properties
    java.compile.target 1.8

dependencies
    com.example:Test:0.0.1-SNAPSHOT";

    assert(equal(join(parsePomAndCreateXml(input).pretty(4), "\n"), expected));
}
