#!/bin/bash

python manage.py makemigrations
python manage.py migrate
python manage.py migrate --run-syncdb
python manage.py collectstatic --noinput

gunicorn -b 0.0.0.0:8000 PyEditorial.wsgi:application

python manage.py createsuperuser --noinput
