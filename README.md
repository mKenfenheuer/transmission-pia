# transmission-pia

Docker image providing transmission bittorrent client web gui but traffic routed through pia openvpn.

Run as follows:

```
docker run -it -e "PIA_USERNAME=replaceme" -e "PIA_PASSWORD=replaceme" -p 9091:9091 --cap-add=NET_ADMIN --device /dev/net/tun transmission-pia
```


Settings via ENV:
| ENV Variable | Default | Description |
|----|----|----|
| PIA_OPENVPN_URL | `https://www.privateinternetaccess.com/openvpn/openvpn.zip` | Url to download PIA openvpn zip file. [See here](https://helpdesk.privateinternetaccess.com/kb/articles/where-can-i-find-your-ovpn-files) |
| PIA_OPENVPN_FILE | `belgium.ovpn` | Name of the .ovpn file inside the zip downloaded to be run |
| PIA_USERNAME | `replaceme` | Your PIA username to login |
| PIA_PASSWORD | `replaceme` | Your PIA password to login | 
| TRANSMISSION_USERNAME | `transmission` | Transmission webgui username |
| TRANSMISSION_PASSWORD | `transmission` | Transmission webgui password |
