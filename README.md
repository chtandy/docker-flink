### 簡介
- [Flink docker-compose 单机版 安装教程](https://blog.csdn.net/u010020726/article/details/125554717)   
- [如何使用 docker-compose 来启动和测试服务](https://blog.csdn.net/surfirst/article/details/120940848)  
- [flink sample](https://github.com/docker-flink/examples/blob/master/docker-compose.yml)    
- [官方docker教學](https://nightlies.apache.org/flink/flink-docs-release-1.10/zh/ops/deployment/docker.html)   
- [SQL Client](https://nightlies.apache.org/flink/flink-docs-release-1.13/docs/dev/table/sqlclient/)   


- 運行方式
1. Flink Session Cluster
2. Flink Job Cluster
3. Flink Application Cluster

- 集群方式
1. standalone
2. kubernetes
  - [Kubernetes 安装](https://nightlies.apache.org/flink/flink-docs-master/zh/docs/deployment/resource-providers/standalone/kubernetes/)   
3. YARN


### 架構說明
- [Overview and Reference Architecture](https://nightlies.apache.org/flink/flink-docs-master/zh/docs/deployment/overview/)  


### flink-cd-connectors
- [flink-cd-connectors](https://github.com/ververica/flink-cdc-connectors)   
- [cdc jar](https://repo1.maven.org/maven2/com/ververica/)   
- [flink](https://repo.maven.apache.org/maven2/org/apache/flink/)   


### 此專案的運行方式是使用最簡易的 Session Cluster 模式

### docker 環境變數
- 目前遇過的方式 
```
    environment:
      - JOB_MANAGER_RPC_ADDRESS=jobmanager
```
or 
```
    environment:
      - |
        FLINK_PROPERTIES=
        jobmanager.rpc.address: jobmanager
```
### 配置設定方式
- 配置檔案路徑為`opt/flink/conf/flink-conf.yaml`
```
jobmanager.rpc.address: jobmanager
jobmanager.rpc.port: 6123
jobmanager.memory.process.size: 4096m
taskmanager.memory.process.size: 16384m
taskmanager.numberOfTaskSlots: 10
parallelism.default: 1
jobmanager.execution.failover-strategy: region
blob.server.port: 6124
query.server.port: 6125
```

### 新增cdc jar
- 將檔案放置`/opt/flink/lib`下

### 官方範例說明
- [Streaming ETL for MySQL and Postgres with Flink CDC]()https://ververica.github.io/flink-cdc-connectors/master/content/quickstart/mysql-postgres-tutorial.html   
- [Oracle CDC to Elasticsearch](https://ververica.github.io/flink-cdc-connectors/master/content/quickstart/oracle-tutorial.html)   

### 注意事項
- 版本要互相匹配, 不然會失敗
  - [Supported Connectors](https://ververica.github.io/flink-cdc-connectors/master/content/about.html#supported-flink-versions)         








