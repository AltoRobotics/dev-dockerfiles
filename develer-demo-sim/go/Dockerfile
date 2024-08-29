FROM golang:latest

EXPOSE 8080

RUN mkdir -p /app
WORKDIR /app
ADD ./server /app
ADD ./db.sqlite /app

ENV HOST=""
ENV PORT=8080
ENV DATABASE_PATH=./db.sqlite
CMD ["./server"]
