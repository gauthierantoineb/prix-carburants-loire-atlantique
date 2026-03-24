SELECT
  id_station,
  adresse_complete,
  code_departement,
  latitude,
  longitude,
  anchor_name,
  anchor_lat,
  anchor_lon,
  distance_km,
  'gazole' AS carburant,
  prix_gazole AS prix
FROM `my-project-carburants-490512.Carburants.mart_carburants_44_avecGPS`
WHERE prix_gazole IS NOT NULL

UNION ALL

SELECT
  id_station,
  adresse_complete,
  code_departement,
  latitude,
  longitude,
  anchor_name,
  anchor_lat,
  anchor_lon,
  distance_km,
  'sp95' AS carburant,
  prix_sp95 AS prix
FROM `my-project-carburants-490512.Carburants.mart_carburants_44_avecGPS`
WHERE prix_sp95 IS NOT NULL

UNION ALL

SELECT
  id_station,
  adresse_complete,
  code_departement,
  latitude,
  longitude,
  anchor_name,
  anchor_lat,
  anchor_lon,
  distance_km,
  'e85' AS carburant,
  prix_e85 AS prix
FROM `my-project-carburants-490512.Carburants.mart_carburants_44_avecGPS`
WHERE prix_e85 IS NOT NULL

UNION ALL

SELECT
  id_station,
  adresse_complete,
  code_departement,
  latitude,
  longitude,
  anchor_name,
  anchor_lat,
  anchor_lon,
  distance_km,
  'e10' AS carburant,
  prix_e10 AS prix
FROM `my-project-carburants-490512.Carburants.mart_carburants_44_avecGPS`
WHERE prix_e10 IS NOT NULL

UNION ALL

SELECT
  id_station,
  adresse_complete,
  code_departement,
  latitude,
  longitude,
  anchor_name,
  anchor_lat,
  anchor_lon,
  distance_km,
  'sp98' AS carburant,
  prix_sp98 AS prix
FROM `my-project-carburants-490512.Carburants.mart_carburants_44_avecGPS`
WHERE prix_sp98 IS NOT NULL
