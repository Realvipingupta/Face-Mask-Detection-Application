# This is Docker build image for Dev - Env
# syntax=docker/dockerfile:1

# Pull official base image
FROM python:3.9.13

# Set working directory
WORKDIR /app

# RUN mkdir -p lidar-and-building-footprint

# Install tools required for project
RUN apt-get update -y && pip install virtualenv
# RUN apt-get -y install gdal-bin
# RUN apt-get -y install libgdal-dev
# RUN apt-get -y install ffmpeg libsm6 libxext6

# Copy the entire project and build it
COPY . /app/

RUN python3 -m venv /opt/env

ENV PATH="/opt/env/bin:$PATH"

# Install app dependencies
RUN pip3 install -Ur requirements.txt

RUN python3 manage.py migrate

# This run the server at default port 8000
EXPOSE 8000

# The command executed when running a Docker container based on this image.
CMD [ "python3", "./manage.py", "runserver", "0.0.0.0:8000"]

MAINTAINER Vipin Gupta <vipin.g@mantralabsglobal.com>
