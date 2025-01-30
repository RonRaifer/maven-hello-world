# Base image
FROM eclipse-temurin:17-jdk as builder

WORKDIR /app
RUN apt-get update && apt-get install -y maven
COPY myapp/pom.xml .
COPY myapp/src ./src
RUN mvn clean test package -DskipTests

FROM eclipse-temurin:17-jdk as deploy
WORKDIR /app
RUN useradd -m appuser
ARG JAR_FILE=myapp/target/*.jar
COPY --from=builder ${JAR_FILE} app.jar
RUN chown appuser:appuser app.jar
USER appuser
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
