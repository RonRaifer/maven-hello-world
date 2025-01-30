# Base image
FROM eclipse-temurin:17-jdk as develop

WORKDIR /app
COPY /myapp/pom.xml .
COPY /myapp/src ./src
RUN mvn clean test


FROM eclipse-temurin:17-jdk as builder
WORKDIR /app
COPY /myapp/pom.xml .
COPY /myapp/src ./src
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim as deploy
WORKDIR /app
RUN useradd -m appuser
ARG JAR_FILE=myapp/target/*.jar
COPY ${JAR_FILE} app.jar
RUN chown appuser:appuser app.jar
USER appuser
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
