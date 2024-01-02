-- Database: EXTENSION postgis

-- DROP DATABASE IF EXISTS "EXTENSION postgis";

CREATE DATABASE "EXTENSION postgis"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
CREATE DATABASE spatial_db;

CREATE EXTENSION postgis;

-- Create a table to store spatial data
CREATE TABLE spatial_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    geom GEOMETRY(Point, 4326) -- Example for a table with point geometry in WGS84 (EPSG:4326) projection
);



-- Insert spatial data into the table
INSERT INTO spatial_table (name, geom) VALUES ('Point A', ST_GeomFromText('POINT(-74.0059 40.7128)', 4326));

-- Retrieve Locations of Specific Features
SELECT * FROM spatial_table WHERE name = 'Point A';

-- Calculate Distance Between Points
SELECT ST_Distance(a.geom, b.geom) AS distance
FROM spatial_table a, spatial_table b
WHERE a.name = 'Point A' AND b.name = 'Point B';

-- Calculate Areas of Interest
SELECT name, ST_Area(geom) AS area
FROM spatial_table
WHERE ST_Area(geom) > 1000; -- Replace 1000 with your desired area threshold


-- Sorting and Limit Executions
SELECT * FROM spatial_table ORDER BY name LIMIT 10;
