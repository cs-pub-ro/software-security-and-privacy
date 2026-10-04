FROM mariadb:11

ARG FLAG="SSP{placeholder}"

# The real flag is a UNIX file on the database server; the injection must use
# LOAD_FILE to read it. World-readable so the mysqld user can read it.
RUN printf '%s\n' "${FLAG}" > /flag && chmod 644 /flag

# Creates the products database and table on first start.
COPY ./app/schema.sql /docker-entrypoint-initdb.d/10-schema.sql
