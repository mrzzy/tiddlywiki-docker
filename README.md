# tiddywiki-docker
Tiddlywiki Node.js a docker container.

## Usage
Start tiddywiki docker container listening on port `8080`:
```
docker run -it --init \
    -p 8080:8080  \
    -e TIDDLYWIKI_USERNAME=mrzzy \
    -e TIDDLYWIKI_PASSWORD=changethis \
    -v /path/to/your/wiki:/wiki \
    ghcr.io/mrzzy/tiddlywiki:latest
```

## Storage
Tiddlywiki will persist tiddlers from the Docker container inside the `/wiki/` directory
- Mount / Persist `\wiki` the preserve tiddlers across container restarts

## Configuration
Configuration of the container is done via environment variables:
| Environment Variable | Description |
| --- | --- |
| `TIDDLYWIKI_AUTH_HEADER` | If set, configures the http header that tiddly uses to obtain the requester's username. |
| `TIDDLYWIKI_READERS` | Comma separated list of usernames allowed to read from this wiki. |
| `TIDDLYWIKI_WRITERS` | Comma separated list of usernames allowed to read from this wiki. |
| `TIDDLYWIKI_USERNAME` & `TIDDLYWIKI_PASSWORD` | If set, configures tiddlywiki to use basic http authentication. |
| `TIDDLYWIKI_DEBUG` | Whether to configure tiddlywiki to output debugging logs |

## Versioning
Containers are tagged with tags in the format:
- `TIDDLYWIKI_VERSION+IMAGE VERSION`: eg. `5.1.23-0.1.0`
- `TIDDLYWIKI_VERSION`: version of tiddywiki used in the container.
- `IMAGE_VERSION`: container specific version suffix as a [Sementic Version](https://semver.org/)
