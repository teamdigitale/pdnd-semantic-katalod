# semantic-katalod for Piattaforma Digitale Nazionale Dati (PDND), previously DAF

This module is designed to offer support for parsing ontologies and vocabularies, eventually exposing the minimum set of metadata to the other components.

[last update: 2018-08-06]

## What is the PDND (previously DAF)?

PDND stays for "Piattaforma Digitale Nazionale Dati" (the Italian Digital Data Platform), previously known as Data & Analytics Framework (DAF).

You can find more informations about the PDND on the official [Digital Transformation Team website](https://teamdigitale.governo.it/it/projects/daf.htm).

## What is semantic-katalod?

This module is designed to offer support for parsing ontologies and vocabularies, eventually exposing the minimum set of metadata to the other components.

For simplicity it is designed re-using jersey and swagger with jetty, using RDF4J as the main interface to RDF.

**NOTE**: the application should be considered an early (alpha) release, as it is still work-in-progress: all the endpoints and functions are still constantly evolving.

[last update: 2018-08-06]

## How to build and test semantic-katalod

### maven build / install

```bash
mvn clean install
```

**CHECK**: in order to use the library as an sbt dependency, we should create a proper naming convention for the artifact, such as: `{artifact}_{scalaVersion}.jar`

### maven test

in order to run the application locally after a maven build, for easy testing, we can:

```bash
mvn clean package

# WIN
java -cp "target/kataLOD-0.0.11.jar;target/libs/*" it.almawave.kb.http.MainHTTP

# linux
java -cp "target/kataLOD-0.0.11.jar:target/libs/*" it.almawave.kb.http.MainHTTP
```

### dockerization

After the maven artifact was built:

```bash
mvn clean package
```

```bash
sudo docker build . -t katalod:0.0.11
```

In order to run a new container from the generated build, we can use the following command:

```bash
sudo docker run -p 7777:7777 katalod:0.0.11
```

**NOTE**: currently the port `7777` is used as the default port

## How to contribute

Contributions are welcome. Feel free to [open issues](./issues) and submit a [pull request](./pulls) at any time, but please read [our handbook](https://github.com/teamdigitale/pdnd-handbook) first.

## License

Copyright (c) 2019 Presidenza del Consiglio dei Ministri

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
