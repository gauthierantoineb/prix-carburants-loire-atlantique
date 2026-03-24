CREATE OR REPLACE VIEW `my-project-carburants-490512.Carburants.stg_carburants_44` AS
SELECT
  id_station,
  code_postal,
  adresse,
  ville,
  code_departement,
  geom,

  -- Extraction latitude / longitude depuis "lat, long"
  SAFE_CAST(TRIM(SPLIT(geom, ',')[OFFSET(0)]) AS FLOAT64) AS latitude,
  SAFE_CAST(TRIM(SPLIT(geom, ',')[OFFSET(1)]) AS FLOAT64) AS longitude,

  -- Cast des prix en FLOAT64
  SAFE_CAST(prix_gazole AS FLOAT64) AS prix_gazole,
  SAFE_CAST(prix_sp95 AS FLOAT64) AS prix_sp95,
  SAFE_CAST(prix_e85 AS FLOAT64) AS prix_e85,
  SAFE_CAST(prix_e10 AS FLOAT64) AS prix_e10,
  SAFE_CAST(prix_sp98 AS FLOAT64) AS prix_sp98

FROM `my-project-carburants-490512.Carburants.Carburants`
WHERE code_departement = '44';
