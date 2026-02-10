FROM node:22.19.0-alpine

WORKDIR /app

# Copy root package manifests and Prisma schema
COPY package*.json ./
COPY prisma ./prisma

# Install dependencies (includes Prisma + PostgreSQL + socket.io)
RUN npm install

# Generate Prisma Client from root prisma/schema.prisma
RUN npx prisma generate

# Copy socket server source code
COPY socket-server ./socket-server

# Set working directory to socket-server
WORKDIR /app/socket-server

# Expose socket server port
EXPOSE 3000

# Start socket server
CMD ["node", "index.js"]

