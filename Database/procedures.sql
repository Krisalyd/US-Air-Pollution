CREATE OR REPLACE PROCEDURE stage.data_staging(
	)
LANGUAGE 'sql'
AS $BODY$

TRUNCATE TABLE stage.dim_address;

INSERT INTO stage.dim_address (site_num, address, city) 
SELECT DISTINCT site_num, address, city FROM stage.air_pollution_file;

TRUNCATE TABLE stage.dim_county;

INSERT INTO stage.dim_county (county_code, county_name)
SELECT DISTINCT county_code, county FROM stage.air_pollution_file;

TRUNCATE TABLE stage.dim_date;

INSERT INTO stage.dim_date (date_id, date)
SELECT DISTINCT TRANSLATE(date_local, '-', ''), date_local FROM stage.air_pollution_file;

TRUNCATE TABLE stage.dim_state;

INSERT INTO stage.dim_state (state_code, state_name)
SELECT DISTINCT state_code, state_name FROM stage.air_pollution_file;

TRUNCATE TABLE stage.fact_air_pollution;

INSERT INTO stage.fact_air_pollution (air_poll_id
				     ,state_code
				     ,county_code
				     ,site_num
				     ,date
				     ,no2_units
				     ,no2_mean
				     ,no2_1st_max_value
				     ,no2_1st_max_hour
				     ,no2_aqi
				     ,o3_units
				     ,o3_mean
				     ,o3_1st_max_value
				     ,o3_1st_max_hour
				     ,o3_aqi
				     ,so2_units
				     ,so2_mean
				     ,so2_1st_max_value
				     ,so2_1st_max_hour
				     ,so2_aqi
				     ,co_units
				     ,co_mean
				     ,co_1st_max_value
				     ,co_1st_max_hour
				     ,co_aqi
				     )
SELECT 
	air_poll_id
	,state_code
	,county_code
	,site_num
	,TRANSLATE(date_local, '-', '')
	,no2_units
	,no2_mean
	,no2_1st_max_value
	,no2_1st_max_hour
	,no2_aqi
	,o3_units
	,o3_mean
	,o3_1st_max_value
	,o3_1st_max_hour
	,o3_aqi
	,so2_units
	,so2_mean
	,so2_1st_max_value
	,so2_1st_max_hour
	,so2_aqi
	,co_units
	,co_mean
	,co_1st_max_value
	,co_1st_max_hour
	,co_aqi
FROM stage.air_pollution_file;

$BODY$;


CREATE OR REPLACE PROCEDURE dw.data_warehousing(
	)
LANGUAGE 'sql'
AS $BODY$

TRUNCATE TABLE dw.dim_address CASCADE;

INSERT INTO dw.dim_address (site_num, address, city) 
SELECT CAST(site_num AS bigint), address, city FROM stage.dim_address;

TRUNCATE TABLE dw.dim_county CASCADE;

INSERT INTO dw.dim_county (county_code, county_name)
SELECT CAST(county_code AS int), county_name FROM stage.dim_county;

TRUNCATE TABLE dw.dim_date CASCADE;

INSERT INTO dw.dim_date (date_id, date)
SELECT CAST(date_id AS int), date FROM stage.dim_date;

TRUNCATE TABLE dw.dim_state CASCADE;

INSERT INTO dw.dim_state (state_code, state_name)
SELECT CAST(state_code AS int), state_name FROM stage.dim_state;

TRUNCATE TABLE  dw.fact_air_pollution CASCADE;

INSERT INTO dw.fact_air_pollution (air_poll_id
									 ,state_code
									 ,county_code
									 ,site_num
									 ,date
									 ,no2_units
									 ,no2_mean
									 ,no2_1st_max_value
									 ,no2_1st_max_hour
									 ,no2_aqi
									 ,o3_units
									 ,o3_mean
									 ,o3_1st_max_value
									 ,o3_1st_max_hour
									 ,o3_aqi
									 ,so2_units
									 ,so2_mean
									 ,so2_1st_max_value
									 ,so2_1st_max_hour
									 ,so2_aqi
									 ,co_units
									 ,co_mean
									 ,co_1st_max_value
									 ,co_1st_max_hour
									 ,co_aqi
									 )
SELECT 
	ROW_NUMBER() OVER (ORDER BY CAST(state_code AS int))
	,CAST(state_code AS int) 
	,CAST(county_code AS int)
	,CAST(site_num AS bigint)
	,CAST(date AS int)
	,no2_units
	,CAST(no2_mean AS numeric(10,6))
	,CAST(no2_1st_max_value AS numeric(10,2))
	,CAST(no2_1st_max_hour AS numeric(10,2))
	,CAST(no2_aqi AS numeric(10,2))
	,o3_units
	,CAST(o3_mean AS numeric(10,6))
	,CAST(o3_1st_max_value AS numeric(10,2))
	,CAST(o3_1st_max_hour AS numeric(10,2))
	,CAST(o3_aqi AS numeric(10,2))
	,so2_units
	,CAST(so2_mean AS numeric(10,6))
	,CAST(so2_1st_max_value AS numeric(10,2))
	,CAST(so2_1st_max_hour AS numeric(10,2))
	,CAST(so2_aqi AS numeric(10,2))
	,co_units
	,CAST(co_mean AS numeric(10,6))
	,CAST(co_1st_max_value AS numeric(10,2))
	,CAST(co_1st_max_hour AS numeric(10,2))
	,CAST(co_aqi AS numeric(10,2))
FROM stage.fact_air_pollution
where so2_aqi <> ''
	AND co_aqi <> '';

$BODY$;
