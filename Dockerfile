FROM maven:3.9.0-eclipse-temurin-17 AS build
WORKDIR /app
# Copy all project files and build with Maven
COPY . . 
RUN mvn clean install 

FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app
COPY --from=build /app/target/spring-boot-jenkins-1.0.0.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT [ "java","-jar", "/app/app.jar" ]