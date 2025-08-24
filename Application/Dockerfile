FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only package files & install dependencies
COPY package.json ./
RUN npm install --production

# Copy application files explicitly
COPY server.js .
COPY index.html .

# Expose container port
EXPOSE 80

# Run the app
CMD ["npm", "start"]
