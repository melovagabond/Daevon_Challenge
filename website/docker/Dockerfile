FROM nginx:latest

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Copy the basic webpage HTML file
COPY index.html /usr/share/nginx/html/index.html

#SSL certificate and private keyFROM nginx:latest

COPY server.crt /etc/nginx/ssl/server.crt
COPY server.key /etc/nginx/ssl/server.key
