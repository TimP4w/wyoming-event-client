FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Install GCC and other build essentials
RUN apt-get update && \
  apt-get install -y --no-install-recommends gcc libc6-dev && \
  rm -rf /var/lib/apt/lists/*

COPY event_handler.py requirements.txt MANIFEST.in ./

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --upgrade --upgrade wheel setuptools
RUN pip install --no-cache-dir -f 'https://synesthesiam.github.io/prebuilt-apps/' -r requirements.txt
RUN pip install --no-cache-dir RPi.GPIO pigpio

EXPOSE 10500

CMD ["python", "event_handler.py"]
