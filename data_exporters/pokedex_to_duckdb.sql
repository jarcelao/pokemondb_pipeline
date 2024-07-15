-- Docs: https://docs.mage.ai/guides/sql-blocks

DROP TABLE IF EXISTS fact_stats;
DROP TABLE IF EXISTS dim_type;
DROP TABLE IF EXISTS dim_pokemon;

DROP SEQUENCE IF EXISTS type_id;
CREATE SEQUENCE type_id;

CREATE TABLE dim_pokemon (
  internal_pokemon_id INT PRIMARY KEY,
  pokemon_id INT,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE fact_stats (
  internal_pokemon_id INT PRIMARY KEY REFERENCES dim_pokemon(internal_pokemon_id),
  total INT,
  hp INT,
  attack INT,
  defense INT,
  sp_atk INT,
  sp_def INT,
  speed INT,
);

CREATE TABLE dim_type (
  id INT PRIMARY KEY DEFAULT nextval('type_id'),
  internal_pokemon_id INT REFERENCES dim_pokemon(internal_pokemon_id),
  type VARCHAR(255) NOT NULL
);

INSERT INTO dim_pokemon
    SELECT
        pokedex.internal_id,
        pokedex.id,
        pokedex._name 
    FROM {{ df_1 }} AS pokedex;

INSERT INTO fact_stats
    SELECT 
        pokedex.internal_id,
        pokedex.total,
        pokedex.hp,
        pokedex.attack,
        pokedex.defense,
        pokedex.sp__atk,
        pokedex.sp__def,
        pokedex.speed 
    FROM {{ df_1 }} AS pokedex;

WITH 
    type1 AS (
        SELECT 
            pokedex.internal_id AS internal_pokemon_id,
            pokedex.type1 AS type
        FROM {{ df_1 }} AS pokedex
    ),
    type2 AS (
        SELECT
            pokedex.internal_id AS internal_pokemon_id,
            pokedex.type2 AS type
        FROM {{ df_1 }} AS pokedex
        WHERE type2 IS NOT NULL
    )
INSERT INTO dim_type (internal_pokemon_id, type)
    SELECT * FROM type1
    UNION ALL
    SELECT * FROM type2;

EXPORT DATABASE 'pokemondb_pipeline/sql_export';