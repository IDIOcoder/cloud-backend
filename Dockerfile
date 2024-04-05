FROM openjdk:17-jdk-slim-buster AS builder
COPY ./blog/gradlew .
COPY ./blog/gradle gradle
COPY ./blog/build.gradle .  
COPY ./blog/settings.gradle .
COPY ./blog/src src

RUN chmod +x ./gradlew
RUN ./gradlew bootJar

FROM openjdk:17-jdk-slim-buster
COPY --from=builder build/libs/*.jar app.jar

EXPOSE 9090
ENTRYPOINT ["java","-jar","/app.jar"]