ARG NGINX_VERSION=latest
FROM nginx:${NGINX_VERSION}

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom Nginx configuration file
COPY default.conf /etc/nginx/conf.d/nginx.conf

# Copy the basic webpage HTML file
COPY index.html /usr/share/nginx/html/index.html

#SSL certificate and private keyFROM nginx:latest

COPY ./certs/server.crt /etc/nginx/ssl/server.crt
COPY ./certs/server.key /etc/nginx/ssl/server.key
