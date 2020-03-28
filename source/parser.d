module parser;

import std.string;
import std.array;
import std.xml;
import std.ascii;
import std.algorithm.searching;
import std.algorithm;
import std.container;

import std.stdio;

Document createXml(string content)
{
    auto pom = new Document(new Tag("project"));
    string[] lines = content.lineSplitter().array;

    auto parents = Array!ParseElement();
    parents.insertBack(ParseElement(0, pom));

    foreach (idx, line; lines)
    {
        auto level = getIndentationLevel(line);
        auto items = strip(line).split(" ");
        if (items.length > 0)
        {
            auto element = new Element(items[0]);
            if (items.length > 1)
            {
                element ~= new Text(items[1]);
                element.tag.attr["level"] = format("%d", level);
            }
            pom ~= element;
        }
    }
    return pom;
}

auto getIndentationLevel(string line)
{
    return countUntil!(isAlpha)(line);
}

private struct ParseElement
{
    int indentationLevel;
    Element element;
}
