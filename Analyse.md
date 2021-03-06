---
title: "'Analyse tikkertje data'"
output:
      html_document:
        keep_md: true
      github_document: default
---


## Inleiding

Als eerste stap bekijken we de gegevens vergaard tijdens de experimenten. De 'opgekuiste' gegevens zijn als volgt:


 # spelers   # lopers   # tikkers   # getikt   duur [sec]
----------  ---------  ----------  ---------  -----------
        36         31           5         31          146
        36         30           6          4          180
        35         32           3          5          120
        35         30           5         16          120
        35         31           4          9          120
        35         30           5         10          120
        35         32           3          5          120
        11         10           1          0           50
        13         10           3         10           42
        13         11           2         11           40
        18         15           3          6          149
        18         14           4          3          141

Het uiteindelijke doel is om een zo goed mogelijke voorspelling te verkrijgen voor de duurtijd van het spel als functie van de verhouding van het aantal tikkers ten opzichte van het aantal lopers. Om dit 'correct' te doen zijn er veel te weinig gegevens. In principe is dit een dynamisch spel dat waarschijnlijk (niet exhaustief) beïnvloed wordt door het aantal tikkers en lopers, de geometrie van het veld, de strategie van de lopers en tikkers en de fitheid van de lopers en tikkers. Bovendien zal de invloed van deze variabelen hoogst waarschijnlijk niet constant zijn maar variëren in de tijd, afhankelijk van de andere variabelen (de fitheid van de spelers zal bijvoorbeeld zeker niet constant blijven). De hoeveelheid gegevens daarentegen is beperkt. De bovenstaande dataset bevat slechts 12 observaties.

Om deze reden zullen we het hier zo simpel mogelijk houden. De enige controleerbare factor is de verhouding van het aantal tikkers ten opzichte van het aantal spelers. Deze kunnen we gebruiken om te proberen te voorspellen hoeveel lopers er per tijdseenheid netto uit het spel verdwijnen. Met netto wordt hier bedoeld hoeveel er worden getikt min het aantal getikten die worden bevrijd.

## Additiviteit assumptie

De eerste ruwe benadering die we gebruiken is dat het aantal lopers dat netto per seconde wordt getikt constant blijft gedurende het spel. Met andere woorden, als we $L_t$ gebruiken voor het aantal vrije lopers na $t$ seconden en $y$ het netto aantal lopers dat per seconde getikt wordt, dan hebben we:
$$L_t = N_0-yt$$
Dit netto aantal getikten per seconde, $y$, kan dan geschat worden als
$$y \approx \frac{G_t}{t}$$
waar $G_t$ het aantal getikten na $t$ seconden is. We kunnen dan, op basis van de data, pogen om $y$ te voorspellen als functie de verhouding van het aantal tikkers, $T$, ten opzichte van het totaal aantal spelers, $L + T$:
$$y = f\left(\frac{T}{L + T}\right)$$.
Deze functie zou in principe aan de volgende eigenschappen moeten voldoen: $f\left(0\right) = 0$, $f\left(1\right) = 0$, $f'\left(0^+\right) > 0$. 
We beginnen met de bovenstaande gegevens grafisch voor te stellen.
![](Analyse_files/figure-html/plot_additief-1.png)<!-- -->
Op bovenstaande grafiek zien we effectief een licht stijgend verband tussen de verhouding tikkers-lopers en het aantal getikten per minuut. We zien ook dat deze verhouding groter was in de experimenten met een kleiner aantal spelers (groen tegenover blauw). Verder zien we ook dat het aantal getikten per minuut een stuk hoger lag in de drie spelletjes die effectief beëindigd zijn. Dit laatste zou een logisch artefact kunnen zijn indien de spelletjes steeds beëindigd werden na een aantal minuten. Ten slotte is er ook één datapunt dat we als "missing" (vanwege censoring) kunnen omschrijven, weergegeven in bovenstaande grafiek in het rood. Dit punt zullen we weglaten, ondanks onze beperkte dataset, omdat hier een waarde voor te imputeren een grote invloed zal hebben op verdere analyses.

Om te voorspellen wat $y$ zou zijn wanneer er 40 tikkers zijn en 1500 lopers zullen we de volgende modellen proberen:
$$
\begin{aligned}
Model\, 1: y &= \beta_0 + \beta_1 x + \epsilon;\, \epsilon \sim N \left(0, \sigma^2\right)\\
Model\, 2: y &= \beta_1 + \epsilon; \, \epsilon \sim N \left(0, \sigma^2\right)\\
Model\, 3: y &= \beta_0 + \beta_1 x + \beta_2 x^2 + \epsilon;\, \epsilon \sim N \left(0, \sigma^2\right) \\
Model\, 4: y &= \beta_1 x + \beta_2 x^2 + \epsilon;\, \epsilon \sim N \left(0, \sigma^2\right) \\
Model\, 5: y &= \exp\left[\log(\beta_0) + \beta_1 \log(x) + \beta_2 \log(1 - x) + \epsilon \right];\, \epsilon \sim N \left(0, \sigma^2\right)
\end{aligned}
$$
Modellen 1 en 3 kunnen enkel lokaal correct zijn (gegeven dat $\beta_0$ niet 0 is). Modellen 2 en 4 voorspellen een 0 wanneer $x$ 0 is. Model 5 is niet gedefinieerd wanneer $x$ 0 of 1 is maar is flexibel op het interval $(0, 1)$ (cfr de beta verdelingsfunctie). Deze modellen zijn grafisch voorgesteld in onderstaande grafiek. We kunnen observeren dat model 3 waardeloos is aangezien het een negatief aantal getikten per minuut voorspelt op het punt waar we willen voorspellen: $40 / 1500 \approx 0.027$.

![](Analyse_files/figure-html/additieve_modellen-1.png)<!-- -->




