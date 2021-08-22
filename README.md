# tiddlywiki-docker
Tiddlywiki Node.js a docker container.


## Introduction
Tiddlywiki on Node.js wrapped in docker container with some quality of life features:
- exposes [configuration](#Configuration) via environment variables for easy configuration.
- automatically bootstraps a [wiki in folder structure](https://www.google.com/search?channel=fs&client=ubuntu&q=tiddlywiki+folder+format)
    if one is not yet present.
- optionally bootstraps a wiki with a no. of quality of life plugins:

| Plugin | Description |
| --- | --- |
| Codemirror | Replaces the default editor with one powered by Codemirror. |
| Markdown | Enables writing of tiddlers in Markdown instead of just Wikitext. |
| Katex | Enables the rendering of math expressions in Latex. |
| tw5-relink | Fixes links when tiddlers are renamed. |
| tw5-extendedit | Autocompletion of tiddler names when linking with `[[` |
| edit-autolist | Automatically inserts `*` and indents when creating lists in Wikitext. |
| Notebook theme | Makes Tiddlywiki pretty with the notebook theme. |
| TWCrossLinks | Shows links from other tiddlers at the bottom of each tiddler. |
| Context Plugin | Shows the surrounding context when performing a full text search. |
| TiddlyWikiFormula | Allows Tiddlywiki to evaluates Excel like formulas. |

> Disable plugin bootstraping by setting `TIDDLYWIKI_BARE` environment variable.  
> This will direct `tiddlywiki-docker` to create the default bare bones wiki.


## Usage
Start tiddlywiki docker container listening on port `8080`:
```
docker run -it --init \
    -p 8080:8080  \
    -v /path/to/your/wiki:/wiki \
    ghcr.io/mrzzy/tiddlywiki:latest
```

## Storage
Tiddlywiki will persist tiddlers from the Docker container inside the `/wiki` directory
- Mount / Persist `/wiki` the preserve tiddlers across container restarts

## Configuration
Configuration of the container is done via environment variables:
| Environment Variable | Description |
| --- | --- |
| `TIDDLYWIKI_AUTH_HEADER` | If set, configures the **lowercase** http header that the wiki uses to obtain the requester's username. |
| `TIDDLYWIKI_READERS` | Comma separated list of usernames allowed to read from this wiki. Use special token `(anon)` or `(authenticated)` to allow all users or all authenticated users to read from the wiki respectively. Defaults to `(authenticated)`. |
| `TIDDLYWIKI_WRITERS` | Comma separated list of usernames allowed to write to this wiki. Use special token `(anon)` or `(authenticated)` to allow all users or all authenticated users to write the wiki respectively.  Defaults to `(authenticated)`. |
| `TIDDLYWIKI_USERNAME` & `TIDDLYWIKI_PASSWORD` | If set, configures tiddlywiki to use basic http authentication. |
| `TIDDLYWIKI_DEBUG` | Whether to configure tiddlywiki to output debugging logs. |
| `TIDDLYWIKI_BARE` | If set does initizalise `/wiki` with the built in template. Instead initizalise `/wiki` as a bare bones tiddlywiki. |

> :warning: Specify `TIDDLYWIKI_AUTH_HEADER` in lowercase.
> (ie specify `x-forwarded-user` instead of `X-Forwarded-User`

## Versioning
Containers are tagged with tags in the format:
- `TIDDLYWIKI_VERSION-IMAGE VERSION`: eg. `5.1.23-0.0.1`
- `TIDDLYWIKI_VERSION`: version of tiddlywiki used in the container.
- `IMAGE_VERSION`: container specific version suffix as a [Sementic Version](https://semver.org/)
