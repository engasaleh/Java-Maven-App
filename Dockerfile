# Use a multi-stage build to reduce image size
# Stage 1: Build the application
FROM maven:3.8.5-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Create the runtime image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/JavaMavenApp-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]

