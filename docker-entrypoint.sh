#!/bin/sh
set -euo pipefail

if [[ "${DB_HOST}" != "db" ]]; then
  php artisan voyager:install
fi

if [[ "${MAIL}" != "your@mail.addr" ]]; then
  sed -ri -e "s/^(\s*ServerAdmin).*$/\1 ${MAIL}/g" /etc/apache2/httpd.conf
  php artisan voyager:admin ${MAIL} --create
fi

rm -f /run/apache2/httpd.pid
exec httpd -DFOREGROUND
