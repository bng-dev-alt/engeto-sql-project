-- Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin ve stejném nebo následujícím roce?
-- Výstup: růst HDP ČR v roce t vedle růstu mezd a cen v roce t a t+1.

WITH rust_hdp AS (
    SELECT
        rok,
        (hdp - LAG(hdp) OVER (ORDER BY rok)) / LAG(hdp) OVER (ORDER BY rok) * 100 AS rust_hdp_pct
    FROM data_academy_content.t_michael_benes_project_sql_secondary_final
    WHERE zeme = 'Czech Republic'
),
ceny AS (
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
    h.rok,
    ROUND(h.rust_hdp_pct::NUMERIC, 2) AS rust_hdp_pct,
    ROUND(rm.rust_mezd_pct, 2) AS rust_mezd_pct,
    ROUND(rc.rust_cen_pct, 2) AS rust_cen_pct,
    ROUND(LEAD(rm.rust_mezd_pct) OVER (ORDER BY h.rok), 2) AS rust_mezd_pct_dalsi_rok,
    ROUND(LEAD(rc.rust_cen_pct) OVER (ORDER BY h.rok), 2) AS rust_cen_pct_dalsi_rok
FROM rust_hdp AS h
LEFT JOIN rust_mezd AS rm
    ON rm.rok = h.rok
LEFT JOIN rust_cen AS rc
    ON rc.rok = h.rok
ORDER BY h.rok;
