# Serves the 04-webshop challenge (SQL injection + LOAD_FILE) over HTTP.
# build: docker build -f deploy/Dockerfile -t 04-webshop-deploy ..
# run:   docker run -d -p <host-port>:80 --name 04-webshop-container 04-webshop-deploy
FROM debian:12
SHELL ["/bin/bash", "-c"]

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        apache2 php libapache2-mod-php php-mysql mariadb-server \
 && rm -rf /var/lib/apt/lists/*

# Inject flag and DB password at build time.
ARG FLAG_PATHS="/flag"
ARG FLAG_VALUES="SSP{placeholder}"
ARG DB_PASSWORD="CTF_DB_PASSWORD"

# The real flag lives at /flag; LOAD_FILE('/flag') via SQL injection reads it.
# World-readable so the MariaDB process (running as mysql) can read it too.
RUN set -e; \
    IFS='|' read -ra _p <<< "${FLAG_PATHS}"; \
    IFS='|' read -ra _v <<< "${FLAG_VALUES}"; \
    for _i in "${!_p[@]}"; do \
        mkdir -p "$(dirname "${_p[$_i]}")"; \
        printf '%s\n' "${_v[$_i]}" > "${_p[$_i]}"; \
        chmod 644 "${_p[$_i]}"; \
    done

# Only the PHP pages go in the web root; the SQL files (one holds the DB root
# password) live outside it, readable by root only.
RUN rm -f /var/www/html/index.html
COPY deploy/app/ /var/www/html/
RUN rm -f /var/www/html/schema.sql
COPY deploy/init.sql /usr/local/share/ctf/init.sql
COPY deploy/mariadb.cnf /etc/mysql/conf.d/webshop.cnf
COPY deploy/start.sh /usr/local/bin/start.sh

# The web-root flag is a decoy: the real one is /flag, reached via LOAD_FILE.
RUN printf 'SSP{decoy_the_real_flag_is_in_/flag_on_the_db_via_LOAD_FILE}\n' \
        > /var/www/html/flag

RUN sed -i "s|CTF_DB_PASSWORD|${DB_PASSWORD}|g" /usr/local/share/ctf/init.sql \
 && sed -i "s|CTF_DB_PASSWORD|${DB_PASSWORD}|g" /usr/local/bin/start.sh \
 && sed -i "s|CTF_DB_PASSWORD|${DB_PASSWORD}|g" /var/www/html/index.php \
 && chmod 600 /usr/local/share/ctf/init.sql \
 && chmod +x /usr/local/bin/start.sh

EXPOSE 80
CMD ["/usr/local/bin/start.sh"]
