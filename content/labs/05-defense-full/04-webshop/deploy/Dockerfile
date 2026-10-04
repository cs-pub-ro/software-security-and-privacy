FROM php:7.4-apache

RUN docker-php-ext-install mysqli

COPY ./app/ /var/www/html/

# The web-root flag is a decoy. The real flag lives in /flag on the DATABASE
# server and is reached through the SQL injection (LOAD_FILE), not served here.
RUN printf 'SSP{decoy_the_real_flag_is_in_/flag_on_the_db_via_LOAD_FILE}\n' \
        > /var/www/html/flag

EXPOSE 80
