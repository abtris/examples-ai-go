FROM postgres:18@sha256:b9f6b8ff03b62f3cfd9d9ba3fe56226a9991c79d3fb46fd46536263bf02be553

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extension.sql /docker-entrypoint-initdb.d