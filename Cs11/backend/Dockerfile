FROM python:3
MAINTAINER YourName <you@example.com>

ENV PYTHONUNBUFFERED 1

# Installing packages
RUN apt-get update && apt-get install -y \
    libpq-dev \
    postgresql-client

RUN mkdir /code
WORKDIR /code

# create venv
RUN python3 -m venv code/venv

# activate venv
RUN . code/venv/bin/activate

# Copying dependencies
COPY requirements.txt /code/
RUN pip install -r requirements.txt

# Copying project files
COPY . /code/

EXPOSE 8000
EXPOSE 5000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
