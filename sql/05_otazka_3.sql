-- Otázka 3: Která kategorie potravin zdražuje nejpomaleji (nejnižší průměrný meziroční růst v %)?
-- Meziroční změna se počítá jen mezi dvěma po sobě jdoucími roky (některé kategorie nemají všechny roky).

WITH ceny AS (
    SELECT DISTINCT
        rok,
        kategorie_nazev,
        prumerna_cena_kc
    FROM data_academy_content.t_michael_benes_project_sql_primary_final
),
ceny_s_predchozi AS (
    SELECT
        rok,
        kategorie_nazev,
        prumerna_cena_kc,
        LAG(rok) OVER (PARTITION BY kategorie_nazev ORDER BY rok) AS predchozi_rok,
        LAG(prumerna_cena_kc) OVER (PARTITION BY kategorie_nazev ORDER BY rok) AS predchozi_cena_kc
    FROM ceny
),
rust AS (
    SELECT
        kategorie_nazev,
        (prumerna_cena_kc - predchozi_cena_kc) / predchozi_cena_kc * 100 AS rust_pct
    FROM ceny_s_predchozi
    WHERE rok = predchozi_rok + 1
)
SELECT
    kategorie_nazev,
    ROUND(AVG(rust_pct), 2) AS prumerny_rust_pct
FROM rust
GROUP BY kategorie_nazev
ORDER BY prumerny_rust_pct;
