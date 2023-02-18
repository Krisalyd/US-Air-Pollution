-- Table: stage.air_pollution_file

-- DROP TABLE IF EXISTS stage.air_pollution_file;

CREATE TABLE IF NOT EXISTS stage.air_pollution_file
(
    air_poll_id text COLLATE pg_catalog."default",
    state_code text COLLATE pg_catalog."default",
    county_code text COLLATE pg_catalog."default",
    site_num text COLLATE pg_catalog."default",
    address text COLLATE pg_catalog."default",
    state_name text COLLATE pg_catalog."default",
    county text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    date_local text COLLATE pg_catalog."default",
    no2_units text COLLATE pg_catalog."default",
    no2_mean text COLLATE pg_catalog."default",
    no2_1st_max_value text COLLATE pg_catalog."default",
    no2_1st_max_hour text COLLATE pg_catalog."default",
    no2_aqi text COLLATE pg_catalog."default",
    o3_units text COLLATE pg_catalog."default",
    o3_mean text COLLATE pg_catalog."default",
    o3_1st_max_value text COLLATE pg_catalog."default",
    o3_1st_max_hour text COLLATE pg_catalog."default",
    o3_aqi text COLLATE pg_catalog."default",
    so2_units text COLLATE pg_catalog."default",
    so2_mean text COLLATE pg_catalog."default",
    so2_1st_max_value text COLLATE pg_catalog."default",
    so2_1st_max_hour text COLLATE pg_catalog."default",
    so2_aqi text COLLATE pg_catalog."default",
    co_units text COLLATE pg_catalog."default",
    co_mean text COLLATE pg_catalog."default",
    co_1st_max_value text COLLATE pg_catalog."default",
    co_1st_max_hour text COLLATE pg_catalog."default",
    co_aqi text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stage.air_pollution_file
    OWNER to apol_usr;