# Préparation du dataset dans Google Sheets

## Objectif
Construire une version MVP du dataset avant import dans BigQuery.

## Choix réalisés
J’ai supprimé les colonnes non nécessaires au MVP :
- colonnes JSON
- horaires
- ruptures détaillées
- variables secondaires

## Colonnes conservées
- id_station
- code_postal
- adresse
- ville
- geom
- prix_gazole
- prix_sp95
- prix_e85
- prix_e10
- prix_sp98
- code_departement

## Justification
L’objectif était de conserver uniquement les variables utiles pour :
- identifier les stations
- les localiser
- comparer les prix
- filtrer sur le département 44
