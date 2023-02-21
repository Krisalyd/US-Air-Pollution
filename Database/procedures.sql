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
