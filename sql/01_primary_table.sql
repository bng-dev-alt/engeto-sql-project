-- Primární tabulka: mzdy a ceny potravin v ČR za společné roky (2006-2018).
-- Jeden řádek = rok x odvětví x kategorie potravin.
-- Řádky bez odvětví (odvetvi_kod IS NULL) jsou celostátní průměr za všechna odvětví.

-- Smaže jen moji vlastní tabulku, aby šel skript spustit znovu.
DROP TABLE IF EXISTS data_academy_content.t_michael_benes_project_sql_primary_final;

CREATE TABLE data_academy_content.t_michael_benes_project_sql_primary_final AS
WITH mzdy AS (
    -- Průměrná hrubá mzda (5958), přepočtená (200), v Kč, průměr ze čtvrtletí.
    SELECT
        cp.payroll_year AS rok,
        cp.industry_branch_code AS odvetvi_kod,
        AVG(cp.value) AS prumerna_mzda_kc
    FROM data_academy_content.czechia_payroll AS cp
    WHERE cp.value_type_code = 5958
        AND cp.calculation_code = 200
        AND cp.unit_code = 200
    GROUP BY cp.payroll_year, cp.industry_branch_code
),
ceny AS (
    -- Průměrná cena kategorie za rok ze všech měření (kraje i celá ČR).
    SELECT
        EXTRACT(YEAR FROM cpr.date_from)::INT AS rok,
        cpr.category_code AS kategorie_kod,
        AVG(cpr.value) AS prumerna_cena_kc
    FROM data_academy_content.czechia_price AS cpr
    GROUP BY EXTRACT(YEAR FROM cpr.date_from)::INT, cpr.category_code
)
SELECT
    m.rok,
    m.odvetvi_kod,
    COALESCE(ib.name, 'Všechna odvětví') AS odvetvi_nazev,
    ROUND(m.prumerna_mzda_kc::NUMERIC, 2) AS prumerna_mzda_kc,
    c.kategorie_kod,
    pc.name AS kategorie_nazev,
    ROUND(c.prumerna_cena_kc::NUMERIC, 2) AS prumerna_cena_kc,
    pc.price_value AS kategorie_mnozstvi,
    pc.price_unit AS kategorie_jednotka
FROM mzdy AS m
JOIN ceny AS c
    ON c.rok = m.rok
JOIN data_academy_content.czechia_price_category AS pc
    ON pc.code = c.kategorie_kod
LEFT JOIN data_academy_content.czechia_payroll_industry_branch AS ib
    ON ib.code = m.odvetvi_kod;
