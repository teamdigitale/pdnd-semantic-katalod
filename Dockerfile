# BUILD_IMAGE
FROM maven:3.6-jdk-8-slim as BUILD_IMAGE

ENV VERS=0.0.11
ENV KATALOD_BUILD /mvn_src

RUN mkdir -p $KATALOD_BUILD

COPY pom.xml $KATALOD_BUILD/pom.xml
COPY src/ $KATALOD_BUILD/src/
COPY lib/ $KATALOD_BUILD/lib/

RUN mvn -f ${KATALOD_BUILD}/pom.xml package -Dmaven.test.skip=true

# APP
FROM openjdk:8-jre-alpine

RUN apk add dos2unix

ENV KATALOD_HOME /usr/share/katalod
ENV KATALOD_BUILD /mvn_src
ENV VERS=0.0.11

RUN mkdir -p $KATALOD_HOME

WORKDIR $KATALOD_HOME

COPY conf/ conf/
COPY src/main/swagger-ui src/main/swagger-ui
COPY --from=BUILD_IMAGE ${KATALOD_BUILD}/target/libs ${KATALOD_HOME}/libs
COPY --from=BUILD_IMAGE ${KATALOD_BUILD}/target/kataLOD-${VERS}.jar ${KATALOD_HOME}/kataLOD.jar
COPY ontologie-vocabolari-controllati/ ontologie-vocabolari-controllati/

RUN chmod 755 "${KATALOD_HOME}" -R
RUN find . -type f -print0 | xargs -0 dos2unix > /dev/null

EXPOSE 7777

ENTRYPOINT ["/usr/bin/java", "-cp", "/usr/share/katalod/libs/*:/usr/share/katalod/kataLOD.jar", "it.almawave.kb.http.MainHTTP"]
