[![Docker push](https://github.com/luizaugustoalves/data-integration-dwh/actions/workflows/docker-push.yml/badge.svg)](https://github.com/luizaugustoalves/data-integration-dwh/actions/workflows/docker-push.yml)
# Data integration for data warehouse

Example of how a structure of a dimensional data warehouse works using the star schema.

---
### Topics

- [Quick-start](#quick-start)
- [Structure](#structure)
- [Star schema](#star-schema)
- [Reports](#reports)
---

---
### Quick-start

Use command below to run the JOB and transformations:
```shell
> make run
```
---
### Structure
```text
├── data          // Data sources
├── devops        // Docker related files
├── dwh           // Data warehouse scripts
├── jobs          // ETL's and Job files of pentaho
├── report        // Files related to data visualization
└── Makefile      // Commands make up, make logs...
```
---

### Star schema
![dwh_star_schema](https://user-images.githubusercontent.com/94723103/143041766-4287cf34-da4c-450c-bec9-be4fd12c3d03.png)  
In this modeling, the center of the star is a `fact_event_user` fact table and three associated dimension tables: `dim_events_type`, `dim_regions` and `dim_users`.  

---  

### ETL - Extract, Transform and Load  
Using the Pentaho Data Integration (PDI) component of the Pentaho suite.  

#### dimension_load.ktr - responsible for loading data into dimension tables.
![etl_dimensions_load](https://user-images.githubusercontent.com/94723103/142977580-62e0cb66-0c3e-4a08-aa31-0f806b12a1e2.JPG)  

#### fact_events_user.ktr - responsible for loading data into fact table.
![etl_fact_event_user_load](https://user-images.githubusercontent.com/94723103/142978059-6445fade-532a-456d-9359-f1df67a00f27.JPG)  

---

### Reports
A report was developed in Power BI for data visualization.  
#### Prerequisite  
- Install Power BI Desktop - [download here](https://powerbi.microsoft.com/pt-br/downloads/)
#### Instructions  
1. Launch Power BI Desktop
2. Click in menu **File/Open report** and find the `reports.pbix` file located in the `/reports` folder
3. After the previous step, it is already possible to view the reports. They were separated into tabs. If you want to update the data click on button **Refresh**.
4. In the report on tab 4#, there is a visual component called **Azure Map**. It is not enabled by default in Power BI. To enable it, go to the menu **File/Options and settings/Options/Preview features** and check the option **Azure map visual**. It is necessary to restart the Power BI Desktop.  
  
*If request host, database, database user and password, use the following, respectively:*
```text
localhost:3300
dwh
postgres
postgres
```

It is also possible to view the reports through the file `/reports/reports.pdf` ([here](report/reports.pdf))

Or we may also have similar results with the queries below:  
```sql
# Users who are not in any region
SELECT 
  COUNT(1) QUANTITY 
FROM FACT_EVENT_USER
LEFT JOIN DIM_REGIONS ON DIM_REGIONS.ID = FACT_EVENT_USER.DIM_REGIONS_ID 
LEFT JOIN DIM_USERS ON DIM_USERS.ID = FACT_EVENT_USER.DIM_USERS_ID 
WHERE FACT_EVENT_USER.DIM_REGIONS_ID IS NULL;
```

```sql
# Number of markers in each region
SELECT 
  DIM_REGIONS."NAME",
  COUNT(1) QUANTITY
FROM DIM_MARKERS, DIM_REGIONS
# Filters the regions that have markers within their area, using the ST_INTERSECTS() function.
# Unlike ST_CONTAINS(), the function ST_INTERSECTS() also considers the markers that are on the edge of the polygon.
WHERE ST_INTERSECTS(ST_SETSRID(DIM_MARKERS.POINT::GEOMETRY, 4326), ST_SETSRID(DIM_REGIONS."LOCATION"::GEOMETRY, 4326)) 
GROUP BY DIM_REGIONS."NAME"
ORDER BY 2 DESC; 
```

```sql
# Regions with the highest number of users
SELECT 
  DIM_REGIONS."NAME",
  COUNT(DISTINCT DIM_USERS) QUANTITY
FROM FACT_EVENT_USER
JOIN DIM_REGIONS ON DIM_REGIONS.ID = FACT_EVENT_USER.DIM_REGIONS_ID 
JOIN DIM_USERS ON DIM_USERS.ID = FACT_EVENT_USER.DIM_USERS_ID 
GROUP BY DIM_REGIONS.ID
ORDER BY 2 DESC
LIMIT 7;
```
