up:
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		up --build --remove-orphans --detach
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		logs

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

sh_pdi: 
	@ docker-compose -f devops/docker-compose.yml --project-name data-engineer-code-challenge  \
		exec pdi bash		