# rails-depot
Tutorial application following the Agile Web Development with Rails 6 book.

## Setup the development environment
1. Install ruby. For this project the ruby version is 2.7.2, as denoted in the `.tool-versions` file. I recommend using asdf (https://github.com/asdf-vm/asdf) with the ruby plugin (https://github.com/asdf-vm/asdf-ruby) to do this.
2. Install NodeJS (https://nodejs.org), for this project I'm using version `14.17.1`, but any LTS version should do fine.
3. Install the Yarn package manager(https://yarnpkg.com/): `npm install -g yarn`.
4. Install ChromeDriver. Check for instructions on their website: https://chromedriver.chromium.org/.
5. Install and run a local Postgres instance. A very easy way to do this is by using docker: `docker run --name postgres -e POSTGRES_PASSWORD=password -p 127.0.0.1:5432:5432 -v /home/<my_local_user>/postgres:/var/lib/postgresql/data -d postgres`. That command will run a docker image with postgres setting the password for the `postgres` user as `password`, running on `127.0.0.1:5432`, and map local folder `/home/<my_local_user>/postgres` to contain all the config and data. More info here: https://hub.docker.com/_/postgres.
6. Copy `config/database.yml.example` to `config/database.yml` and update info needed to connect to your database.
7. Run `bundle install` to install all ruby dependencies.
8. Run `bin/rails db:setup` to setup the development database.
9. Run `bin/rails db:seed` to fill the DB with development data.
10. Run `yarn install` to install the javascript dependencies.

## Running in development
Run `bin/rails server` to start the server in development mode.

## Running the tests
Run `bin/rails spec` to run the tests.

## Running lint
Lint by running `bundle exec rubocop`.
