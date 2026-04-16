# Optimisation des prix carburants en Loire-Atlantique

Projet de **Data Analytics / BI** réalisé avec **Google Sheets, BigQuery, SQL et Looker Studio** à partir de données open data sur les stations-service.

L’objectif du projet est de transformer un flux open data brut en **outil d’aide à la décision** permettant d’identifier les stations-service les plus intéressantes selon un compromis simple et concret :

- **le prix du carburant**
- **la distance depuis un point de référence fixé à Nantes centre**

---

## Vue d’ensemble

Comparer uniquement les prix affichés à la pompe ne suffit pas toujours pour prendre une bonne décision.

Pour un utilisateur situé à Nantes ou à proximité, une station légèrement moins chère mais très éloignée n’est pas forcément la meilleure option. À l’inverse, une station proche avec un prix compétitif peut représenter un meilleur compromis réel.

Ce projet vise donc à répondre à une question simple :

> **Comment aider un utilisateur à trouver rapidement où faire le plein au meilleur prix, tout en tenant compte d’une contrainte de distance ?**

Pour cela, j’ai construit un pipeline analytique complet :
- simplification initiale du dataset dans Google Sheets
- modélisation et enrichissement dans BigQuery
- contrôles qualité
- calcul de distances géographiques
- création d’un dashboard interactif dans Looker Studio

---

## Résumé exécutif

Ce projet montre qu’un dataset open data brut peut être transformé en un outil d’aide à la décision concret et exploitable.

Trois enseignements principaux ressortent :

- une simple comparaison de prix devient beaucoup plus utile lorsqu’elle est enrichie par une logique **prix + distance** ;
- une structuration en couches analytiques permet de passer d’un flux brut peu lisible à une base fiable pour le reporting ;
- un dashboard filtrable par carburant et distance permet d’identifier rapidement les stations les plus intéressantes dans un périmètre donné.

---

## Contexte métier

Dans un contexte de hausse ou de volatilité des prix des carburants, un automobiliste ne cherche pas seulement la station la moins chère “en absolu”.

Il cherche plus souvent la station :
- suffisamment proche ;
- pertinente pour le carburant recherché ;
- compétitive en prix dans sa zone de déplacement.

Ce projet traite donc un problème de **décision locale et pratique**, avec une logique d’optimisation simple du type :

**minimiser le prix sans ignorer la distance.**

---

## Question business

> **Quelles stations-service de Loire-Atlantique offrent le meilleur compromis entre prix du carburant et proximité depuis Nantes centre ?**

---

## Décision à éclairer

Cette analyse vise à aider à répondre à une décision de type :

- où faire le plein selon le carburant recherché ;
- quelles stations sont compétitives dans un rayon raisonnable ;
- comment filtrer rapidement les meilleures options selon un besoin utilisateur concret.

---

## Source de données

- **Source** : data.gouv.fr  
- **Dataset** : *Prix des carburants en France – flux instantané*  
- **Périmètre retenu** : **Loire-Atlantique (44)**

---

## Dataset et périmètre analytique

Le dataset initial contient des informations sur les stations-service et plusieurs colonnes de prix par carburant.

### Colonnes retenues dans le MVP
- `id_station`
- `code_postal`
- `adresse`
- `ville`
- `geom`
- `prix_gazole`
- `prix_sp95`
- `prix_e85`
- `prix_e10`
- `prix_sp98`
- `code_departement`

### Grain analytique
Le **grain principal d’analyse** est la **station-service**.

### Population analysée
Le périmètre final utilisé dans le projet contient **175 stations**.

### Point de référence géographique
Les distances sont calculées depuis une **ancre géographique fixée à Nantes centre**.

---

## Stack utilisée

- **Google Sheets**
- **BigQuery**
- **SQL**
- **Looker Studio**

---

## Objectif analytique

Le projet vise à répondre à trois questions principales :

1. **Quelles stations sont les plus compétitives sur un carburant donné ?**
2. **Comment intégrer la distance dans l’évaluation de ces stations ?**
3. **Comment rendre cette information simple à explorer pour un utilisateur final ?**

---

## Démarche analytique

### 1. Préparation initiale dans Google Sheets
J’ai d’abord simplifié le dataset brut dans Google Sheets pour construire une base MVP plus lisible et plus facile à importer dans BigQuery.

Objectifs de cette étape :
- réduire le bruit
- supprimer les colonnes non nécessaires au MVP
- préparer une structure claire pour la suite du traitement

