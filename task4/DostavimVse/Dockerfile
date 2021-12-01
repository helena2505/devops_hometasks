FROM adoptopenjdk/openjdk8

COPY . /src

WORKDIR /src

RUN ./mvnw package -DskipTests -P init-base

CMD java -jar target/dostavimvse-0.0.1-SNAPSHOT.jar && ./mvnw package -DskipTests -P web-app && java -jar target/dostavimvse-0.0.1-SNAPSHOT.jar

