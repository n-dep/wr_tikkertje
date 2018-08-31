---
title: "'Analyse tikkertje data'"
output:
      html_document:
        keep_md: true
---


## Inleiding

Als eerste stap bekijken we de gegevens vergaard tijdens de experimenten. De 'opgekuiste' gegevens zijn als volgt:


 # spelers   # lopers   # tikers   # getikt   duur [sec]
----------  ---------  ---------  ---------  -----------
        36         31          5         31          146
        36         30          6          4          180
        35         32          3          5          120
        35         30          5         16          120
        35         31          4          9          120
        35         30          5         10          120
        35         32          3          5          120
        11         10          1          0           50
        13         10          3         10           42
        13         11          2         11           40
        18         15          3          6          149
        18         14          4          3          141

Het uiteindelijke doel is om een zo goed mogelijke voorspelling te verkrijgen voor de duurtijd van het spel als functie van de verhouding van het aantal tikkers ten opzichte van het aantal lopers. Om dit 'correct' te doen zijn er veel te weinig gegevens. In principe is dit een dynamisch spel dat waarschijnlijk, onder andere, beïnvloed wordt door het aantal tikkers en lopers, de geometrie van het veld, de strategie van de lopers en tikkers en de fitheid van de lopers en tikkers. Bovendien zal de invloed van deze variabelen hoogst waarschijnlijk niet constant zijn maar variëren in de tijd, afhankelijk van de andere variabelen (de fitheid van de spelers zal bijvoorbeeld zeker niet constant blijven). 
Om deze reden zullen we het hier zo simpel mogelijk houden. De enige controleerbare factor is de verhouding van het aantal tikkers ten opzichte van het aantal spelers. Deze kunnen we dan gebruiken om te proberen te voorspellen hoeveel lopers er per tijdseenheid netto uit het spel verdwijnen. Met netto wordt hier bedoeld hoeveel er worden getikt min het aantal getikten die worden bevrijd.

## Additiviteit assumptie

De eerste ruwe benadering die we gebruiken is dat het aantal lopers die netto per seconde worden getikt constant blijft gedurende het spel. Met andere woorden, als we $L_t$ gebruiken voor het aantal vrije lopers na $t$ seconden en $y$ het netto aantal lopers dat per seconde getikt wordt, dan hebben we:
$$L_t=N_0-yt$$
