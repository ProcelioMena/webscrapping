# Project variables
APP_CONTAINER ?= ecovadis-flask-api
cov = false

.PHONY: check-env unit-test int-test lint install dev check-creds start stop clean

# Aesthetics
RED := "\e[1;31m"
YELLOW := "\e[1;33m"
NC := "\e[0m"
INFO := @bash -c 'printf $(YELLOW); echo "=> $$1"; printf $(NC)' MESSAGE
WARNING := @bash -c 'printf $(RED); echo "WARNING: $$1"; printf $(NC)' MESSAGE

define EXIT_MSG
    The containers already exist from the previous
    run of make dev.  Please run "make start" instead to
    spin the containers back up or run "make clean" to remove
    all containers and then rerun "make dev".
endef

export EXIT_MSG


check-env:
	@ echo "somos"

check-creds:
	@ [ -z $$ACCESS_KEY ] && echo "Environment variable ACCESS_KEY not set" && exit 1 || true
	@ [ -z $$SECRET_KEY ] && echo "Environment variable SECRET_KEY not set" && exit 1 || true
	@ [ -z $$SESSION_TOKEN ] && echo "Environment variable SESSION_TOKEN not set" && exit 1 || true

install: check-env
	${INFO} "Installing requirements for webscrapping"
	@ pip3 install -r requirements.txt 

lint:
	${INFO} "Running flake8 on all files"
	@ flake8 --config setup.cfg

unit-test:
	${INFO} "Running $(src) unit tests"
    ifeq ($(cov), true)
		pytest tests/unit/$(src) -c pytest-$(src).ini --cov=src/$(src) --cov-report=term --cov-config=.coveragerc
    else
		pytest tests/unit/$(src) -c pytest-$(src).ini
    endif

int-test:
	${INFO} "Running $(src) integrations tests"
	@ pytest tests/integration/$(src) -c pytest-$(src).ini

dev: check-env check-creds
	${INFO} "Spinning up local Acuris dev setup..."
	${INFO} "Running the application in development mode"
	@docker-compose build --build-arg CRAFT_PYPI_URL=$$CRAFT_PYPI_URL
	@docker-compose up

start:
	${INFO} "Starting local Ecovadis flask app..."
	@ docker start $(APP_CONTAINER)

stop:
	${INFO} "Stopping local Ecovadis flask app..."
	@ docker stop $(APP_CONTAINER)

clean: stop
	${INFO} "Removing local Ecovadis flask app..."
	@ docker rm $(APP_CONTAINER)

