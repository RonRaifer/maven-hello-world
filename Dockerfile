# ------------ [STAGE 1] BUILD ------------ #
FROM eclipse-temurin:17-jdk AS argset

# Set the build argument for the JAR file
ARG JAR_FILE=myapp/target/*.jar

# ------------ [STAGE 2] RUN ------------ #
FROM eclipse-temurin:17-jre

# Copy the application JAR from STAGE 1 into the image
COPY --from=argset ${JAR_FILE} app.jar

# Set permissions and switch to non-root user
USER 1000

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
