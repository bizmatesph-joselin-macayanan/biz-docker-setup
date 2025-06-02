start-network:
	docker network create ph-finance
start-bizmates-jp:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates.jp/docker-compose.yml up -d
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/common/docker-compose.yml up -d
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/databases/bizmates/docker-compose.yml up -d
start-gateway:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates-network/docker-compose.yml up -d