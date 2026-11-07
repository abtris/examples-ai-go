FROM postgres:18@sha256:e3d24f6906d0760bf4da0dae872415391ededefad23fd471c47dc53b0ddf3c42

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extension.sql /docker-entrypoint-initdb.d