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

## Output

Also the output gets filtered for only necessary information:

Instead of this:
```
[INFO] Scanning for projects...
[INFO] 
[INFO] ------------------------< com.example:Example >-------------------------
[INFO] Building Example 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ Example ---
[INFO] Deleting [...]/maverick/examples/target
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ Example ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory [...]/maverick/examples/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ Example ---
[INFO] No sources to compile
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ Example ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory [...]/maverick/examples/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ Example ---
[INFO] No sources to compile
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ Example ---
[INFO] No tests to run.
[INFO] 
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ Example ---
[WARNING] JAR will be empty - no content was marked for inclusion!
[INFO] Building jar: [...]/maverick/examples/target/Example-0.0.1-SNAPSHOT.jar
[INFO] 
[INFO] --- maven-install-plugin:2.4:install (default-install) @ Example ---
[INFO] Installing [...]/maverick/examples/target/Example-0.0.1-SNAPSHOT.jar to [...]/.m2/repository/com/example/Example/0.0.1-SNAPSHOT/Example-0.0.1-SNAPSHOT.jar
[INFO] Installing [...]/maverick/examples/pom.xml to [...]/.m2/repository/com/example/Example/0.0.1-SNAPSHOT/Example-0.0.1-SNAPSHOT.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.606 s
[INFO] Finished at: 2020-04-07T09:00:10Z
[INFO] ------------------------------------------------------------------------
```

you only get this:
```
⚠ Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
⚠ Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
⚠ JAR will be empty - no content was marked for inclusion!
 BUILD SUCCESS
 Total time:  6.637 s
 Finished at: 2020-04-07T08:59:50Z
[1/2] compile to pom.xml ➜  ✓ done 🞂 [2/2] run maven ➜  ✓ done 
```
Only warnings, errors and the final build information will be shown
