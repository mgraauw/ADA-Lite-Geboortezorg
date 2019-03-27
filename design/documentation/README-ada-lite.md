# ADA Lite voor de Geboortezorg - Documentatie

Deze `ada-lite` sub-directory van de `ADA-Lite-Geboortezorg` repository bevat bestanden om ontwikkelaars te ondersteunen bij het bouwen van geboortezorg applicaties.

----------

## <a name="onderdelen"></a>Onderdelen

De ondersteuning bestaat uit de volgende onderdelen, ieder in hun eigen sub-directory van `ada-lite`.

### Versieverschillen overzicht (`ada-lite/diffs`)

De `ada-lite/diffs` sub-directory bevat overzichten van de verschillen tussen de versies van een aantal ADA specificaties.

Bijvoorbeeld de bestanden `diff-kernset-22-23.xml` en `diff-kernset-22-23.html` bevatten een overzicht van de versieverschillen tussen de ADA kernset versie 2.3 en versie 2.3.

- De HTML bestanden geven een leesbaar overzicht van de verschillen.
- De XML bestanden bevatten dit overzicht in XML formaat en bevatten iets meer (technische) informatie. Ze zijn bedoeld als invoer voor eventuele  (semi-)automatische versie convertors. 

### Lege voorbeelddocumenten ADA Lite (`ada-lite/examples-empty`)

De `ada-lite/examples-empty` sub-directory bevat lege voorbeelddocumenten in het ADA Lite formaat. 

**Let op**: voor elementen waarop dit van toepassing is, is zowel een `value` als een  `enum` attribuut aanwezig. In het uiteindelijke document moet één van deze twee gebruikt worden, niet beide.

### Ingevulde voorbeelddocument ADA Full (`ada-lite/examples-full`)

De `ada-lite/examples-full` sub-directory bevat voorbeelddocumenten in het ADA Full formaat.

Deze documenten zijn gegenereerd uit de ADA Lite voorbeelddocumenten in `ada-lite/examples-lite`, met behulp van de `ada-lite/xsl/ada-lite2ada-full.xsl` stylesheet. 

### Ingevulde voorbeelddocument ADA Lite (`ada-lite/examples-lite`)

De `ada-lite/examples-lite` sub-directory bevat voorbeelddocumenten in het ADA LIte formaat.

De ADA Full versie van deze documenten zijn te vinden in de `ada-lite/examples-full` sub-directory.

### Ingevulde voorbeelddocument ADA Full (`ada-lite/schemas`)

De `ada-lite/schemas` sub-directory bevat XML schemas waarmee ADA Full documenten gevalideerd kunnen worden. Er is een schema per document type. Bijvoorbeeld `kernset-22.xsd` bevat het schema voor het valideren van Full ADA kernset versie 2.2 documenten. 

Deze schemas zijn gegenereerd met behulp van de ART-DECOR schema generator.

