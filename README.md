# Install

Clone repo and build image:

```
git clone https://github.com/ilyaglow/w3af-docker.git
docker build -t my-w3af-docker .
```

# Start

Console version:

```
docker run -it my-w3af-docker ./w3af_console
```

Start API:

```
docker run -p 5000:5000 -it my-w3af-docker ./w3af_api -u YOUR_USERNAME -p $(echo -n "YOUR_PASSWORD" | sha512sum | cut -d ' ' -f1) 0.0.0.0:5000
```

Start API without authentication:

```
docker run -p 5000:5000 -it my-w3af-docker ./w3af_api
```
