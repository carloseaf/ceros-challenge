FROM ubuntu:18.04

LABEL author="Carlos Eduardo" \
      version="1.0" \
      description="Nginx - Load balance for ceros-ski application"

RUN apt-get update && \
    apt-get install -y nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

STOPSIGNAL SIGTERM

ENTRYPOINT ["nginx", "-g", "daemon off;"]

