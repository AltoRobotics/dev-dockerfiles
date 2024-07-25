############################
# Backend
############################
FROM --platform=linux/amd64 golang:latest AS builder_golang

RUN apt-get install -y --no-install-recommends make

RUN mkdir -p /backend
COPY code /backend/
WORKDIR /backend
RUN make backend-build

############################
# STEP 3 build a small image to run it all
############################
FROM --platform=linux/amd64 scratch

# Copy our static executable
COPY --from=builder_golang /backend/server /go/bin/server

EXPOSE 8080
ENTRYPOINT ["/go/bin/server"]