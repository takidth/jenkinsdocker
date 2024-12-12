FROM nginx:latest
RUN sed -i 's/nginx/taki/g' /usr/share/nginx/html/index.html
EXPOSE 80

