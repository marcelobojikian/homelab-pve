
encrypt:
	./scripts/encrypt.sh ansible ./files/security/vault.key

decrypt:
	./scripts/decrypt.sh ansible ./files/security/vault.key

build:
	sudo docker build -t homelab-pve:v1 .

run:
	sudo docker run -p 3000:3000 \
	-e SEMAPHORE_DB_DIALECT=bolt \
	-e SEMAPHORE_ADMIN=admin \
	-e SEMAPHORE_ADMIN_PASSWORD=changeme \
	-e SEMAPHORE_ADMIN_NAME=Admin \
	-e SEMAPHORE_ADMIN_EMAIL=admin@localhost \
	--rm --name homelab-pve \
	homelab-pve:v1

it:
	sudo docker exec -it homelab-pve sh

dev-run:

	chmod g+r ansible/group_vars/all/vault.yml
	chmod g+r ansible/group_vars/node/vault.yml
	chmod g+r ansible/group_vars/proxmox/vault.yml

	sudo docker run -p 3000:3000 \
	-v $(shell pwd)/ansible/roles:/opt/ansible/homelab-pve/roles \
	-v $(shell pwd)/ansible/ansible.cfg:/opt/ansible/homelab-pve/ansible.cfg \
	-v $(shell pwd)/ansible/playbook.yml:/opt/ansible/homelab-pve/playbook.yml \
	-e SEMAPHORE_DB_DIALECT=bolt \
	-e SEMAPHORE_ADMIN=admin \
	-e SEMAPHORE_ADMIN_PASSWORD=changeme \
	-e SEMAPHORE_ADMIN_NAME=Admin \
	-e SEMAPHORE_ADMIN_EMAIL=admin@localhost \
	--rm --name homelab-pve \
	homelab-pve:v1
