FROM ubuntu:18.04

LABEL author="Carlos Eduardo" \
      version="1.0" \
      description="Docker version of Ceros-ski application"

RUN apt-get update && \
    apt-get install -y nodejs npm build-essential

COPY . /ceros-ski

WORKDIR /ceros-ski

RUN npm install

# This port is defined in web.js
EXPOSE 5000

ENTRYPOINT [ "npm", "start" ]
