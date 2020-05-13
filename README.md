# docker-xubuntu
Official Docker ubuntu image with XFCE and VNC Server

## Requirements
```bash
sudo apt install xtightvncviewer
```

## Usage
### Build image
```bash
git clone https://github.com/jychp/docker-xubuntu
cd docker-xubuntu
docker build -t xubuntu .
```

### Launch and connect
```bash
sudo  container 940b9490a64a
CID=$(sudo docker run -d xubuntu); CIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID); vncviewer $CIP:2
vncviewer <container_ip>:2
```

### Options
```bash
docker run xubuntu password 1024x768
vncviewer <container_ip>:2
```
