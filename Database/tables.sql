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
