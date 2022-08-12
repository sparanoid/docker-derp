# Docker DERP

Tailscale DERP server `derper` and `derpprobe` for Docker.

```fish
docker run \
  --restart=always \
  -p 58080:80 \
  -p 58443:443 \
  -p 3478:3478/udp \
  sparanoid/derp:local \
  derper --hostname example.com
```

## License

BSD 3-Clause
