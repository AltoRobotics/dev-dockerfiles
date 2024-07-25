############################
# Backend
############################
FROM --platform=linux/amd64 golang:1.22.5-bookworm

RUN apt update && apt install -y --no-install-recommends make sqlite3

RUN mkdir -p /backend
COPY code /backend/
WORKDIR /backend
RUN make backend-populate-db
RUN make backend-build

EXPOSE 8080
#ENTRYPOINT ["/backend/server"]
ENTRYPOINT ["/usr/bin/make", "backend-run"]
