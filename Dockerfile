# Use an appropriate base image
FROM nginx:latest

# Copy your Nginx configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your application files to the appropriate directory
COPY app /usr/share/nginx/html

# Expose ports
EXPOSE 80

# Define default command
CMD ["nginx", "-g", "daemon off;"]
