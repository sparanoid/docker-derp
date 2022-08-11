```fish
docker run \
  --restart=always \
  -p 58080:80 \
  -p 58443:443 \
  -p 3478:3478/udp \
  sparanoid/derp:local \
  derper --hostname example.com \
```
