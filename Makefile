start-network:
	docker network create ph-finance
#	echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' | sudo tee /etc/resolv.conf > /dev/null;

start-jp:
	docker compose -f ./bizmates.jp/docker-compose.yml up -d
	docker compose -f ./common/docker-compose.yml up -d
	docker compose -f ./databases/bizmates/docker-compose.yml up -d
stop-jp:
	docker compose -f ./bizmates.jp/docker-compose.yml down
	docker compose -f ./common/docker-compose.yml down
	docker compose -f ./databases/bizmates/docker-compose.yml down

start-student:
	docker compose -f ./student/docker-compose.yml up -d
stop-student:
	docker compose -f ./student/docker-compose.yml down

start-trainer:
	docker compose -f ./trainer/docker-compose.yml up -d
stop-trainer:
	docker compose -f ./trainer/docker-compose.yml down

start-mystage:
	docker compose -f ./databases/chat-db/docker-compose.yml up -d
	docker compose -f ./mystage/docker-compose.yml up -d
stop-mystage:
	docker compose -f ./databases/chat-db/docker-compose.yml down
	docker compose -f ./mystage/docker-compose.yml down

start-ph:
	docker compose -f ./bizmates.ph/docker-compose.yml up -d
stop-ph:
	docker compose -f ./bizmates.jp/docker-compose.yml down

start-fms:
	docker compose -f ./databases/fms/docker-compose.yml up -d
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-api up
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-main-api up
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-authentication-api up
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-app up
stop-fms:
	docker compose -f ./databases/fms/docker-compose.yml down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-api down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-main-api down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-authentication-api down
	make -C /home/bizmatesph-joselin/projects/fms/bizmates-finance-app down

start-ls-database-migrations:
	docker compose -f ./ls-database-migrations/docker-compose.yml up -d
stop-ls-database-migrations:
	docker compose -f ./ls-database-migrations/docker-compose.yml down

start-gateway:
	docker compose -f ./bizmates-network/docker-compose.yml down
	docker compose -f ./bizmates-network/docker-compose.yml up -d
stop-gateway:
	docker compose -f ./bizmates-network/docker-compose.yml down
