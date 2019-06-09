FROM robert2411/base-image:1.0.0 AS builder

WORKDIR /project
COPY ./pom.xml /project/pom.xml
RUN mvn dependency:resolve
COPY . /project
RUN mvn clean package


FROM gcr.io/distroless/java:11 AS eureka-server
COPY --from=builder /project/target/eureka-server.jar /app/eureka-server.jar
WORKDIR /app
CMD ["eureka-server.jar"]