FROM nginx:latest

RUN rm -rf /usr/share/nginx/html/*

COPY index.html /usr/share/nginx/html
#Hi
EXPOSE 80
