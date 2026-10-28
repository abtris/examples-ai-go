FROM postgres:18@sha256:979bccfde35445db618c65107d27d08c6c21339d8dc3ad4c830c6633947be0e4

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extension.sql /docker-entrypoint-initdb.d