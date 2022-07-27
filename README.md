### 簡介
- [Flink docker-compose 单机版 安装教程](https://blog.csdn.net/u010020726/article/details/125554717)   
- [如何使用 docker-compose 来启动和测试服务](https://blog.csdn.net/surfirst/article/details/120940848)  
- [flink sample](https://github.com/docker-flink/examples/blob/master/docker-compose.yml)    
- [官方docker教學](https://nightlies.apache.org/flink/flink-docs-release-1.10/zh/ops/deployment/docker.html)   
- [SQL Client](https://nightlies.apache.org/flink/flink-docs-release-1.13/docs/dev/table/sqlclient/)   


### [架構差異](https://www.modb.pro/db/128796)  

- Session Mode

  該模式使用一個已經運行的集群來執行所有提交的應用程序。該集群中執行的應用程序競爭使用該集群的資源。這樣做的好處是，不必為每個提交的作業啟動一個集群，額外增加資源開銷。但是，該模式下，如果集群中的一個作業行為不正常或導致TaskManager宕機，則在該TaskManager上運行的所有作業都將受到故障的影響。也就是說，一個作業也會影響其他作業可能導致大規模的重啟。所有重新啟動的作業都會同時訪問文件系統，可能導致其他服務無法使用該文件系統。此外，讓單個集群運行多個作業意味著JobManager的負載更大。該模式適合於對啟動延遲要求較高且運行時間較短的作業，例如交互式查詢。
- Application Mode  
  Application 模式下，用戶程序的main 方法將在集群中而不是客戶端運行，用戶將程序邏輯和依賴打包進一個可執行的jar 包裡，集群的入口程序(ApplicationClusterEntryPoint) 負責調用其中的main 方法來生成JobGraph。Application 模式為每個提交的應用程序創建一個集群，該集群可以看作是在特定應用程序的作業之間共享的會話集群，並在應用程序完成時終止。在這種體系結構中，Application 模式在不同應用之間提供了資源隔離和負載平衡保證。在特定一個應用程序上，JobManager 執行main() 可以節省所需的CPU 週期，還可以節省本地下載依賴項所需的帶寬。
- Per-Job Mode
  - 不支援 kubernetes



### 架構說明
- [Overview and Reference Architecture](https://nightlies.apache.org/flink/flink-docs-master/zh/docs/deployment/overview/)  


### flink-cd-connectors
- [flink-cdc-connectors](https://github.com/ververica/flink-cdc-connectors)   
- [cdc jar](https://repo1.maven.org/maven2/com/ververica/)   
- [flink](https://repo.maven.apache.org/maven2/org/apache/flink/)   


### 此專案的運行方式是使用最簡易的 Session Cluster 模式


---
# flink CDC
### flink CDC 特性
This project provides a set of source connectors for Apache Flink® directly ingesting changes coming from different databases using Change Data Capture(CDC).
中文：該項目提供了一組apacheflink®直接攝入更改的源連接器

### 使用方式
- [CDC Connectors for Apache Flink 官方說明](https://ververica.github.io/flink-cdc-connectors/)   
- 使用方式  
  - [SQL API, Flink SQL Client](https://ververica.github.io/flink-cdc-connectors/master/content/about.html#usage-for-table-sql-api)  
  - [DataStream API](https://ververica.github.io/flink-cdc-connectors/master/content/about.html#usage-for-datastream-api)  
- 此範例Session Mode
- 已包含slasticsearch, kibana, oracle
- clone 下來之後，先執行`docker-compose build`, 接著執行`docker-compose up -d`
- 此案例啟用CDC方式是Flink SQL Client
  - 進入jobmanager Container
  - 執行/opt/flink/bin/sql-client.sh

### 新增cdc connection jar
- 將檔案放置`/opt/flink/lib`下

### 官方範例說明
- [Streaming ETL for MySQL and Postgres with Flink CDC](https://ververica.github.io/flink-cdc-connectors/master/content/quickstart/mysql-postgres-tutorial.html)   
- [Oracle CDC to Elasticsearch](https://ververica.github.io/flink-cdc-connectors/master/content/quickstart/oracle-tutorial.html)   


### Flink CDC History
- 需單獨額外執行
- 修改或是增加參數
  可在/opt/flink/conf/flink-conf.yaml 看到官方範例檔案
  ```
  jobmanager.archive.fs.dir: file:///opt/flink/completed-jobs/
  historyserver.archive.fs.dir: file:///opt/flink/completed-jobs/
  historyserver.archive.fs.refresh-interval: 10000
  ```

- 執行方式
  - 進入jobmanager Container
  - /opt/flink/bin/historyserver.sh {start|stop|restart}
- 瀏覽{flink IP}:8082
- History docker-compose 的範例
```
version: "3"
services:
  jobmanager:
    image: flink-cdc
    build:
      context: ./
    expose:
      - "6123"
    ports:
      - "8081:8081"
      - "8082:8082"
    command: jobmanager
    volumes:
      - ./completed-jobs:/opt/flink/completed-jobs
    environment:
      #- JOB_MANAGER_RPC_ADDRESS=jobmanager
      - TZ=Asia/Taipei
      - |
        FLINK_PROPERTIES=
        jobmanager.rpc.address: jobmanager
        jobmanager.archive.fs.dir: file:///opt/flink/completed-jobs/
        historyserver.archive.fs.dir: file:///opt/flink/completed-jobs/
        historyserver.archive.fs.refresh-interval: 10000

  taskmanager:
    image: flink-cdc
    build:
      context: ./
    expose:
      - "6121"
      - "6122"
    depends_on:
      - jobmanager
    command: taskmanager
    links:
      - "jobmanager:jobmanager"
    environment:
      - TZ=Asia/Taipei
      - |
        FLINK_PROPERTIES=
        jobmanager.rpc.address: jobmanager
        taskmanager.numberOfTaskSlots: 3
```

### 注意事項
- 版本要互相匹配, 不然會失敗
  - [Supported Connectors](https://ververica.github.io/flink-cdc-connectors/master/content/about.html#supported-flink-versions)         











