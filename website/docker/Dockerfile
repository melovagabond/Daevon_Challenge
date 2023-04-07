FROM nginx:latest

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Copy the basic webpage HTML file
COPY index.html /usr/share/nginx/html/
