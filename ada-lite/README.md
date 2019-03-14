# ADA Lite voor de Geboortezorg - Documentatie

Deze `ada-lite` sub-directory van de `ADA-Lite-Geboortezorg` repository bevat bestanden om ontwikkelaars te ondersteunen bij het bouwen van geboortezorg applicaties.

## <a name="onderdelen"></a>Onderdelen

De ondersteuning bestaat uit de volgende onderdelen, ieder in hun eigen sub-directory van `ada-lite`.

### Versieverschillen overzicht (`ada-lite/diffs`)

De `ada-lite/diffs` sub-directory bevat overzichten van de verschillen tussen de versies van een aantal ADA specificaties.

Bijvoorbeeld de bestanden `diff-kernset-22-23.xml` en `diff-kernset-22-23.html` bevatten een overzicht van de versieverschillen tussen de ADA kernset versie 2.3 en versie 2.3.

- De HTML bestanden geven een leesbaar overzicht van de verschillen.
- De XML bestanden bevatten dit overzicht in XML formaat en geven iets meer informatie. Ze zijn bedoeld als invoer voor eventuele  (semi-)automatische versie convertors. 

### Lege voorbeelddocumenten ADA Lite (`ada-lite/examples-empty`)

De `ada-lite/examples-empty` sub-directory bevat lege voorbeelddocumenten in het ADA Lite formaat. 

**Let op**: voor elementen waarop dit van toepassing is  zowel een `value` als een  `enum` attribuut aanwezig. De bedoelding is dat in het uiteindelijke document één van deze twee gebruikt wordt, niet beide.

### Ingevulde voorbeelddocument ADA Full (`ada-lite/examples-full`)

De `ada-lite/examples-full` sub-directory bevat voorbeelddocumenten in het ADA Full formaat.

Deze documenten zijn gegenereerd uit de ADA Lite voorbeelddocumenten uit `ada-lite/examples-lite` met behulp van de `ada-lite/xsl/ada-lite2ada-full.xsl` stylesheet. 

### Ingevulde voorbeelddocument ADA Lite (`ada-lite/examples-lite`)

De `ada-lite/examples-lite` sub-directory bevat voorbeelddocumenten in het ADA LIte formaat.

De ADA Full versie van deze documenten zijn te vinden in de `ada-lite/examples-full` sub-directory.

### Ingevulde voorbeelddocument ADA Full (`ada-lite/schemas`)

De `ada-lite/schemas` sub-directory bevat schemas waarmee ADA Full documenten gevalideerd kunnen worden. Er is een schema per document type. Bijvoorbeeld `RetrieveTransaction_kernset_22.xsd` bevat het schema voor het valideren van Full ADA kernset versie 2.2 documenten. 

Deze schemas zijn gegenereerd met behulp van de ART-DECOR schema generator.

Hoe een validatie met behulp van een schema uitgevoerd moet worden staat beschreven in [Schema validatie](#schema-validatie).

Deze schemas zijn complex van opzet en voor code generatie waarschijnlijk minder geschikt. Eenvoudiger opgezette schemas zijn te vinden in `ada-lite/schemas-simple-full` en `ada-lite/schemas-simple-lite`.

### <a name="schemas-simple-full"></a>Vereenvoudigde schemas ADA Full (`ada-lite/schemas-simple-full`)

De `ada-lite/schemas-simple-full` sub-directory bevat vereenvoudigde schemas waarmee ADA Full documenten gevalideerd kunnen worden. Er is een schema per document type. Bijvoorbeeld `RetrieveTransaction_kernset_22.simple.full.xsd` bevat het schema voor het valideren van Full ADA kernset versie 2.2 documenten. 

Vereenvoudigd betekent *niet* dat de validatie onvolledig is, alles wordt gevalideerd. Alleen de opzet van het schema is vereenvoudigd, zodat het simpeler wordt om code generatoren te baseren op deze schemas. 

Hoe een validatie met behulp van een schema uitgevoerd moet worden staat beschreven in [Schema validatie](#schema-validatie).

### Vereenvoudigde schemas ADA Lite (`ada-lite/schemas-simple-lite`)

De `ada-lite/schemas-simple-lite` sub-directory bevat vereenvoudigde schemas waarmee ADA Lite documenten gevalideerd kunnen worden. Er is een schema per document type. Bijvoorbeeld `RetrieveTransaction_kernset_22.simple.lite.xsd` bevat het schema voor het valideren van Full ADA kernset versie 2.2 documenten. 

Verdere informatie en gebruik is identiek aan [Vereenvoudigde schemas ADA Full](#schemas-simple-full).

### <a name="schematrons-ada-full"></a>Schematrons ADA Full (`ada-lite/schematrons-full`)

De `ada-lite/schematrons-full` sub-directory bevat Schematron documenten waarmee ADA Full documenten gevalideerd kunnen worden. Er is een Schematron bestand per document type. Bijvoorbeeld `RetrieveTransaction_kernset_22.simple.full.sch` is bedoeld voor het het valideren van Full ADA kernset versie 2.2 documenten.   

De Schematron validatie is zo opgezet dat deze hetzelfde doet als de schema validatie, alleen zijn de meldingen gebruikersvriendelijker en in het Nederlands.

Hoe een Schematron validatie uitgevoerd moet worden staat beschreven in [Schema validatie](#schematron-validatie). Hierin wordt ook de betekenis van de `svrl-xsl` sub-directory uitgelegd.

### <a name="schematrons-ada-lits"></a>Schematrons ADA Lite (`ada-lite/schematrons-lite`)

De `ada-lite/schematrons-lite` sub-directory bevat Schematron documenten waarmee ADA Lite documenten gevalideerd kunnen worden. Er is een Schematron bestand per document type. Bijvoorbeeld `RetrieveTransaction_kernset_22.simple.lite.sch` is bedoeld voor het het valideren van Lite ADA kernset versie 2.2 documenten.   

Verdere informatie en gebruik is identiek aan [Schematrons ADA Full](#schematrons-ada-full) .

### Vereenvoudigde specificaties (`ada-lite/specs-simplified`)

De `ada-lite/specs-simplified` sub-directory bevat vereenvoudigde specificaties van het ADA formaat. Deze specificaties bevatten alleen de voor het ADA formaat noodzakelijke informatie.

Mocht het noodzakelijk zijn dan kunnen de volledige specificaties gevonden worden in `design/specs-full`.

### Stylesheets (`ada-lite/xsl`)

De `ada-lite/xsl` sub-directory bevat XSLT stylesheet(s) voor de ADA applicatie ontwikkelaars.

- `ada-lite2ada-full.xsl`: Converteert een document in ADA Lite formaat naar het ADA Full formaat.

Het uitvoeren van stylesheet transformaties in het algemeen staat beschreven in [Stylesheet transformaties](#stylesheet-transformaties).

#### Uitvoeren `adalite2ada-full.xsl`

Lorem ipsum.

## <a name="gebruik"></a>Gebruik

Lorem ipsum.

### <a name="schema-validatie"></a>Schema validatie

Lorem ipsum.

### <a name="schematron-validatie"></a>Schematron validatie

Lorem ipsum.

### <a name="stylesheet-transformaties"></a>Stylesheet Transformaties

Lorem ipsum.