# Průvodní listina: Projekt z SQL (ENGETO Datová akademie)

Zadání: [Projekt z SQL na portálu ENGETO](https://portal.engeto.com/study/1c9fafa1-bff0-4a58-8694-a00583705b7c/project/7165d34a-7a0d-48a1-a6c4-99fb7bd7fb49/assignment)

Cílem projektu je zjistit, jak se v letech 2006 až 2018 vyvíjela dostupnost základních potravin v ČR vzhledem k průměrným mzdám. Součástí je také porovnání s vývojem HDP.

## Použité tabulky

Zdrojové tabulky jsem nijak neměnil. Všechny úpravy probíhají až při vytváření dvou finálních tabulek ve skriptech `01` a `02` a následně v dotazech nad nimi.

**`t_michael_benes_project_sql_primary_final`** (6 840 řádků)

- Jeden řádek představuje kombinaci roku, odvětví a kategorie potravin. Tabulka obsahuje roky 2006 až 2018, tedy společné období pro mzdy a ceny.
- U mezd používám průměrnou hrubou mzdu na zaměstnance (kód 5958), přepočtenou na plné úvazky (kód 200), v Kč. Jde o průměr ze čtyř čtvrtletí.
- Cena je průměr všech měření dané kategorie za rok, tedy krajských i celorepublikových.
- Řádky s `odvetvi_kod IS NULL` používám jako celostátní průměr za všechna odvětví. Ve finální tabulce jsou označené jako „Všechna odvětví“.

**`t_michael_benes_project_sql_secondary_final`** (585 řádků)

- Obsahuje HDP, GINI a populaci evropských států za roky 2006 až 2018, celkem 45 zemí.
- Česká republika je v tabulce záměrně, protože otázka 5 pracuje s českým HDP a skripty mají číst jen z finálních tabulek.

## Odpovědi na výzkumné otázky

### 1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?

Mzdy nerostou každý rok ve všech odvětvích. Za sledované období jsem našel **25 meziročních poklesů** v **16 z 19 odvětví**. Ve třech odvětvích k meziročnímu poklesu nedošlo.

Nejvíc poklesů bylo v roce **2013**, kdy mzdy klesly v 11 odvětvích. Největší pokles byl v Peněžnictví a pojišťovnictví, a to o **8,83 %** (z 50 800,50 Kč na 46 316,50 Kč).

Další poklesy byly v roce 2009 (4 odvětví), 2010 (3), 2011 (4) a po jednom odvětví v letech 2014, 2015 a 2016.

Opakovaně klesaly mzdy například v Těžbě a dobývání (2009, 2013, 2014, 2016), ve Výrobě a rozvodu elektřiny, plynu a tepla (2011, 2013, 2015) a ve Veřejné správě (2010, 2011).

V roce 2011 klesla mzda v Dopravě a skladování pouze o 0,50 Kč (23 062,50 → 23 062,00 Kč). Po zaokrouhlení procentní změny vychází 0,00 %, ale stále jde formálně o pokles.

Ve třech odvětvích (Zpracovatelský průmysl, Zdravotní a sociální péče, Ostatní činnosti) mzdy v žádném roce meziročně neklesly.

Z dlouhodobého pohledu mzdy rostou ve všech odvětvích: každé odvětví má v roce 2018 vyšší mzdu než v roce 2006. Nejméně vzrostla mzda v Peněžnictví a pojišťovnictví (+37,12 %, z 40 027,00 na 54 883,25 Kč), nejvíc ve Zdravotní a sociální péči (+77,84 %, z 19 041,50 na 33 863,25 Kč). Meziroční poklesy jsou tedy jen krátkodobé výkyvy, ne trvalý trend.

### 2. Kolik litrů mléka a kilogramů chleba si lze koupit za první a poslední srovnatelné období?

Výpočet používá celostátní průměrnou mzdu: 19 536 Kč v roce 2006 a 32 043 Kč v roce 2018.

| Potravina | 2006 | 2018 | Změna |
|---|---|---|---|
| Chléb konzumní kmínový (kg) | 1 212 kg (cena 16,12 Kč) | 1 322 kg (cena 24,24 Kč) | +110 kg (+9,1 %) |
| Mléko polotučné pasterované (l) | 1 353 l (cena 14,44 Kč) | 1 617 l (cena 19,82 Kč) | +264 l (+19,5 %) |

V roce 2018 si tedy bylo možné za průměrnou mzdu koupit více chleba i mléka než v roce 2006. Mzdy za toto období rostly rychleji než ceny těchto dvou potravin.

### 3. Která kategorie potravin zdražuje nejpomaleji?

Podle průměrných meziročních procentních změn cen vychází nejníž **cukr krystalový s −1,92 %**, takže v průměru zlevňuje. Rajská jablka červená kulatá mají −0,74 % a také v průměru zlevňují.

Pokud vezmu jen potraviny, které skutečně zdražují, nejpomaleji rostla cena **žlutých banánů (+0,81 %)**. Následuje vepřová pečeně s kostí (+0,99 %) a přírodní minerální voda (+1,02 %).

Nejrychleji zdražovaly papriky (+7,29 %), máslo (+6,67 %) a vejce slepičí čerstvá (+5,55 %).

Pokud otázku beru doslova jako nejnižší procentní nárůst, odpovědí je **cukr krystalový**. Cena jakostního bílého vína je dostupná jen pro 4 roky, takže jeho průměr (+2,70 %) je méně spolehlivý než u ostatních kategorií.

### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (o více než 10 %)?

**Ne.** V žádném roce nebyl rozdíl vyšší než 10 procentních bodů.

Největší rozdíl byl v roce **2013**. Ceny potravin vzrostly o 6,01 %, zatímco celostátní průměrná mzda klesla o 0,13 %. Rozdíl byl **6,14 p. b.** Další nejvyšší rozdíly byly v roce 2012 (4,97 p. b.) a 2011 (2,35 p. b.).

V letech 2009, 2010, 2014, 2015, 2016 a 2018 ceny rostly pomaleji než mzdy nebo klesaly. Největší rozdíl v opačném směru byl v roce 2009, kdy ceny klesly o 6,59 % a mzdy vzrostly o 3,37 %.

Ceny potravin také v žádném roce nevzrostly o více než 10 % (nejvíc o 9,26 % v roce 2007), takže odpověď je stejná i při tomto výkladu otázky.

Růst cen je počítaný jako jednoduchý průměr meziročních změn všech kategorií, takže každá kategorie má stejnou váhu.

### 5. Má výška HDP vliv na změny ve mzdách a cenách potravin ve stejném nebo následujícím roce?

Z dat vychází, že **u mezd je vztah k HDP vidět, u cen potravin není tak zřetelný**.

Za výrazný růst HDP jsem zvolil meziroční růst nad 5 %. Do této skupiny patří roky 2007 (5,57 %), 2015 (5,39 %) a 2017 (5,17 %).

V těchto letech mzdy vzrostly o 7,22 %, 3,19 % a 6,74 %, zatímco průměr za celé období je 4,24 %. V následujícím roce vzrostly o 7,85 %, 4,42 % a 8,16 %, tedy ve všech třech případech nad průměr. Tato data naznačují, že mzdy mohou na silný růst HDP reagovat hlavně s ročním zpožděním. Opačným příkladem je rok 2009: HDP kleslo o 4,66 %, ale mzdy přesto vzrostly o 3,37 % a v následujícím roce o dalších 2,16 %.

Když naopak HDP v letech 2012 (−0,79 %) a 2013 (−0,05 %) klesalo nebo stagnovalo, mzdy v roce 2013 klesly o 0,13 %.

U cen potravin stejný vztah vidět není. V letech silného růstu HDP rostly ceny o 9,26 %, −0,69 % a 7,06 % (průměr za celé období je 3,18 %) a v následujícím roce o 8,92 %, −1,40 % a 2,41 %. V roce 2009 HDP kleslo o 4,66 % a ceny potravin klesly o 6,59 %, ale v roce 2015 ceny klesaly i přes růst HDP o 5,39 %. Jednoznačný vztah tedy z těchto dat nevyplývá.

Pearsonův korelační koeficient jsem spočítal z hodnot výstupu skriptu `07_otazka_5.sql` (sloupce růst HDP, růst mezd a růst cen) a vychází takto: HDP a mzdy ve stejném roce 0,49, HDP a mzdy v následujícím roce 0,70, HDP a ceny ve stejném roce 0,43 a HDP a ceny v následujícím roce 0,05. Jde ale jen o 11 až 12 pozorování, takže je to spíš orientační výsledek než důkaz.

## Poznámky k datům a omezení

- **Období:** mzdy jsou dostupné pro roky 2000 až 2021, ceny pouze pro 2006 až 2018. Společné období je proto 2006 až 2018. Rok 2021 navíc nemá všechna čtyři čtvrtletí.
- **Mzdy:** obě varianty výpočtu, fyzický i přepočtený, mají stejný počet řádků. Použil jsem přepočtený (200), protože je lépe srovnatelný mezi různými úvazky.
- **Chybějící odvětví:** 172 řádků mezd bez kódu odvětví používám jako celostátní průměr. Ve finální tabulce jsou označené jako „Všechna odvětví“. Otázky 2, 4 a 5 s tímto průměrem pracují, otázka 1 tyto řádky vynechává.
- **Ceny:** průměr se počítá ze všech měření za rok, tedy z krajských i celostátních řádků dohromady (14 krajů, 7 217 řádků bez kraje). Ověřil jsem, že volba úrovně na výsledek skoro nemá vliv: při porovnání s průměrem jen z celostátních řádků vychází u 342 dvojic roku a kategorie průměrná odchylka 0,00 % a největší 0,09 %.
- **Jednotky:** jednotlivé kategorie mají různé jednotky (kg, l, ks, g). V otázce 2 se porovnává 1 kg chleba a 1 l mléka. V obou případech je množství 1, takže je výpočet přímý.
- **Víno bílé** (kód 212101) má ceny pouze pro 4 roky, ostatní kategorie pro všech 13. Proto z primární tabulky chybí 180 kombinací roku, odvětví a kategorie a růst vína se počítá jen mezi po sobě jdoucími roky.
- **Sekundární tabulka:** v `economies` chybí 37 hodnot HDP a 124 hodnot GINI u evropských zemí za roky 2006 až 2018. České HDP je dostupné pro všechny roky. Ze 48 evropských zemí v tabulce `countries` mají data v `economies` jen 45.
- **Růst cen potravin v otázkách 4 a 5** je jednoduchý průměr meziročních změn všech kategorií bez vah podle spotřeby.
