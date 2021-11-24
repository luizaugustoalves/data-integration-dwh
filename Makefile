run:
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		up --build --remove-orphans --detach
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		logs -f pdi

logs:
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		logs -f

logs_database:
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		logs -f database

logs_dwh:
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		logs -f	dwh	

logs_pdi:
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		logs -f pdi

sh: 
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		exec database sh

bash_pdi: 
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		exec pdi bash		

docker_push:
    cd ./devops/data-integration
	docker build -t luizaugustobr/pentaho-pdi:$(image_tag) -t luizaugustobr/pentaho-pdi:latest .
	docker push luizaugustobr/pentaho-pdi --all-tags