FROM python:3.9

WORKDIR /app
COPY . .

# install requirements
RUN pip install -r requirements.txt

# migrations
RUN python manage.py makemigrations
RUN python manage.py migrate

# sync db
RUN python manage.py migrate --run-syncdb

# static
RUN python manage.py collectstatic --noinput

# run gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8000", "PyEditorial.wsgi:application"]

EXPOSE 8000

