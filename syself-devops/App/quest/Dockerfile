# Use an official Node.js runtime as a parent image
FROM node:20

# Set the working directory
WORKDIR /quest/src/index.js

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set environment variable
ENV SECRET=Set

# Expose the port the app runs on
EXPOSE 8080

# Define environment variables
ENV PORT=8080

# Start the app
CMD ["node", "src/index.js"]
