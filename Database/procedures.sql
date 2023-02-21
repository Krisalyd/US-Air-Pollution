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

$BODY$;
