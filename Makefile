server:
	docker compose up -d
	docker compose logs -f

build:
	docker build -t koboldcpp-server .

run:
	docker run --rm -p 5001:5001 -v "$(pwd)/models":/models koboldcpp-server 