# Intentions

The official docker for w3af [is](https://github.com/andresriancho/w3af/blob/master/extras/docker/Dockerfile) [available](https://hub.docker.com/r/andresriancho/w3af/).

The reason I made this is that I do not plan to use GUI version of w3af at all. I do not want to install ssh-server inside container and want to keep Dockerfile as simple as possible.

# Install

Clone repo and build image:

```
git clone https://github.com/ilyaglow/w3af-docker.git
docker build -t my-w3af .
```

# Start

## Console version

*NOTE*: w3af console has issues on alpine

```
docker run -it -v /home/username/w3af-share:/home/w3af/share my-w3af ./w3af_console
```

The /home/username/w3af-share is a directory for sharing outputs, profiles etc between host and container. *Caveat*: `~/w3af-share` should be user-owned directory (nonroot).

## Start API

```
docker run -p 127.0.0.1:5000:5000 -it my-w3af ./w3af_api -u YOUR_USERNAME -p $(echo -n "YOUR_PASSWORD" | sha512sum | cut -d ' ' -f1) 0.0.0.0:5000
```

## Hardening

Drop unneeded container capabilities (need further testing):

```
docker run --cap-drop NET_RAW --cap-drop SYS_CHROOT --cap-drop MKNOD -it -v /home/username/w3af-share:/home/w3af/share my-w3af ./w3af_console

docker run --cap-drop NET_RAW --cap-drop SYS_CHROOT --cap-drop MKNOD -p 127.0.0.1:5000:5000 -it -v /home/username/w3af-share:/home/w3af/share my-w3af ./w3af_api -u YOUR_USERNAME -p $(echo -n "YOUR_PASSWORD" | sha512sum | cut -d ' ' -f1) 0.0.0.0:5000
```
