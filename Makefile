#
# Optionally include a .env file.
#
-include .env

#
# You can choose to not use Docker for local development by specifying the USE_DOCKER=0 environment variable in
# your project .env file.  The default is to use Docker for local development.
#

USE_DOCKER ?= 0

#
# Default is what happens if you only type make.
#

default: start build

#
# Bring in the external project dependencies.
#

install:
ifeq ("${USE_DOCKER}","1")
	lando composer install
else
	composer install
endif

#
# Update all Composer dependencies.
#

update:
ifeq ("${USE_DOCKER}","1")
	lando composer update
else
	composer update
endif

#
# Start the local development server.
#

start:
ifeq ("${USE_DOCKER}","1")
	lando start
endif

stop:
ifeq ("${USE_DOCKER}","1")
	lando stop
endif

restart: stop start

#
# Build stages: Setup and configure the application for the environment.
#

build: install-drupal

install-drupal:
ifeq ("${USE_DOCKER}","1")
	lando drush @docker cim --yes
	lando drush @docker uli
endif

#
# Linting / testing / formatting.
#

lint:
	@echo "TBC ..."

test:
	@echo "TBC ..."

format:
	@echo "TBC ..."

#
# Delete all non version controlled files to reset the project.
#

clean: stop
	chmod -R +w docroot/sites/default
	rm -rf docroot vendor

#
# Generate project symlinks and other disposable assets and wiring.
#

generate-env:
	cp .env.example .env

docroot/sites/default/settings.php:
	ln -s ../../../src/settings/settings.php docroot/sites/default/settings.php

docroot/modules/custom:
	ln -s ../../src/modules $@

docroot/themes/custom:
	ln -s ../../src/themes $@

docroot/profiles/custom:
	ln -s ../../src/profiles $@

#
# Commands which get run from composer.json scripts section.
#

composer--post-install-cmd: composer--post-update-cmd
composer--post-update-cmd: docroot/sites/default/settings.php \
                                docroot/modules/custom \
                                docroot/themes/custom;

#
# Helper CLI commands.
#

sql-cli:
ifeq ("${USE_DOCKER}","1")
	lando mysql
endif

logs-fe:
ifeq ("${USE_DOCKER}","1")
	lando logs -s fe-node
endif

logs:
ifeq ("${USE_DOCKER}","1")
	lando logs -s appserver
endif
