# Průvodní listina: Projekt z Power BI (ENGETO Datová akademie)

Zadání: [PBI Projekt na portálu ENGETO](https://portal.engeto.com/study/1c9fafa1-bff0-4a58-8694-a00583705b7c/project/22e10a3f-ab63-4eac-bdc5-e93d436fa821/assignment)

Cílem projektu je přehledně vizualizovat data z projektu z SQL: jak se v letech 2006 až 2018 vyvíjely průměrné mzdy a ceny potravin v ČR a jak vypadá HDP evropských států.

## Použité tabulky

Data načítám z finálních tabulek z projektu z SQL přes ODBC dotazy v Power Query. Zdrojové tabulky jsem nijak neměnil.

**`MzdyCR`** (13 řádků)

- Celostátní průměrná mzda podle roku. Vychází z řádků s `odvetvi_kod IS NULL` z tabulky `t_michael_benes_project_sql_primary_final`, které v projektu z SQL používám jako průměr za všechna odvětví.

**`Mzdy`**

- Průměrná mzda podle odvětví a roku. Vychází ze stejné tabulky, bez řádků „Všechna odvětví“.

**`Ceny`**

- Průměrná cena podle kategorie potravin a roku, spolu s množstvím a jednotkou. Vychází ze stejné tabulky.

**`HDP`** (585 řádků)

- HDP, GINI a populace evropských států za roky 2006 až 2018 z tabulky `t_michael_benes_project_sql_secondary_final`.

Původní primární tabulka má jeden řádek pro kombinaci roku, odvětví a potraviny. Kdybych s ní pracoval přímo, mzdy by se při sčítání opakovaly pro každou potravinu. Proto jsem z ní mzdy a ceny rozdělil do tří samostatných tabulek.

## Datový model

Čtyři tabulky jsou propojené přes kalkulovanou tabulku `Rok` (2006 až 2018). Vztah je vždy jedna k mnoha podle sloupce `rok`.

- Kalkulovaná tabulka: `Rok`
- Kalkulované sloupce: `Rok[Období]` (2006–2012 a 2013–2018), `Ceny[Cena za jednotku]`
- Hierarchie: `Rok hierarchie` (Období → Rok)
- Míry: `Mzda ČR`, `Mzda ČR růst %`, `Mzda ČR růst 2006–2018 %`, `Mzda ČR vybraný rok`, `Mzda odvětví`, `Průměrná cena`, `Cena růst %`, `Kupní síla`, `HDP na obyvatele`, `HDP růst %`

## Stránky reportu

### 1. Mzdy

Ukazuje, jak se vyvíjely mzdy v ČR a v jednotlivých odvětvích.

- Karta `Mzda ČR vybraný rok` ukazuje mzdu za poslední vybraný rok (bez výběru je to rok 2018, tedy 32 043 Kč).
- Karta `Mzda ČR růst 2006–2018 %` ukazuje růst mezd za celé období (64,0 %).
- Spojnicový graf zobrazuje průměrnou mzdu v čase, pruhový graf mzdy podle odvětví.
- Průřezy `Rok` a `Odvětví` filtrují celou stránku.

### 2. Ceny potravin

Ukazuje vývoj cen jednotlivých kategorií potravin.

- Spojnicový graf zobrazuje průměrnou cenu v čase.
- Matice zobrazuje průměrnou cenu každé potraviny za každý rok.
- Karta ukazuje průměrnou cenu za aktuální výběr.
- Průřezy `Potravina` a `Rok` filtrují celou stránku.

### 3. Evropa

Porovnává HDP na obyvatele evropských států.

- Stromová mapa zobrazuje HDP na obyvatele podle zemí.
- Spojnicový graf zobrazuje HDP na obyvatele v čase.

Mezi stránkami se přepíná navigátorem stránek. Vizuály se vzájemně filtrují (klik na prvek v grafu nebo na průřez).

## Poznámky k datům a omezení

- Období: mzdy i ceny jsou dostupné pro roky 2006 až 2018, stejně jako v projektu z SQL.
- Víno bílé má ceny jen za 4 roky, ostatní kategorie za všech 13. V grafech cen a v matici je u něj proto méně hodnot.
- Cena je průměr všech měření dané kategorie za rok, tedy krajských i celorepublikových. Průměr přes více kategorií je jednoduchý průměr bez vah podle spotřeby.
- Míra `Mzda ČR vybraný rok` vrací text (například „32 043 Kč“), aby se na kartě zobrazila celá částka bez zkrácení na „32 tis.“. Nelze ji proto použít v grafech.
- `HDP na obyvatele` je podíl součtu HDP a součtu populace. Pokud není vybraný jeden rok, počítá se přes všechny roky najednou.
- V tabulce `HDP` chybí část hodnot HDP a GINI u některých evropských zemí (podrobnosti jsou v průvodní listině k projektu z SQL).
- Místo mapy jsem použil stromovou mapu, protože mapové vizuály jsou v Power BI Desktop ve výchozím nastavení vypnuté.
- Míra `Kupní síla` je v modelu připravená, ale v reportu nemá vlastní stránku.
