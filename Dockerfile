# Base image
FROM eclipse-temurin:17-jdk

# Add non-root user as per req: the  Docker image shouldn't run with root
RUN useradd -m appuser

# Set the build argument for the JAR file
ARG JAR_FILE=myapp/target/*.jar

# Copy the application JAR into the image
COPY ${JAR_FILE} app.jar

# Set permissions and switch to non-root user
RUN chown appuser:appuser app.jar
USER appuser

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
