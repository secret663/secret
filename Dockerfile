FROM python:3.10-slim

# I-install ang C++ compiler at i-compile si pycdc
RUN apt-get update && apt-get install -y \
    git cmake build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/zrax/pycdc.git /pycdc
RUN cd /pycdc && cmake . && make
RUN cp /pycdc/pycdc /usr/local/bin/

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

CMD gunicorn api_server:app
