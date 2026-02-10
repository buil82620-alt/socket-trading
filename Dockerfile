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
COPY . .

# Set working directory to socket-server
WORKDIR /app

# Expose port (Render will set PORT env var, but we expose common ports)
EXPOSE 3000 8080

# Start socket server
CMD ["node", "index.js"]

