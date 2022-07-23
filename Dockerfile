FROM flink:1.14.5
RUN wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-elasticsearch7_2.12/1.14.5/flink-sql-connector-elasticsearch7_2.12-1.14.5.jar -O /opt/flink/lib/flink-sql-connector-elasticsearch7_2.12-1.14.5.jar \
  && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-oracle-cdc/2.2.1/flink-sql-connector-oracle-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-oracle-cdc-2.2.1.jar \
  && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mysql-cdc/2.2.1/flink-sql-connector-mysql-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-mysql-cdc-2.2.1.jar \
  && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-postgres-cdc/2.2.1/flink-sql-connector-postgres-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-postgres-cdc-2.2.1.jar \
  && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mongodb-cdc/2.2.1/flink-sql-connector-mongodb-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-mongodb-cdc-2.2.1.jar \
  && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-sqlserver-cdc/2.2.1/flink-sql-connector-sqlserver-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-sqlserver-cdc-2.2.1.jar

