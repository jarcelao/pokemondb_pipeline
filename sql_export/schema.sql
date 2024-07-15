

CREATE SEQUENCE type_id INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 2431 NO CYCLE;

CREATE TABLE dim_pokemon(internal_pokemon_id INTEGER PRIMARY KEY, pokemon_id INTEGER, "name" VARCHAR NOT NULL);
CREATE TABLE pokemondb_process_pokedex_v1(id BIGINT, _name VARCHAR, total BIGINT, hp BIGINT, attack BIGINT, defense BIGINT, sp__atk BIGINT, sp__def BIGINT, speed BIGINT, type1 VARCHAR, type2 VARCHAR, internal_id BIGINT);
CREATE TABLE dev_pokemondb_process_pokedex_v1(id BIGINT, _name VARCHAR, total BIGINT, hp BIGINT, attack BIGINT, defense BIGINT, sp__atk BIGINT, sp__def BIGINT, speed BIGINT, type1 VARCHAR, type2 VARCHAR, internal_id BIGINT);
CREATE TABLE dim_type(id INTEGER PRIMARY KEY DEFAULT(nextval('type_id')), internal_pokemon_id INTEGER, "type" VARCHAR NOT NULL, FOREIGN KEY (internal_pokemon_id) REFERENCES dim_pokemon(internal_pokemon_id));
CREATE TABLE fact_stats(internal_pokemon_id INTEGER PRIMARY KEY, total INTEGER, hp INTEGER, attack INTEGER, defense INTEGER, sp_atk INTEGER, sp_def INTEGER, speed INTEGER, FOREIGN KEY (internal_pokemon_id) REFERENCES dim_pokemon(internal_pokemon_id));




