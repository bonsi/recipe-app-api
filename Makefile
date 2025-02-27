.PHONY: up down test

# Set dir of Makefile to a variable to use later
MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))

test:
	docker compose run --rm app sh -c "python manage.py test"

up:
	docker compose up -d 

down:
	#cd flask-app && docker-compose down && docker-compose rm -f && docker rmi -f $(docker images -qf dangling=true)
	docker compose stop
