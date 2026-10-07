# Projekt z Power BI: mzdy a ceny potravin v ČR

Projekt jsem zpracoval v rámci ENGETO Datové akademie. Vizualizuji v něm data z [projektu z SQL](../README.md): vývoj průměrných mezd a cen základních potravin v ČR v letech 2006 až 2018 a HDP evropských států.

Popis dat, datového modelu a stránek reportu je v [PRUVODNI_LISTINA.md](PRUVODNI_LISTINA.md).

## Soubory

- `projekt_pbi_michael_benes.pbix` – report o třech stránkách (Mzdy, Ceny potravin, Evropa)
- `PRUVODNI_LISTINA.md` – obsahuje popis dat, datový model, popis stránek a omezení

## Jak otevřít

Report je určený pro Power BI Desktop (Windows). Data jsou v souboru uložená (režim Import), takže se po otevření není nutné nikam připojovat.

Pokud chceš data aktualizovat, potřebuješ přístup k databázi ENGETO Datové akademie a ODBC ovladač PostgreSQL (`PostgreSQL Unicode`). Dotazy v Power Query čtou jen z finálních tabulek z projektu z SQL, zdrojová data se nijak neupravují.

## Poznámky k datům

Omezení a rozhodnutí použitá při tvorbě reportu jsou popsaná v [PRUVODNI_LISTINA.md](PRUVODNI_LISTINA.md) v části „Poznámky k datům a omezení“.
