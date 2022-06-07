# syntax=docker/dockerfile:1
FROM python:3.8-slim-buster
LABEL MAINTANER Sachin Kumar "sachinkumar.mlops@gmail.com"

WORKDIR /python-docker
COPY ./app/ .

RUN pip3 install -r requirements.txt


CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]

