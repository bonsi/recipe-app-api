.PHONY: up down test lint migrations migrate

# Set dir of Makefile to a variable to use later
MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))

migrate:
	docker compose run --rm app sh -c "python manage.py wait_for_db && python manage.py migrate"

migrations:
	docker compose run --rm app sh -c "python manage.py makemigrations"

test:
	docker compose run --rm app sh -c "python manage.py test"

lint:
	docker compose run --rm app sh -c "flake8"

up:
	docker compose up -d 

down:
	#cd flask-app && docker-compose down && docker-compose rm -f && docker rmi -f $(docker images -qf dangling=true)
	docker compose stop
