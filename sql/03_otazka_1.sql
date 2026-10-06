-- Otázka 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
-- Výstup: odvětví a roky, ve kterých mzda oproti předchozímu roku klesla.

WITH mzdy AS (
    SELECT DISTINCT
        rok,
        odvetvi_nazev,
        prumerna_mzda_kc
    FROM data_academy_content.t_michael_benes_project_sql_primary_final
    WHERE odvetvi_kod IS NOT NULL
),
mzdy_s_predchozi AS (
    SELECT
        rok,
        odvetvi_nazev,
        prumerna_mzda_kc,
        LAG(prumerna_mzda_kc) OVER (PARTITION BY odvetvi_nazev ORDER BY rok) AS predchozi_mzda_kc
    FROM mzdy
)
SELECT
    odvetvi_nazev,
    rok,
    predchozi_mzda_kc,
    prumerna_mzda_kc,
    ROUND((prumerna_mzda_kc - predchozi_mzda_kc) / predchozi_mzda_kc * 100, 2) AS zmena_pct
FROM mzdy_s_predchozi
WHERE prumerna_mzda_kc < predchozi_mzda_kc
ORDER BY odvetvi_nazev, rok;


-- Dlouhodobý pohled: mzda v prvním a posledním roce podle odvětví.
WITH mzdy AS (
    SELECT DISTINCT
        rok,
        odvetvi_nazev,
        prumerna_mzda_kc
    FROM data_academy_content.t_michael_benes_project_sql_primary_final
    WHERE odvetvi_kod IS NOT NULL
)
SELECT
    m1.odvetvi_nazev,
    m1.prumerna_mzda_kc AS mzda_prvni_rok_kc,
    m2.prumerna_mzda_kc AS mzda_posledni_rok_kc,
    ROUND((m2.prumerna_mzda_kc - m1.prumerna_mzda_kc) / m1.prumerna_mzda_kc * 100, 2) AS zmena_pct
FROM mzdy AS m1
JOIN mzdy AS m2
    ON m2.odvetvi_nazev = m1.odvetvi_nazev
WHERE m1.rok = (SELECT MIN(rok) FROM mzdy)
    AND m2.rok = (SELECT MAX(rok) FROM mzdy)
ORDER BY zmena_pct;
