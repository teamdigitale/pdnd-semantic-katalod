# BUILD_IMAGE
FROM maven:3.6-jdk-8-slim as BUILD_IMAGE

ENV VERS=0.0.11
ENV KATALOD_CODE /mvn_src

RUN mkdir -p $KATALOD_CODE

COPY pom.xml $KATALOD_CODE/pom.xml
COPY src/ $KATALOD_CODE/src/
COPY lib/ $KATALOD_CODE/lib/

RUN mvn -f ${KATALOD_CODE}/pom.xml install -Dmaven.test.skip=true

# APP
FROM openjdk:8-jre-alpine

RUN apk add dos2unix

ENV KATALOD_HOME /usr/share/katalod
ENV KATALOD_CODE /mvn_src
ENV VERS=0.0.11

RUN mkdir -p $KATALOD_HOME

WORKDIR $KATALOD_HOME

COPY conf/ conf/
COPY src/main/swagger-ui src/main/swagger-ui
COPY --from=BUILD_IMAGE ${KATALOD_CODE}/target/libs /usr/share/katalod/lib
COPY --from=BUILD_IMAGE ${KATALOD_CODE}/target/kataLOD-${VERS}.jar /usr/share/katalod/kataLOD-${VERS}.jar

RUN find . -type f -print0 | xargs -0 dos2unix

COPY ontologie-vocabolari-controllati/ ontologie-vocabolari-controllati/

EXPOSE 7777

ENTRYPOINT ["/usr/bin/java", "-cp", "/usr/share/katalod/lib/*:/usr/share/katalod/kataLOD-${VERS}.jar", "it.almawave.kb.http.MainHTTP"]
