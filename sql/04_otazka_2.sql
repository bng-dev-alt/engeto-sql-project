-- Otázka 2: Kolik litrů mléka a kilogramů chleba si lze koupit za první a poslední srovnatelné období?
-- Používá se celostátní průměrná mzda (všechna odvětví) a první a poslední rok v tabulce.
-- Mléko = 114201 (litr), chléb = 111301 (kg).

SELECT
    rok,
    kategorie_nazev,
    kategorie_jednotka,
    prumerna_mzda_kc,
    prumerna_cena_kc,
    ROUND(prumerna_mzda_kc / prumerna_cena_kc) AS mnozstvi_k_nakupu
FROM data_academy_content.t_michael_benes_project_sql_primary_final
WHERE odvetvi_kod IS NULL
    AND kategorie_kod IN (111301, 114201)
    AND rok IN (
        (SELECT MIN(rok) FROM data_academy_content.t_michael_benes_project_sql_primary_final),
        (SELECT MAX(rok) FROM data_academy_content.t_michael_benes_project_sql_primary_final)
    )
ORDER BY kategorie_nazev, rok;
