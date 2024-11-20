FROM node:lts-buster-slim

# Install packages
RUN apt update && apt install supervisor -y

# Setup app
RUN mkdir -p /app && chown -R root:root /app


# Add flag
COPY flag.txt /flag.txt

# Add application
WORKDIR /app
COPY challenge .
RUN chown -R www-data:www-data .





# Install dependencies
RUN npm install --production

# Setup superivsord
COPY config/supervisord.conf /etc/supervisord.conf


# Expose the port node-js is reachable on
EXPOSE 1337

# Start the node-js application
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
