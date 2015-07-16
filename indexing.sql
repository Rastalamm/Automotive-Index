CREATE USER indexed_cars_user;
CREATE DATABASE indexed_cars OWNER indexed_cars_user ENCODING 'utf8';
\i ~/Devleague/Automotive-Index/scripts/car_models.sql
--run the below code 10 times! being done manually
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql
\i ~/Devleague/Automotive-Index/scripts/car_model_data.sql

--Turns timing on
\timing;

SELECT DISTINCT make_title COUNT FROM car_models WHERE make_code = 'LAM'; --20.577
SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'; --20.825
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM'; -- 21.013
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015; --59.619
SELECT * FROM car_models WHERE year = 2010; -- 29.248

--Indexing

CREATE INDEX make_code_idx ON car_models (make_code); --2473.680
CREATE INDEX year_idx ON car_models (year); -- 131.121

--without indexing on creation
SELECT DISTINCT make_title COUNT FROM car_models WHERE make_code = 'LAM'; -- 1.282
SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'; --2.456
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM'; -- 1.704
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015; --47.695
SELECT * FROM car_models WHERE year = 2010; --12.108


--Dropped table and re-created with index
SELECT DISTINCT make_title COUNT FROM car_models WHERE make_code = 'LAM'; -- 1.745, 1.195
SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'; --2.411, 2.204
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM'; --1.757, 0.898
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015; --47.123, 47.746
SELECT * FROM car_models WHERE year = 2010; --12.981, 12.941