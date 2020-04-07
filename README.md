# maverick

A litte helper tool that tries to make working with maven cozy and refreshing

enables you to write your pom.xml with less verbose syntax than xml. It's inspired by [pug](https://pugjs.org/api/getting-started.html) but with less features.

So that this:

```
modelVersion 4.0.0

groupId com.example
artifactId Example
version 0.0.1-SNAPSHOT
```

becomes this:

```
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>Example</artifactId>
    <version>0.0.1-SNAPSHOT</version>
</project>
```

## Usage

Put the executable `maverick` into a directory which is on your PATH.
Then run `maverick init` to generate an initial pom.mav file which looks like this:

```
modelVersion 4.0.0

groupId com.example
artifactId Example
version 0.0.1-SNAPSHOT

dependencies
    com.example Test 0.0.1-SNAPSHOT
```

Then just run `maverick` which compiles the pom.mav file into the pom.xml and runs `mvn clean install` afterwards
If you want to pass other arguments to maven then you can maverick like `maverick <options> -- <mavenargs>`. Everything after "--" will be passed to maven.

## dependencies

As you can see above you can write the dependencies just seperated with a space (or alternatively with a colon).
The syntax is like:

```
dependencies
    # seperated by space
    <groupId> <artifactId> <verion> <type|scope> <type|scope>
    # seperated by colon
    <groupId>:<artifactId>:<verion>:<type|scope>:<type|scope>
    # old fashioned
    dependency
        groupId <groupId>
        artifactId <artifactId>
        version <version>
        type <type>
        scope <scope>
        # exclusions are not supported yet in the other forms [WIP]
        # if you need exclusions use this form
        exclusions
            exclusion
                groupId <groupId>
                artifactId <artifactId>
```
