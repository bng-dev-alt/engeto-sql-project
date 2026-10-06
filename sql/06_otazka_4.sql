-- Otázka 4: Existuje rok, ve kterém byl meziroční růst cen potravin o více než 10 % vyšší než růst mezd?
-- Růst cen = průměr meziročních změn všech kategorií, růst mezd = změna celostátní průměrné mzdy.
-- Výstup ukazuje všechny roky, rozdíl v procentních bodech je ve sloupci rozdil_pb.

WITH ceny AS (
    SELECT DISTINCT
        rok,
        kategorie_kod,
        prumerna_cena_kc
    FROM data_academy_content.t_michael_benes_project_sql_primary_final
),
ceny_s_predchozi AS (
    SELECT
        rok,
        prumerna_cena_kc,
        LAG(rok) OVER (PARTITION BY kategorie_kod ORDER BY rok) AS predchozi_rok,
        LAG(prumerna_cena_kc) OVER (PARTITION BY kategorie_kod ORDER BY rok) AS predchozi_cena_kc
    FROM ceny
),
rust_cen AS (
    SELECT
        rok,
        AVG((prumerna_cena_kc - predchozi_cena_kc) / predchozi_cena_kc * 100) AS rust_cen_pct
    FROM ceny_s_predchozi
    WHERE rok = predchozi_rok + 1
    GROUP BY rok
),
mzdy AS (
    SELECT DISTINCT
        rok,
        prumerna_mzda_kc
    FROM data_academy_content.t_michael_benes_project_sql_primary_final
    WHERE odvetvi_kod IS NULL
),
rust_mezd AS (
    SELECT
        rok,
        (prumerna_mzda_kc - LAG(prumerna_mzda_kc) OVER (ORDER BY rok))
            / LAG(prumerna_mzda_kc) OVER (ORDER BY rok) * 100 AS rust_mezd_pct
    FROM mzdy
)
SELECT
    rc.rok,
    ROUND(rc.rust_cen_pct, 2) AS rust_cen_pct,
    ROUND(rm.rust_mezd_pct, 2) AS rust_mezd_pct,
    ROUND(rc.rust_cen_pct - rm.rust_mezd_pct, 2) AS rozdil_pb
FROM rust_cen AS rc
JOIN rust_mezd AS rm
    ON rm.rok = rc.rok
ORDER BY rc.rok;
