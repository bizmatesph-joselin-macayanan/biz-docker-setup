start-network:
	docker network create ph-finance
#	echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' | sudo tee /etc/resolv.conf > /dev/null;

start-bizmates-jp:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates.jp/docker-compose.yml up -d
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/common/docker-compose.yml up -d
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/databases/bizmates/docker-compose.yml up -d
stop-bizmates-jp:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates.jp/docker-compose.yml down
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/common/docker-compose.yml down
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/databases/bizmates/docker-compose.yml down

start-bizmates-ph:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates.jp/docker-compose.yml up -d
stop-bizmates-ph:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates.jp/docker-compose.yml down

start-fms:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/databases/fms/docker-compose.yml up -d
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-api up
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-main-api up
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-authentication-api up
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-app up
stop-fms:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/databases/fms/docker-compose.yml up -d
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-api down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-main-api down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-authentication-api down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-app down

start-gateway:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates-network/docker-compose.yml down
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates-network/docker-compose.yml up -d
stop-gateway:
	docker compose -f /home/bizmatesph-joselin/projects/biz-docker-setup/bizmates-network/docker-compose.yml down