# maverick
A litte helper tool that tries to make working with maven cozy and refreshing

enables you to write your pom.xml with [pug](https://pugjs.org/api/getting-started.html)

so this:
```
project
	modelVersion 4.0.0
	groupId com.example
	artifactId test
	version 0.0.1-SNAPSHOT

	dependencies
		+dependency("com.test", "foo", "1.37")
```
becomes this:
```
<?xml version="1.0" encoding="utf-8" ?>
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>test</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <dependencies>
    <dependency>
      <groupId>com.test</groupId>
      <artifactId>foo</artifactId>
      <version>1.37</version>
    </dependency>
  </dependencies>
</project>
```

## Usage

Put the script into a directory which is on your PATH.
Then run `maverick.sh init` to generate an initial pom.pug file which looks like this:
```
project
        modelVersion 4.0.0
        groupId com.example
        artifactId test
        version 0.0.1-SNAPSHOT
```

Then just run `maverick.sh` which compiles the pom.pug file into the pom.xml and runs `mvn clean install` afterwards
