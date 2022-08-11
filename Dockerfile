FROM golang:alpine AS builder

RUN go install tailscale.com/cmd/derper@main
RUN go install tailscale.com/cmd/derpprobe@main

FROM alpine

WORKDIR /app

COPY --from=builder /go/bin/* /usr/local/bin/

CMD derper
