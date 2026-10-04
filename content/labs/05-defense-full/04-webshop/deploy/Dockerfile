# The webshop targets the PHP5 / mysql_* era. Build verification is owed:
# either use a php5 base image, or port the app to mysqli (see INSTRUCTOR.md).
FROM php:7.4-apache

ARG FLAG="SSP{placeholder}"

RUN docker-php-ext-install mysqli

COPY ./app/ /var/www/html/
# The real flag lives in a UNIX file the web user must be made to read
# through the injection; it is not served directly.
RUN printf '%s\n' "${FLAG}" > /flag && chmod 644 /flag

EXPOSE 80
