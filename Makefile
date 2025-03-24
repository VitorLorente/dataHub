# Variáveis
DOCKER_COMPOSE = docker compose
POSTGRES_CONTAINER = postgres_db
SQL_SCRIPT = sql/createPsqlReferencias.sql
DB_NAME = referencias
DB_USER = psql_user

# Subir os containers
up:
	$(DOCKER_COMPOSE) up -d

# Derrubar os containers
down:
	$(DOCKER_COMPOSE) down

# Criar o banco de dados e tabelas no PostgreSQL
create_db:
	docker exec -i $(POSTGRES_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME) < $(SQL_SCRIPT)

drop_db:
	$(DOCKER_COMPOSE) down -v  # Derruba os containers e remove os volumes
	$(DOCKER_COMPOSE) up -d --build  # Recria a imagem e sobe os containers
	sleep 5  # Aguarda inicialização do PostgreSQL
	make create_db  # Recria o banco de dados