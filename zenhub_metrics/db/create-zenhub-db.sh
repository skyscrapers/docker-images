#!/usr/bin/env bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE zenhub_user WITH unencrypted password 'zenhub_db_pwd' LOGIN;
    CREATE DATABASE zenhub_charts WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
    GRANT ALL PRIVILEGES ON DATABASE zenhub_charts TO zenhub_user;
EOSQL
