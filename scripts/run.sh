#!/bin/sh

set -e

chmod -R 755 /vol/web /vol/static

python manage.py wait_for_db
python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi