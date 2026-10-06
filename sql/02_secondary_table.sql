-- Sekundární tabulka: HDP, GINI a populace evropských států za stejné roky jako primární tabulka.
-- Česká republika je zahrnutá schválně, otázka 5 potřebuje české HDP a smí číst jen z finálních tabulek.

-- Smaže jen moji vlastní tabulku, aby šel skript spustit znovu.
DROP TABLE IF EXISTS data_academy_content.t_michael_benes_project_sql_secondary_final;

CREATE TABLE data_academy_content.t_michael_benes_project_sql_secondary_final AS
SELECT
    e.country AS zeme,
    e.year AS rok,
    e.gdp AS hdp,
    e.gini,
    e.population AS populace
FROM data_academy_content.economies AS e
JOIN data_academy_content.countries AS c
    ON c.country = e.country
WHERE c.continent = 'Europe'
    AND e.year BETWEEN 2006 AND 2018;
