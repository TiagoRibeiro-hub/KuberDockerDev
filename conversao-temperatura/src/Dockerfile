# https://hub.docker.com/_/node
FROM node:16.13.1
WORKDIR /app
# copiar os 2package.json no dir /app
COPY package*.json ./
RUN npm install
# copiar restantes arquivos
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]