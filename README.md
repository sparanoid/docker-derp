# Docker DERP

Tailscale DERP server `derper` and `derpprobe` for Docker.

- Official documentation: [Custom DERP Servers](https://tailscale.com/kb/1118/custom-derp-servers/)
- All available options: [cmd/derper/derper.go](https://github.com/tailscale/tailscale/blob/main/cmd/derper/derper.go)

```fish
docker run \
  --restart=always --init \
  -p 80:80 \
  -p 443:443 \
  -p 3478:3478/udp \
  sparanoid/derp:edge \
  derper --hostname example.com

# External certificates
docker run \
  --restart=always --init \
  -p 80:80 \
  -p 443:443 \
  -p 3478:3478/udp \
  -v (path_to_cert_root)/fullchain.cer:/app/certs/derp.example.com.net.crt \
  -v (path_to_cert_root)/example.com.key:/app/certs/derp.example.com.key \
  sparanoid/derp:edge \
  derper --hostname example.com \
    --certmode manual

# Verify clients
docker run \
  --restart=always --init \
  -p 80:80 \
  -p 443:443 \
  -p 3478:3478/udp \
  -v /var/run/tailscale/tailscaled.sock:/var/run/tailscale/tailscaled.sock \
  sparanoid/derp:edge \
  derper --hostname example.com

# Rum `derpprobe`
docker run sparanoid/derp:edge derpprobe
```

Docker Compose example:

```yaml
derp:
  image: sparanoid/derp
  restart: always
  init: true
  ports:
    - 80:80
    - 443:443
    - 3478:3478/udp
  depends_on:
    tailscale:
      condition: service_started
  volumes:
    - ./ssl/fullchain.cer:/app/certs/derp.example.com.crt
    - ./ssl/example.com.key:/app/certs/derp.example.com.key
    - /var/run/tailscale/tailscaled.sock:/var/run/tailscale/tailscaled.sock
  command: sh -c "
    derper \
      -hostname example.com \
      -certdir /app/certs \
      -certmode manual \
      -verify-clients true"
```

## License

BSD 3-Clause
