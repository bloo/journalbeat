FROM golang:1.8.0

RUN apt-get update && apt-get install -y \
  libsystemd-dev

RUN go get github.com/mheese/journalbeat
RUN mkdir -p /etc/journalbeat/
RUN cp /go/src/github.com/mheese/journalbeat/etc/journalbeat.yml /etc

WORKDIR /etc
CMD journalbeat
