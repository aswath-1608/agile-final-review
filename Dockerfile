FROM nginx:1.27-alpine
COPY app/index.html /usr/share/nginx/html/index.html
EXPOSE 80
HEALTHCHECK CMD wget -qO- http://localhost/ || exit 1
