FROM ubuntu:latest

# Install Nginx.
RUN \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Install Node.js and npm
RUN \
  apt-get update && \
  apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

# Install Amplify CLI
RUN npm install -g @aws-amplify/cli

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Copy Amplify project files to the container
COPY . /app
WORKDIR /app

# Install project dependencies
RUN npm install

# Run Amplify commands
RUN amplify push

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
