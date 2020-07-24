# Drupal 9

This project is a tool for quickly bootstrapping a Drupal 9 website using the standards and best practice of the [Deeson](https://www.deeson.co.uk) web development agency.

This project works with MacOSX and Linux but it is not tested on other operating systems.  It probably does not work on Windows.

## Dependencies

* [Docker](https://docs.docker.com/engine/installation/)
* [Docker compose](https://docs.docker.com/compose/install/)
* [Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx)
* [Deeson Docker proxy](https://github.com/teamdeeson/docker-proxy)

## Creating a new Drupal 9 site

Use the following command to create a new Drupal 9 project. Replace `<project-name>` with your own name.  Keep the project name short and without punctuation (e.g. myproject)

```bash
composer create-project teamdeeson/d9-quickstart <project-name> --stability dev --no-interaction
```

You should now switch to the project directory and create a new git repository, and commit all files not excluded by the .gitignore file.

```
cd <project-name>
git init
git add .
git commit -m "Created the project."
```

### Required configuration

You should configure the project for your needs now. The following amendments need to be made at a minimum:

`.env:` Change the PROJECT_NAME and PROJECT_BASE_URL for your project (the url must end in .localhost). Make up a new HASH_SALT string.

`src/settings/environment.inc:` Configure your domain names here if you know what the remote ones are going to be.

`src/settings/02-shield.settings.inc:` Configure basic-auth access details to protect your dev sites (Acquia only)

## Build and install

The project can now be built for the first time using the included Makefile

```bash
make
```

This will create the `docroot/` folder and build your website.

It should finish with a one time login URL which you can copy into the Chrome web browser to access your new Drupal site.

## Starting and stopping the project.

Once you have run the build for the first time, you can stop the project any time with:

```
make stop
```

The project starts again using:

```
make start
```

## Browser access

You can access localhost domains in Chrome without making any changes.  If you want to use other browsers you have to add an entry to your `/etc/hosts` file for this project (replace project url with your url):

```
127.0.0.1 project.localhost
```

## Managing dependencies with composer

All of your dependencies should be managed through composer. This includes any off-the-shelf code such as Drupal core, contrib modules and themes, and any 3rd party libraries.

### To add a module (e.g. redirect):

```bash
composer require drupal/redirect
```

### To update a module (e.g. redirect):

```bash
composer update drupal/redirect
```

### To update Drupal core:
```bash
composer update drupal/core --with-dependencies
```

**You should commit your composer.lock file to the repository as this will guarantee that any subsequent builds will use the same exact version of all
your dependencies.**

For further details, see the Drupal Composer project documentation:

https://github.com/drupal-composer/drupal-project#composer-template-for-drupal-projects

Composer project usage guide:

https://getcomposer.org/doc/01-basic-usage.md

## Xdebug

You need to run `sudo ifconfig lo0 alias 10.254.254.254` before Xdebug connections will work. This is usually required each time you log-in to your development machine, but is safe to run periodically.

## Running tests

This repository contains the starting point for running both Behat and PHPUnit test suites as well as Drupal coding standards checks with PHPCS.

PHPUnit tests should be defined within you custom modules, in the tests/ sub-directory.

Behat tests should be defined in the behat-tests directory in the project root.

```bash
make test
```
will run all of the Project's automated tests.

## Project structure

### docroot/
This directory contains compiled content and should not normally be committed to your repository.

### drush/
This contains your drush site aliases file(s).

### src/
This contains all of your project source code. As follows:

#### src/config/
This contains Drupal's CMI configuration files.

#### src/frontend/
For all your front end needs. This makes use of our front end setup, you can find out how here : https://github.com/teamdeeson/deeson-webpack-config

#### src/modules/
This is where you place your custom modules.

Anything within `src/modules/` will be made available in `docroot/modules/custom/`

#### src/settings/
This contains the Drupal site settings, extracted from settings.php.

#### src/themes/
This is where you place your custom theme(s).

Anything within `src/themes/` will be made available in `docroot/themes/custom/`

##### src/themes/deeson_frontend_framework
The default hook up between drupal and src/frontend. Your theme can either inherit from this or follow the instructions from https://github.com/teamdeeson/deeson-webpack-config to do it yourself (its not tricky).

These need to be included in your settings file in the usual way:

```php
$settings['container_yamls'][] = dirname(DRUPAL_ROOT) . '/src/services/development.services.yml';
```

### vendor/
This is the composer vendor directory, which contains project dependencies, tools and libraries. This should be excluded from your repository.

### web/
This and `docroot/` are symlinked to the same location for wider compatibility and should also be excluded from your repository.

# Docker commands

You should now have several running docker containers, including nginx, php, mariadb. Run the following command to check this.

```
docker-compose ps
```

You can access the realtime logs from these with:

```
make logs
```

or the logs from a specific container with:

```
docker-compose logs php -f
```

If you want to delete the site and rerun the installation process you can use:

```bash
make clean && make install
```

You can use the docker-compose tool as a shortcut for common docker commands. To run a command within one of the containers you can use:
```
docker-compose exec <container-name> <command>
```

For example to start a mysql client on the database container (mariadb) run:
```
docker-compose exec mariadb mysql
```

To get a bash terminal inside the PHP container you can use the following:

```bash
docker-compose exec php /bin/bash
```

To import an exported site database into the database container (if you don't have pv installed you can do so with `brew install pv`):

```bash
pv database_export_filename.sql | docker-compose exec -T mariadb mysql -udrupal -pdrupal drupal
```

Note that this method is up to 33% faster than the drush method `pv database_export_filename.sql | drush @docker sql-cli`

# Known issues

## Deeson Docker Proxy not running.

`ERROR: Network proxy declared as external, but could not be found. Please create the network manually using 'docker network create proxy' and try again.`

The Docker proxy needs to be running. See dependencies above. 

## Using Drush with Acquia

You may need to add the following to your ~/.ssh/config when working with Drush and Acquia remote hosts:

```
Host *.acquia-sites.com
   LogLevel QUIET
```


