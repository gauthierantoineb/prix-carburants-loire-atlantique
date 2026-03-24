-- Aperçu rapide
SELECT *
FROM `my-project-carburants-490512.Carburants.stg_carburants_44`
LIMIT 10;

-- Test d'unicité
SELECT
  COUNT(*) AS nb_lignes,
  COUNT(DISTINCT id_station) AS nb_stations_uniques,
  COUNT(*) - COUNT(DISTINCT id_station) AS doublons
FROM `my-project-carburants-490512.Carburants.stg_carburants_44`;

-- Test geom
SELECT
  COUNT(*) AS total,
  COUNTIF(latitude IS NULL OR longitude IS NULL) AS nb_geom_invalides
FROM `my-project-carburants-490512.Carburants.stg_carburants_44`;

-- Test bornes géographiques
SELECT
  COUNT(*) AS total,
  COUNTIF(latitude < 46 OR latitude > 48) AS lat_hors_plage,
  COUNTIF(longitude < -3.5 OR longitude > 0.5) AS lon_hors_plage
FROM `my-project-carburants-490512.Carburants.stg_carburants_44`;

-- Couverture des prix par carburant
SELECT
  COUNT(*) AS total,
  ROUND(100 * COUNTIF(prix_gazole IS NOT NULL) / COUNT(*), 1) AS pct_gazole,
  ROUND(100 * COUNTIF(prix_sp95 IS NOT NULL) / COUNT(*), 1) AS pct_sp95,
  ROUND(100 * COUNTIF(prix_e10 IS NOT NULL) / COUNT(*), 1) AS pct_e10,
  ROUND(100 * COUNTIF(prix_sp98 IS NOT NULL) / COUNT(*), 1) AS pct_sp98,
  ROUND(100 * COUNTIF(prix_e85 IS NOT NULL) / COUNT(*), 1) AS pct_e85
FROM `my-project-carburants-490512.Carburants.stg_carburants_44`;

-- Prix aberrants
SELECT
  COUNTIF(prix_gazole <= 0 OR prix_gazole > 3) AS aberrant_gazole,
  COUNTIF(prix_sp95 <= 0 OR prix_sp95 > 3) AS aberrant_sp95,
  COUNTIF(prix_e10 <= 0 OR prix_e10 > 3) AS aberrant_e10,
  COUNTIF(prix_sp98 <= 0 OR prix_sp98 > 3) AS aberrant_sp98,
  COUNTIF(prix_e85 <= 0 OR prix_e85 > 3) AS aberrant_e85
FROM `my-project-carburants-490512.Carburants.stg_carburants_44`;
