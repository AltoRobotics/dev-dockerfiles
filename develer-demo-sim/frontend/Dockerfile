############################
# Frontend
############################
FROM --platform=linux/amd64 node:16-alpine

RUN mkdir -p /frontend/web
WORKDIR /frontend
COPY web/.env ./
WORKDIR /frontend/web
COPY web ./
RUN npm install

EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/npm", "run", "start"]