CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE dim_markers (
    id SERIAL PRIMARY KEY NOT NULL,
    natural_key VARCHAR(80), 
    "point" point
);

CREATE TABLE dim_users (
    id SERIAL PRIMARY KEY NOT NULL,
    natural_key VARCHAR(80),
    "username" VARCHAR(255),
    phone VARCHAR(45)
);

CREATE TABLE dim_regions (
    id SERIAL PRIMARY KEY NOT NULL,
    natural_key VARCHAR(80),
    "name" VARCHAR(255),
    "location" GEOGRAPHY(POLYGON, 4326)
);

CREATE TABLE dim_events_type (
    id SERIAL PRIMARY KEY NOT NULL,
    natural_key VARCHAR(80),
    "name" VARCHAR(255)
);

INSERT INTO dim_events_type (name) VALUES ('Cadastro de usuário');

CREATE TABLE fact_event_user (
    id SERIAL PRIMARY KEY NOT NULL,
    natural_key VARCHAR(80),
    "point" point,
    dim_events_type_id  int,
    dim_users_id int,
    dim_regions_id int,
    FOREIGN KEY (dim_events_type_id) REFERENCES dim_events_type (id),
    FOREIGN KEY (dim_users_id) REFERENCES dim_users (id),
    FOREIGN KEY (dim_regions_id) REFERENCES dim_regions(id)
);