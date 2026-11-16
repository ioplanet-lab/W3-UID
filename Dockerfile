FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY raw ./raw
RUN mvn -B -DskipTests package

FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=build /app/target/w3uido-1.0-SNAPSHOT.jar ./app.jar
EXPOSE 80
CMD ["java", "-jar", "app.jar"]