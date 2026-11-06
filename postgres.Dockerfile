FROM postgres:18@sha256:bd5dfa494a5a259704365813dbfa5fa6b3e69be7348d43b547f540c730478583

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extension.sql /docker-entrypoint-initdb.d