### 2. Modélisation dans BigQuery
J’ai ensuite structuré le projet en plusieurs couches analytiques.

#### `stg_carburants_44`
Cette couche de staging permet :
- de filtrer le dataset sur le département 44 ;
- de parser la colonne `geom` ;
- d’extraire la `latitude` et la `longitude` ;
- de caster les colonnes de prix en `FLOAT64`.

#### `mart_carburants_44_avecGPS`
Cette couche de mart permet :
- de créer une `adresse_complete` ;
- d’ajouter une ancre géographique correspondant à Nantes centre ;
- de calculer la distance entre chaque station et cette ancre.

#### `v_mart_44_long`
Cette vue transforme les prix du format large au format long :
- création de la colonne `carburant`
- création de la colonne `prix`
- structure plus adaptée à un filtrage dynamique dans Looker Studio

### 3. Contrôles qualité
Plusieurs contrôles qualité ont été réalisés :
- unicité des stations
- validation du parsing géographique
- cohérence des coordonnées
- détection de prix aberrants
- couverture des prix par carburant

### 4. Enrichissement géospatial
L’ajout de la distance permet de passer d’une lecture purement descriptive des prix à une lecture plus utile pour la décision.

On ne cherche plus seulement :
- la station la moins chère

mais plutôt :
- la station la plus intéressante dans un périmètre raisonnable

### 5. Dashboard Looker Studio
Le dashboard final permet :
- de filtrer par carburant
- de filtrer par distance
- de visualiser la distribution des prix
- de localiser les stations sur une carte
- d’identifier rapidement les stations les moins chères dans le périmètre sélectionné

---

## Contrôles qualité et résultats de préparation

Les principaux résultats des contrôles qualité sont les suivants :

- **175 stations** sur le périmètre retenu
- **0 doublon**
- **0 coordonnée invalide**
- **0 prix aberrant**
- couverture cohérente selon les carburants

Ces contrôles permettent de fiabiliser la base analytique avant la phase de visualisation.

---

## Résultats du projet

Ce projet m’a permis de construire un pipeline analytique complet allant de la donnée brute à un outil de restitution décisionnel :

- préparation initiale du dataset
- modélisation SQL dans BigQuery
- enrichissement géospatial
- contrôles qualité
- structuration des données pour le reporting
- création d’un dashboard interactif

Le résultat final est un outil qui aide à comparer les stations-service selon une logique plus réaliste que la seule lecture du prix affiché.

---

## Ce que le dashboard permet de faire

Le dashboard final permet à un utilisateur de :

- choisir un carburant donné ;
- restreindre l’analyse à un rayon donné autour de Nantes ;
- repérer les stations les moins chères sur ce périmètre ;
- visualiser les stations sur une carte ;
- explorer la distribution des prix de manière interactive.

---

## Limites du projet

Ce projet présente plusieurs limites importantes :

- les données sont **instantanées** et non historiques ;
- la distance calculée est une **distance théorique** et non une distance routière ;
- la **disponibilité réelle du carburant** n’est pas intégrée dans ce MVP ;
- le périmètre est limité au département de la **Loire-Atlantique**.

En conséquence, ce projet doit être lu comme un **MVP analytique d’aide à la décision**, et non comme un moteur de recommandation complet.

---

## Améliorations possibles

Plusieurs prolongements seraient pertinents :

- ajout d’un **historique journalier** pour suivre l’évolution des prix ;
- création d’un **score prix / distance** ;
- recommandation automatique de la meilleure station dans un rayon donné ;
- intégration d’une logique de distance routière ;
- prise en compte de la disponibilité réelle du carburant.

---

## Compétences démontrées

- préparation et simplification d’un dataset open data
- modélisation analytique en couches
- SQL BigQuery
- parsing géographique
- enrichissement géospatial
- contrôles qualité de données
- transformation wide-to-long
- construction d’un dashboard Looker Studio
- data storytelling orienté décision
- formalisation claire des limites du MVP

---

## Aperçu du dashboard

![Aperçu du dashboard Looker Studio](dashboard/dashboard_final.png)

*Dashboard final : comparaison des stations-service selon le carburant, le prix et la distance depuis Nantes centre.*

## Structure du repository

```text
prix-carburants-loire-atlantique/
│
├── README.md
├── google-sheets/   # préparation initiale du MVP
├── sql/             # requêtes BigQuery
└── dashboard/       # présentation du dashboard
