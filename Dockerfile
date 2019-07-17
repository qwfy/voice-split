FROM python:3.7.4

RUN mkdir /build
WORKDIR /build

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

WORKDIR /
RUN rm -rf /build