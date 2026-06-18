# Stage 1: Build the application
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src src
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre
WORKDIR /deployments
COPY --from=build /workspace/target/quarkus-app/lib/ /deployments/lib/
COPY --from=build /workspace/target/quarkus-app/*.jar /deployments/
COPY --from=build /workspace/target/quarkus-app/app/ /deployments/app/
COPY --from=build /workspace/target/quarkus-app/quarkus/ /deployments/quarkus/
EXPOSE 8080
ENV JAVA_OPTS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /deployments/quarkus-run.jar" ]
