# docker-xubuntu
Official Docker ubuntu image with XFCE and VNC Server

## Requirements
Only if you want to use VNC client (other solution is noVNC)
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
CID=$(sudo docker run -d xubuntu); CIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID); vncviewer $CIP:2
vncviewer <container_ip>:2
```

### Using noVNC
```bash
CID=$(sudo docker run -d xubuntu); CIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID); vncviewer $CIP:2
echo "http://<container_ip>:6901"
```

### Options

VNC password and resolution can be passed using environment variables.
