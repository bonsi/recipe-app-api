FROM python:3.9-alpine3.13

LABEL maintainer="soulfyre.dev"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app

EXPOSE 8000

# DEV default value = false
ARG DEV=false

# kitty-terminfo not available yet in 3.13
#
# # RUN apk add --update kitty-terminfo \
# # 	&& rm -rf /var/cache/apk/*
# # RUN apk update && apk search kitty-terminfo
#
# # Ensure community repository is enabled
# RUN VERSION="v$(cut -d'.' -f1,2 /etc/alpine-release)" \
# 	&& echo "https://dl-cdn.alpinelinux.org/alpine/$VERSION/main/" > /etc/apk/repositories \
# 	&& echo "https://dl-cdn.alpinelinux.org/alpine/$VERSION/community/" >> /etc/apk/repositories
# # Install additional software
# RUN apk update
# 	# && apk add kitty-terminfo

RUN python -m venv /py && \
	/py/bin/pip install --upgrade pip && \
	/py/bin/pip install -r /tmp/requirements.txt && \
	if [ $DEV = "true" ]; \
	then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
	fi && \
	rm -rf /tmp && \
	adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"

USER django-user
