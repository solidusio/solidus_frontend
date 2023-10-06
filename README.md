# solidus\_frontend

Frontend contains controllers and views implementing a storefront and cart for Solidus.

## 🚧 Warning

This gem is deprecated and no longer part of the Solidus recommended stack.

For new Solidus apps, we recommend that you use
[SolidusStarterFrontend](https://github.com/solidusio/solidus_starter_frontend)
instead.

This repository will only accept bug fixes and security patches for the
branches that match supported versions of Solidus:

| Branch                                                          | End of Life |
| --------------------------------------------------------------- | ----------- |
| [v3.4](https://github.com/solidusio/solidus_frontend/tree/v3.4) | 2024-10-21  |
| [v3.3](https://github.com/solidusio/solidus_frontend/tree/v3.3) | 2024-07-24  |
| [v3.2](https://github.com/solidusio/solidus_frontend/tree/v3.2) | 2024-02-18  |

## Override views

In order to customize a view you should copy the file into your host app. Using Deface is not
recommended as it provides lots of headaches while debugging and degrades your shops performance.

Solidus provides a generator to help with copying the right view into your host app.

Simply call the generator to copy all views into your host app.

```bash
$ bundle exec rails g solidus:views:override
```

If you only want to copy certain views into your host app, you can provide the `--only` argument:

```bash
$ bundle exec rails g solidus:views:override --only products/show
```

The argument to `--only` can also be a substring of the name of the view from the `app/views/spree` folder:

```bash
$ bundle exec rails g solidus:views:override --only product
```

This will copy all views whose directory or filename contains the string "product".

### Handle upgrades

After upgrading Solidus to a new version run the generator again and follow on screen instructions.

## Developing Solidus Frontend

* Clone the Git repo

  ```bash
  git clone git://github.com/solidusio/solidus_frontend.git
  cd solidus
  ```

### Without Docker

* Install the gem dependencies

  ```bash
  bin/setup
  ```

  _Note_: If you're using PostgreSQL or MySQL, you'll need to install those gems through the DB environment variable.

  ```bash
  # PostgreSQL
  export DB=postgresql
  bin/setup

  # MySQL
  export DB=mysql
  bin/setup
  ```

### With Docker

```bash
docker-compose up -d
```

Wait for all the gems to be installed (progress can be checked through `docker-compose logs -f app`).

You can provide the ruby version you want your image to use:

```bash
docker-compose build --build-arg RUBY_VERSION=2.6 app
docker-compose up -d
```

The rails version can be customized at runtime through `RAILS_VERSION` environment variable:

```bash
RAILS_VERSION='~> 5.0' docker-compose up -d
```

Running tests:

```bash
# sqlite
docker-compose exec app bundle exec rspec
# postgres
docker-compose exec app env DB=postgres bundle exec rspec
# mysql
docker-compose exec app env DB=mysql bundle exec rspec
```

Accessing the databases:

```bash
# sqlite
docker-compose exec app sqlite3 /path/to/db
# postgres
docker-compose exec app env PGPASSWORD=password psql -U root -h postgres
# mysql
docker-compose exec app mysql -u root -h mysql -ppassword
```

In order to be able to access the [sandbox application](#sandbox), just make
sure to provide the appropriate `--binding` option to `rails server`. By
default, port `3000` is exposed, but you can change it through `SANDBOX_PORT`
environment variable:

```bash
SANDBOX_PORT=4000 docker-compose up -d
docker-compose exec app bin/sandbox
docker-compose exec app bin/rails server --binding 0.0.0.0 --port 4000
```

### Sandbox

Solidus is meant to be run within the context of Rails application. You can
easily create a sandbox application inside of your cloned source directory for
testing purposes.

This sandbox includes solidus\_auth\_devise and generates with seed and sample
data already loaded.

* Create the sandbox application

  ```bash
  bin/sandbox
  ```

  You can create a sandbox with PostgreSQL or MySQL by setting the DB environment variable.

  ```bash
  # PostgreSQL
  export DB=postgresql
  bin/sandbox

  # MySQL
  export DB=mysql
  bin/sandbox
  ```

  If you need to create a Rails 5.2 application for your sandbox, for example
  if you are still using Ruby 2.4 which is not supported by Rails 6, you can
  use the `RAILS_VERSION` environment variable.

  ```bash
    export RAILS_VERSION='~> 5.2.0'
    bin/setup
    bin/sandbox
  ```

* Start the server (`bin/rails` will forward any argument to the sandbox)

  ```bash
  bin/rails server
  ```

### Tests

Solidus uses [RSpec](http://rspec.info) for tests. Refer to its documentation for
more information about the testing library.

#### CircleCI

We use CircleCI to run the tests for Solidus as well as all incoming pull
requests. All pull requests must pass to be merged.

You can see the build statuses at
[https://circleci.com/gh/solidusio/solidus_frontend](https://circleci.com/gh/solidusio/solidus_frontend).

#### Run all tests

[ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/home) is
required to run the frontend suites.

Run the tests

```bash
bundle exec rspec
```

By default, `rspec` runs the tests for SQLite 3. If you would like to run specs
against another database you may specify the database in the command:

```bash
env DB=postgresql bundle exec rspec
```

#### Code coverage reports

If you want to run the [SimpleCov](https://github.com/colszowka/simplecov) code
coverage report:

```bash
COVERAGE=true bundle exec rspec
```

### Releasing new versions

Please refer to the dedicated [page](https://github.com/solidusio/solidus/wiki/How-to-release-extensions) on Solidus wiki.
