build:
	docker build -t pw/crudservice:latest ./service/

build-nc:
	docker build --no-cache -t pw/crudservice:latest ./service/

build-minikube:
	eval $(minikube docker-env) && docker build --no-cache -t pw/crudservice:latest ./service/

run: build
	docker run --env REDIS_HOST=host.docker.internal --env REDIS_PORT=6379 -it --rm --name pwcrudservice -p 8000:8000 -v ./service.cfg:/app/service.cfg pw/crudservice:latest

stop:
	docker stop pwcrudservice

build-redis:
	docker build -t pw/redis:7.2.4-alpine ./redis/

run-redis:
	docker run -it -d --rm --name pwredis pw/redis:7.2.4-alpine redis-server --save 60 1 --loglevel warning

stop-redis:
	docker stop pwredis

up:
	docker compose up

down:
	docker compose down