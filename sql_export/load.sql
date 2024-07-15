COPY dim_pokemon FROM 'pokemondb_pipeline/sql_export/dim_pokemon.csv' (FORMAT 'csv', quote '"', delimiter ',', header 1);
COPY pokemondb_process_pokedex_v1 FROM 'pokemondb_pipeline/sql_export/pokemondb_process_pokedex_v_.csv' (FORMAT 'csv', quote '"', delimiter ',', header 1);
COPY dev_pokemondb_process_pokedex_v1 FROM 'pokemondb_pipeline/sql_export/dev_pokemondb_process_pokedex_v_.csv' (FORMAT 'csv', quote '"', delimiter ',', header 1);
COPY dim_type FROM 'pokemondb_pipeline/sql_export/dim_type.csv' (FORMAT 'csv', quote '"', delimiter ',', header 1);
COPY fact_stats FROM 'pokemondb_pipeline/sql_export/fact_stats.csv' (FORMAT 'csv', quote '"', delimiter ',', header 1);
