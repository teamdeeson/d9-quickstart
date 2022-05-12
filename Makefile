#
# Optionally include a .env file.
#
-include .env

#
# You can choose to not use Docker for local development by specifying the USE_DOCKER=0 environment variable in
# your project .env file.  The default is to use Docker for local development.
#

DOCKER_LOCAL ?= 0

#
# Default is what happens if you only type make.
#

default: start

#
# Bring in the external project dependencies.
#

install:
ifeq ("${DOCKER_LOCAL}","1")
	lando composer install
else
	composer install
endif

#
# Update all Composer dependencies.
#

update:
ifeq ("${DOCKER_LOCAL}","1")
	lando composer update
else
	composer update
endif

#
# Start the local development server.
#

start:
ifeq ("${DOCKER_LOCAL}","1")
	lando start
endif

stop:
ifeq ("${DOCKER_LOCAL}","1")
	lando stop
endif

restart: stop start

#
# Linting / testing / formatting.
#

lint:
	ifeq ("${DOCKER_LOCAL}","1")
		lando lint:standards
	endif

deprecated:
	ifeq ("${DOCKER_LOCAL}","1")
		lando lint:deprecated
	endif

phpcompat:
	ifeq ("${DOCKER_LOCAL}","1")
		lando lint:php
	endif

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
ifeq ("${DOCKER_LOCAL}","1")
	lando mysql
endif

logs-fe:
ifeq ("${DOCKER_LOCAL}","1")
	lando logs -s fe-node -f
endif

logs:
ifeq ("${DOCKER_LOCAL}","1")
	lando logs -s appserver -f
endif
