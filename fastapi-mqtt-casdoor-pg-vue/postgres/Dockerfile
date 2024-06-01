FROM postgres:alpine as base

FROM base as dev

COPY --chown=postgres:postgres ./sql_dump/dump.sql /tmp

FROM base as test

#COPY ./your_db_dump.sql /docker-entrypoint-initdb.d/

FROM base as prod

#COPY ./your_db_dump.sql /docker-entrypoint-initdb.d/
