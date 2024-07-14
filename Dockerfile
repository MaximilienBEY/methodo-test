# Use the official Node.js 18 image as a base
FROM node:18-alpine

# Install bash
RUN apk add --no-cache bash curl coreutils

# Set the working directory to /app
WORKDIR /app

# Copy the server directory contents to the container
COPY server/ ./server/

# Install dependencies in the server directory
RUN cd server && npm install

# Copy the rest of the application to the container
COPY . .

# Make main.sh executable
RUN chmod +x main.sh

# Command to run main.sh
CMD ["/bin/bash", "./main.sh"]