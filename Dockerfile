FROM python:3.9

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
  vim-tiny \
  binutils \
  libproj-dev \
  gdal-bin \
  python-gdal \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app
ENV PYTHONUNBUFFERED 1

CMD ["gunicorn", "--reload", "--workers=2", "--worker-tmp-dir", "/dev/shm", "--bind=0.0.0.0:80", "--chdir", "/app/PROJECT_NAME", "PROJECT_NAME.wsgi"]
