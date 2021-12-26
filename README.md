# Youtube Dl

This is a Web UI for well-known `youtube-dl` tool.

It is not intended only for local use and don't have many features required for production like authentication or security.
Pull requests are welcome for both local and production use.

The intended use is run it locally with your NAS mounted, drop youtube videos to it and watch them on your TV from the NAS.

## Setup

1. Create `.env` and `docker-compose.override.yml` files from the examples provided. Make sure you mount your download dir to both `web` and `sidekiq` containers in `docker-compose.override.yml`
2. Create and migrate database:
```
docker-compose run app /bin/bash
bundle exec hanami db migrate
```
3. Start the app: `docker-compose up -d`

## License and authors
* License:: MIT
* Author:: Timur Batyrshin <timurb@hey.com>
