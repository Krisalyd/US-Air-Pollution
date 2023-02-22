CREATE SCHEMA IF NOT EXISTS stage;

CREATE SCHEMA IF NOT EXISTS dw;

CREATE TABLE IF NOT EXISTS stage.air_pollution_file
(
    air_poll_id text,
    state_code text,
    county_code text,
    site_num text,
    address text,
    state_name text,
    county text,
    city text,
    date_local text,
    no2_units text,
    no2_mean text,
    no2_1st_max_value text,
    no2_1st_max_hour text,
    no2_aqi text,
    o3_units text,
    o3_mean text,
    o3_1st_max_value text,
    o3_1st_max_hour text,
    o3_aqi text,
    so2_units text,
    so2_mean text,
    so2_1st_max_value text,
    so2_1st_max_hour text,
    so2_aqi text,
    co_units text,
    co_mean text,
    co_1st_max_value text,
    co_1st_max_hour text,
    co_aqi text,
    date_added timestamp default now()::timestamp(0)
);

CREATE TABLE IF NOT EXISTS stage.dim_state
(
	state_code text,
	state_name text,
	 date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone
);

CREATE TABLE IF NOT EXISTS stage.dim_county
(
	county_code text,
	county_name text,
	 date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone
);

CREATE TABLE IF NOT EXISTS stage.dim_address
(
	site_num text,
	address text,
	city text,
	 date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone
);

CREATE TABLE IF NOT EXISTS stage.dim_date
(
	date_id text,
	date text,
	 date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone
);

CREATE TABLE IF NOT EXISTS stage.fact_air_pollution
(
	air_poll_id text,
	state_code text,
	county_code text,
	site_num text,
	date text,
	no2_units text,
	no2_mean text,
	no2_1st_max_value text,
	no2_1st_max_hour text,
	no2_aqi text,
	o3_units text,
	o3_mean text,
	o3_1st_max_value text,
	o3_1st_max_hour text,
	o3_aqi text,
	so2_units text,
	so2_mean text,
	so2_1st_max_value text,
	so2_1st_max_hour text,
	so2_aqi text,
	co_units text,
	co_mean text,
	co_1st_max_value text,
	co_1st_max_hour text,
	co_aqi text,
	date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone
	
);

CREATE TABLE IF NOT EXISTS dw.dim_address
(
    site_num bigint NOT NULL,
    address text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone,
    CONSTRAINT dim_address_pkey PRIMARY KEY (site_num)
);

CREATE TABLE IF NOT EXISTS dw.dim_county
(
    county_code integer NOT NULL,
    county_name text COLLATE pg_catalog."default",
    date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone,
    CONSTRAINT dim_county_pkey PRIMARY KEY (county_code)
);

CREATE TABLE IF NOT EXISTS dw.dim_date
(
    date_id integer NOT NULL,
    date text COLLATE pg_catalog."default",
    date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone,
    CONSTRAINT dim_date_pkey PRIMARY KEY (date_id)
);

CREATE TABLE IF NOT EXISTS dw.dim_state
(
    state_code integer NOT NULL,
    state_name text COLLATE pg_catalog."default",
    date_added timestamp without time zone DEFAULT (now())::timestamp(0) without time zone,
    CONSTRAINT dim_state_pkey PRIMARY KEY (state_code)
);

CREATE TABLE IF NOT EXISTS dw.fact_air_pollution
(
    air_poll_id bigint NOT NULL,
    state_code integer NOT NULL,
    county_code integer NOT NULL,
    site_num bigint NOT NULL,
    date integer NOT NULL,
    no2_units text COLLATE pg_catalog."default" NOT NULL,
    no2_mean numeric(10,6) NOT NULL,
    no2_1st_max_value numeric(10,2) NOT NULL,
    no2_1st_max_hour numeric(10,2) NOT NULL,
    no2_aqi numeric(10,2) NOT NULL,
    o3_units text COLLATE pg_catalog."default" NOT NULL,
    o3_mean numeric(10,6) NOT NULL,
    o3_1st_max_value numeric(10,2) NOT NULL,
    o3_1st_max_hour numeric(10,2) NOT NULL,
    o3_aqi numeric(10,2) NOT NULL,
    so2_units text COLLATE pg_catalog."default" NOT NULL,
    so2_mean numeric(10,6) NOT NULL,
    so2_1st_max_value numeric(10,2) NOT NULL,
    so2_1st_max_hour numeric(10,2) NOT NULL,
    so2_aqi numeric(10,2) NOT NULL,
    co_units text COLLATE pg_catalog."default" NOT NULL,
    co_mean numeric(10,6) NOT NULL,
    co_1st_max_value numeric(10,2) NOT NULL,
    co_1st_max_hour numeric(10,2) NOT NULL,
    co_aqi numeric(10,2) NOT NULL,
    date_added timestamp without time zone NOT NULL DEFAULT (now())::timestamp(0) without time zone,
    CONSTRAINT address_fk FOREIGN KEY (site_num)
        REFERENCES dw.dim_address (site_num) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT county_fk FOREIGN KEY (county_code)
        REFERENCES dw.dim_county (county_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT date_fk FOREIGN KEY (date)
        REFERENCES dw.dim_date (date_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT state_fk FOREIGN KEY (state_code)
        REFERENCES dw.dim_state (state_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
