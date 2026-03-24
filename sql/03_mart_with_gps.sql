CREATE OR REPLACE TABLE `my-project-carburants-490512.Carburants.mart_carburants_44_avecGPS` AS
WITH anchor AS (
  SELECT
    'Nantes' AS anchor_name,
    47.2184 AS anchor_lat,
    -1.5536 AS anchor_lon
)
SELECT
  s.id_station,
  CONCAT(s.adresse, ', ', s.code_postal, ' ', s.ville) AS adresse_complete,
  s.code_departement,
  s.latitude,
  s.longitude,
  s.prix_gazole,
  s.prix_sp95,
  s.prix_e85,
  s.prix_e10,
  s.prix_sp98,
  a.anchor_name,
  a.anchor_lat,
  a.anchor_lon,
  ST_DISTANCE(
    ST_GEOGPOINT(s.longitude, s.latitude),
    ST_GEOGPOINT(a.anchor_lon, a.anchor_lat)
  ) / 1000.0 AS distance_km
FROM `my-project-carburants-490512.Carburants.stg_carburants_44` s
CROSS JOIN anchor a
WHERE s.latitude IS NOT NULL
  AND s.longitude IS NOT NULL;
