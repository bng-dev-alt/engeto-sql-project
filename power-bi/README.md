# Projekt z Power BI: mzdy a ceny potravin v ČR

Report vizualizuje data z [projektu z SQL](../README.md): vývoj mezd a cen potravin v ČR v letech 2006 až 2018 a HDP evropských států.

Soubor: [projekt_pbi_michael_benes.pbix](projekt_pbi_michael_benes.pbix). K otevření je potřeba Power BI Desktop. Data jsou v souboru uložená (režim Import), takže se po otevření není nutné nikam připojovat.

## Zdroj dat

Data pocházejí z finálních tabulek z projektu z SQL v databázi ENGETO Datové akademie. Načítám je přes ODBC dotazy v Power Query:

- `MzdyCR`: celostátní průměrná mzda podle roku
- `Mzdy`: průměrná mzda podle odvětví a roku
- `Ceny`: průměrná cena potravin podle kategorie a roku
- `HDP`: HDP, GINI a populace evropských států

Tabulky `MzdyCR`, `Mzdy` a `Ceny` vznikly z `t_michael_benes_project_sql_primary_final` (jeden řádek původní tabulky je kombinace roku, odvětví a potraviny, takže mzdy a ceny jsem oddělil, aby se při sčítání neopakovaly). Tabulka `HDP` je z `t_michael_benes_project_sql_secondary_final`.

## Datový model

Čtyři tabulky jsou propojené přes kalkulovanou tabulku `Rok` (2006 až 2018), vztah je jedna k mnoha podle sloupce `rok`.

- Kalkulovaná tabulka: `Rok`
- Kalkulované sloupce: `Rok[Období]` (2006–2012 a 2013–2018), `Ceny[Cena za jednotku]`
- Hierarchie: `Rok hierarchie` (Období → Rok)
- Míry: `Mzda ČR`, `Mzda ČR růst %`, `Mzda ČR růst 2006–2018 %`, `Mzda ČR vybraný rok`, `Mzda odvětví`, `Průměrná cena`, `Cena růst %`, `Kupní síla`, `HDP na obyvatele`, `HDP růst %`

## Stránky reportu

1. **Mzdy**: karta s mzdou za vybraný rok, karta s růstem 2006–2018, spojnicový graf mzdy v čase, pruhový graf podle odvětví, průřezy Rok a Odvětví.
2. **Ceny potravin**: spojnicový graf průměrné ceny, matice potravina × rok, karta s průměrnou cenou, průřezy Potravina a Rok.
3. **Evropa**: stromová mapa HDP na obyvatele podle zemí a spojnicový graf HDP na obyvatele v čase.

Mezi stránkami se přepíná navigátorem stránek. Vizuály se vzájemně filtrují (klik na prvek v grafu nebo na průřez).

## Poznámky

- Místo mapy používám stromovou mapu, protože mapové vizuály jsou v Power BI Desktop ve výchozím nastavení vypnuté.
- Míra `Kupní síla` je v modelu, ale nemá vlastní stránku v reportu.
- Pro roky 2006 až 2018 jsou mzdy i ceny dostupné ve všech letech, jen bílé víno má ceny pouze za 4 roky (stejně jako v projektu z SQL).
