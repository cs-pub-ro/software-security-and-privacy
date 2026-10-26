# Serves the 04-webshop challenge (SQL injection + LOAD_FILE) over HTTP.
# build: docker build -f deploy/Dockerfile -t 04-webshop-deploy ..
# run:   docker run -d -p <host-port>:80 --name 04-webshop-container 04-webshop-deploy
FROM debian:12

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        apache2 php libapache2-mod-php php-mysql mariadb-server \
 && rm -rf /var/lib/apt/lists/*

# Inject flag and DB password at build time.
ARG FLAG="SSP{placeholder}"
ARG DB_PASSWORD="CTF_DB_PASSWORD"

# The real flag lives at /flag; LOAD_FILE('/flag') via SQL injection reads it.
# World-readable so the MariaDB process (running as mysql) can read it too.
RUN printf '%s\n' "${FLAG}" > /flag && chmod 644 /flag

COPY deploy/app/ /var/www/html/
COPY deploy/init.sql /var/www/html/init.sql
COPY deploy/mariadb.cnf /etc/mysql/conf.d/webshop.cnf
COPY deploy/start.sh /usr/local/bin/start.sh

RUN sed -i "s|CTF_DB_PASSWORD|${DB_PASSWORD}|g" /var/www/html/init.sql \
 && sed -i "s|CTF_DB_PASSWORD|${DB_PASSWORD}|g" /usr/local/bin/start.sh \
 && sed -i "s|CTF_DB_PASSWORD|${DB_PASSWORD}|g" /var/www/html/index.php \
 && chmod +x /usr/local/bin/start.sh

EXPOSE 80
CMD ["/usr/local/bin/start.sh"]
