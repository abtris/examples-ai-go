FROM postgres:18@sha256:c699303802144847d238196173655dbbecf7a96aeca1565f2b02eb671a1f0b6b

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-pgvector && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
ADD create_extension.sql /docker-entrypoint-initdb.d