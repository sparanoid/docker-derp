FROM golang:alpine AS builder

RUN go install tailscale.com/cmd/derper@main

FROM alpine

WORKDIR /app

ENV DERP_DOMAIN example.com
ENV DERP_VERIFY_CLIENTS false

COPY --from=builder /go/bin/derper .

# HEALTHCHECK --interval=1m --timeout=30s --start-period=10s --retries=1 CMD wget --no-verbose --tries=1 --spider https://$DERP_DOMAIN:10443 || kill 1

CMD /app/derper --hostname $DERP_DOMAIN --verify-clients=$DERP_VERIFY_CLIENTS
