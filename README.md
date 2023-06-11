# transmission-pia

Docker image providing transmission bittorrent client web gui but traffic routed through pia openvpn.

Run as follows:

```
docker run -it -e "PIA_USERNAME=replaceme" -e "PIA_PASSWORD=replaceme" -p 9091:9091 --cap-add=NET_ADMIN --device /dev/net/tun transmission-pia
```
