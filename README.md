# Projekt z SQL: dostupnost potravin a mzdy v ČR

Projekt jsem zpracoval v rámci ENGETO Datové akademie. Porovnávám v něm průměrné mzdy a ceny základních potravin v ČR v letech 2006 až 2018. Součástí jsou také data o HDP, GINI a populaci evropských států.

Odpovědi na jednotlivé výzkumné otázky jsou v [PRUVODNI_LISTINA.md](PRUVODNI_LISTINA.md).

## Soubory

- `sql/01_primary_table.sql` – vytvoří `t_michael_benes_project_sql_primary_final` s daty o mzdách a cenách v ČR za roky 2006 až 2018
- `sql/02_secondary_table.sql` – vytvoří `t_michael_benes_project_sql_secondary_final` s daty o HDP, GINI a populaci evropských států
- `sql/03_otazka_1.sql` – zjišťuje, ve kterých odvětvích a letech mzdy klesaly
- `sql/04_otazka_2.sql` – počítá, kolik litrů mléka a kilogramů chleba lze koupit za první a poslední rok
- `sql/05_otazka_3.sql` – hledá kategorii potravin, která zdražuje nejpomaleji
- `sql/06_otazka_4.sql` – hledá rok, kdy ceny rostly o více než 10 p. b. rychleji než mzdy
- `sql/07_otazka_5.sql` – porovnává vliv HDP na mzdy a ceny ve stejném a následujícím roce
- `PRUVODNI_LISTINA.md` – obsahuje odpovědi na otázky, popis dat a omezení

## Jak spustit

Skripty jsou určené pro PostgreSQL a pracují se schématem `data_academy_content` v databázi ENGETO Datové akademie.

Nejdřív je potřeba spustit `01_primary_table.sql` a `02_secondary_table.sql`. V každém souboru se nejdřív spustí `DROP TABLE IF EXISTS` a potom `CREATE TABLE`, v DBeaveru každý příkaz zvlášť (`Cmd+Enter`).

Názvy finálních tabulek jsou v databázi malými písmeny (`project_sql`), protože PostgreSQL převádí nezapsané identifikátory na malá písmena.

Skripty `03` až `07` potom pracují už jen s těmito dvěma finálními tabulkami a lze je spouštět v libovolném pořadí.

`DROP TABLE IF EXISTS` maže pouze finální tabulky tohoto projektu. Zdrojová data se nijak neupravují.

## Poznámky k datům

Chybějící hodnoty, omezení a rozhodnutí použitá při výpočtech jsou popsaná v [PRUVODNI_LISTINA.md](PRUVODNI_LISTINA.md) v části „Poznámky k datům a omezení“.

## Projekt z Power BI

Navazující vizualizace dat v Power BI je ve složce [power-bi](power-bi/README.md).