Hoe een validatie met behulp van een schema uitgevoerd moet worden staat beschreven in [Schema validatie](#schema-validatie).

Deze schemas zijn intern complex van opzet en voor code generatie waarschijnlijk minder geschikt. Eenvoudiger opgezette schemas zijn te vinden in `ada-lite/schemas-simple-full` en `ada-lite/schemas-simple-lite`.

### <a name="schemas-simple-full"></a>Vereenvoudigde schemas ADA Full (`ada-lite/schemas-simple-full`)

De `ada-lite/schemas-simple-full` sub-directory bevat vereenvoudigde schemas waarmee ADA Full documenten gevalideerd kunnen worden. Er is een schema per document type. Bijvoorbeeld `kernset-22.simple.full.xsd` bevat het schema voor het valideren van Full ADA kernset versie 2.2 documenten. 

Vereenvoudigd betekent *niet* dat de validatie onvolledig is, alles wordt gevalideerd. Alleen de opzet van het schema is vereenvoudigd, zodat het simpeler wordt om code generatoren hierop te baseren. 

Hoe een validatie met behulp van een schema uitgevoerd moet worden staat beschreven in [Schema validatie](#schema-validatie).

### Vereenvoudigde schemas ADA Lite (`ada-lite/schemas-simple-lite`)

De `ada-lite/schemas-simple-lite` sub-directory bevat vereenvoudigde schemas waarmee ADA Lite documenten gevalideerd kunnen worden. Er is een schema per document type. Bijvoorbeeld `kernset-22.simple.lite.xsd` bevat het schema voor het valideren van Full ADA kernset versie 2.2 documenten. 

Verdere informatie en gebruik is identiek aan [Vereenvoudigde schemas ADA Full](#schemas-simple-full).

### <a name="schematrons-ada-full"></a>Schematrons ADA Full (`ada-lite/schematrons-full`)

De `ada-lite/schematrons-full` sub-directory bevat Schematron documenten waarmee ADA Full documenten gevalideerd kunnen worden. Er is een Schematron bestand per document type. Bijvoorbeeld `kernset-22.simple.full.sch` is bedoeld voor het het valideren van Full ADA kernset versie 2.2 documenten.   

De Schematron validatie is zo opgezet dat deze hetzelfde doet als de schema validatie, alleen zijn de meldingen gebruikersvriendelijker en in het Nederlands.

Hoe een Schematron validatie uitgevoerd moet worden staat beschreven in [Schema validatie](#schematron-validatie). Hierin wordt ook de betekenis van de `svrl-xsl` sub-directory uitgelegd.

### <a name="schematrons-ada-lits"></a>Schematrons ADA Lite (`ada-lite/schematrons-lite`)

De `ada-lite/schematrons-lite` sub-directory bevat Schematron documenten waarmee ADA Lite documenten gevalideerd kunnen worden. Er is een Schematron bestand per document type. Bijvoorbeeld `kernset-22.simple.lite.sch` is bedoeld voor het het valideren van Lite ADA kernset versie 2.2 documenten.   

Verdere informatie en gebruik is identiek aan [Schematrons ADA Full](#schematrons-ada-full) .

### Vereenvoudigde specificaties (`ada-lite/specs-simplified`)

De `ada-lite/specs-simplified` sub-directory bevat vereenvoudigde specificaties van het ADA formaat. Deze specificaties bevatten alleen de voor het ADA formaat noodzakelijke informatie.

Mocht het noodzakelijk zijn dan kunnen de volledige specificaties gevonden worden in `design/specs-full`.

### Stylesheets (`ada-lite/xsl`)

De `ada-lite/xsl` sub-directory bevat XSLT stylesheet(s) voor de ADA applicatie ontwikkelaars.

- `ada-lite2ada-full.xsl`: Converteert een document in ADA Lite formaat naar het ADA Full formaat.

Het uitvoeren van stylesheet transformaties in het algemeen staat beschreven in [Stylesheet transformaties](#stylesheet-transformaties).

#### Uitvoeren `adalite2ada-full.xsl`

Deze stylesheet converteert een ADA Lite document naar een ADA Full document. Zie ook [Stylesheet transformaties](#stylesheet-transformaties).

De transformatie heeft de bijbehorende specificatie van het gebruikte ADA formaat nodig in de parameter `dref-rtd`. Deze specificaties bevinden zich in de sub-directory `ada-lite/specs-simplified`. 

Voorbeeld van een command line hiervoor:

```
java -cp "pad-naar-saxon-installatie-directory/*" 
      net.sf.saxon.Transform 
      "-s:pad-naar-invoer-bestand" 
      "-xsl:pad-naar-adalite2ada-full.xsl" 
      "-o:pad-naar-uitvoer-bestand" 
      "dref-rtd=file:/pad-naar-specificatie"
```

**Let op**: Het pad naar de specificatie moet vooraf gegaan worden door `file:/`! 

----------

## <a name="gebruik"></a>Gebruik

Hieronder technische informatie over hoe de verschillende onderdelen van `ada-lite` gebruikt moeten worden.

### <a name="algemeen-gebruik"></a>Algemeen

Voor het uitvoeren van schema validaties en stylesheet transformaties is ondersteunende software nodig (een "processor"). Hiervoor bestaan verschillende mogelijkheden:

- Voor het uitvoeren van XML operaties in een ontwikkelomgeving is [oXygen](https://www.oxygenxml.com/) het meest gebruikte tool. Het is echter niet gratis.
- Voor het uitvoeren van "losse" transformaties en validaties wordt [Saxon](http://saxonica.com) aangeraden. De HE versie (Home Edition, gratis) is voldoende.

We gaan er in de verdere beschrijvingen van uit dat Saxon geïnstalleerd is volgens de instructies zoals hieronder. 

#### Saxon installatie

- Saxon is een Java applicatie. Zorg ervoor dat er een recente versie van Java op je systeem geïnstalleerd is. 
- De download pagina voor Saxon HE vind je [hier](https://sourceforge.net/projects/saxon/files/Saxon-HE/). 
- Download de zip (voor Saxon versie 9.9.1.2 heette deze `SaxonHE9-9-1-2J.zip`).
  - **Let op**: Voor Windows (.NET) gebruikers is er ook een versie die een executable installeert (de installatie-pakket bestandsnaam eindigt op `-setup.exe`), maar hiermee kunnen geen validaties worden uitgevoerd.
- Unzip deze zip file ergens op een geschikte plek.  

#### Saxon gebruik algemeen

Om Saxon te kunnen draaien moet Java de Saxon `.jar` files kunnen vinden. Deze moeten dus op het Java classpath staan. Er zijn meerdere manieren om dit te doen.

Bijvoorbeeld specificeren op de command line:

```
java -cp "pad-naar-saxon-installatie-directory/*" ....
```

Of maak een omgevings variabele `CLASSPATH` waarin je dit opneemt.
 
 

### <a name="schema-validatie"></a>Schema validatie

Uitgangspunt is dat Saxon geïnstalleerd is zoals beschreven in de sectie over [algemeen gebruik](#algemeen-gebruik). Documentatie over het uitvoeren van validaties met Saxon vind je [hier](http://www.saxonica.com/documentation/index.html#!schema-processing/commandline).

Bijvoorbeeld:

```
java -cp "pad-naar-saxon-installatie-directory/*" 
      com.saxonica.Validate "-s:pad-naar-te-valideren-bestand"
      "-xsd:pad-naar-schema-bestand"
```


### <a name="stylesheet-transformaties"></a>Stylesheet transformaties


Uitgangspunt is dat Saxon geïnstalleerd is zoals beschreven in de sectie over [algemeen gebruik](#algemeen-gebruik). Documentatie over het uitvoeren van transformaties met Saxon vind je [hier](http://www.saxonica.com/documentation/index.html#!using-xsl/commandline).

Bijvoorbeeld: 

```
java -cp "pad-naar-saxon-installatie-directory" 
      net.sf.saxon.Transform 
      "-s:pad-naar-invoer-bestand" 
      "-xsl:pad-naar-stylesheet" 
      "-o:pad-naar-uitvoer-bestand"
```

### <a name="schematron-validatie"></a>Schematron validatie

Validatie met Schematron is niet op de directe manier mogelijk zoals dat met schemas wel kan. Opties zijn:

- Gebruik een ontwikkelaars werkbank als [oXygen](https://www.oxygenxml.com/). Hierin kunnen Schematron validaties worden uitgevoerd.
- Maak zelf een Schematron validatie straat met behulp van de "Schematron skeleton implementation", te vinden op [https://github.com/Schematron/schematron.git](https://github.com/Schematron/schematron.git).
- Gebruik de stylesheets in de `svrl-xsl`. 
  - Zie ook [Stylesheet transformaties](#stylesheet-transformaties).
  - Deze stylesheets zijn gegenereerd uit de Schematrons met behulp van de hiervoor genoemde "Schematron skeleton implementation". 
  - Als je deze stylesheets loslaat op een te valideren bestand krijg je als uitvoer een SVRL (Schema Validation Reporting Language) XML bestand met daarin de resultaten van de validatie. 
  - Een SVRL bestand is *niet* bedoeld om direct aan gebruikers te tonen, maar kan wel worden gebruikt om een gebruikersvriendelijke presentatie, bijvoorbeeld een HTML pagina, uit af te leiden. 
