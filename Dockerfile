FROM nginx:latest
RUN apt install -y net-tools
COPY ./index.html /usr/share/nginx/html/index.html
EXPOSE 80