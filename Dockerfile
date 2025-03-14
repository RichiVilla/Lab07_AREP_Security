FROM eclipse-temurin:22-jdk
WORKDIR /app
COPY target/Security-1.0-SNAPSHOT.jar app.jar
COPY src/main/resources/keystore.p12 /app/keystore.p12
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
