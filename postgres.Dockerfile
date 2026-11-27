FROM postgres:19@sha256:4ea94de574c17f0372722806c949757050fbb1cd7648410fe45d6bba275cc00e

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extension.sql /docker-entrypoint-initdb.d