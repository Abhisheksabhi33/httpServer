# Use the official Node.js image as a parent image
FROM node:14-slim

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .

# Generate random text content for data files during development
RUN mkdir -p /tmp/data \
    && for i in $(seq 1 30); do echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1) >> /tmp/data/${i}.txt; done

# Expose port 8080
EXPOSE 8080

# Run the application with nodemon
CMD ["npm", "start"]
