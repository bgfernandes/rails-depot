# rails-depot
Tutorial application following the Agile Web Development with Rails 6 book.

## Setup development environment
1. Install and run a local Postgres instance. A very easy way to do this is by using docker: `docker run --name postgres -e POSTGRES_PASSWORD=password -p 127.0.0.1:5432:5432 -v /home/<my_local_user>/postgres:/var/lib/postgresql/data -d postgres`. That command will run a docker image with postgres setting the password for the `postgres` user as `password`, running on `127.0.0.1:5432`, and map local folder `/home/<my_local_user>/postgres` to contain all the config and data. More info here: https://hub.docker.com/_/postgres.
2. Copy `config/database.yml.example` to `config/database.yml` and update info needed to connect to your database.
3. Run `./bin/rails db:setup` to setup the development database.
4. Run `yarn install` to install the javascript dependencies.

## Running in development
Run `./bin/rails server` to start the server in development mode.
