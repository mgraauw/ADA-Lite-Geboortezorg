# ADA Lite voor de Geboortezorg

Zie ook de [GitHub pages](https://mgraauw.github.io/ADA-Lite-Geboortezorg) behorende bij deze repository.

ADA Lite is een aanleverformaat voor de Geboortezorg, in eerste instantie voor verloskundige informatie. Aanlevering gegevens op basis van HL7v3 berichten is vaak complex en foutgevoelig. Daarnaast staan de gegevensstructuren zoals die in HL7v3 gehanteerd worden vaak ver af van de gegevens zoals die in de verloskunde gehanteerd worden. Binnen de geboortezorg is daarom behoefte aan een eenvoudiger formaat, wat dicht aansluit op de praktijk. Mogelijk kan op termijn FHIR in die behoefte voorzien. Daarvoor zijn op dit moment (begin 2019) de FHIR specificaties voor Geboortezorg nog onvoldoende ontwikkeld. ADA is gebaseerd op het PWD en volgt de structuur van de dataset daarin. De software en specificaties vallen onder de open source [MIT licentie](https://choosealicense.com/licenses/mit/).

## Aanlevering is XML

```xml
<?xml version="1.0" encoding="UTF-8"?>
```

Aanbevolen is de XML declaratie op te nemen. Uitwisseling gebeurt altijd in UTF-8.


## Hoofdniveau is een transactie
```xml
<acute_overdracht transactionRef="2.16.840.1.113883.2.4.3.11.60.90.77.4.2301"
                   versionDate="2018-11-09T12:31:45">
   .... details ....
</acute_overdracht>
```
Het root element is altijd de naam van een transactie. Hier wordt - net als voor alle elementnamen, de ADA shortName genomen. Dit is de Nederlandse naam van het concept, maar dan geschikt gemaakt voor gebruik als XML tagnaam. Concreet betekent dit:

* alleen lowercase
* whitespace wordt vervangen door een enkele underscore
* diakrieten worden vervangen door gewone letters
* '?' wordt vervangen door een 'q'

Op het root element zitten twee attributen die de versie van de transactie bepalen. Dit zijn:

* transactionRef met het id van de transaction
* versionDate met de timestamp van de release

Met deze twee gegevens en de volgende URI:
```mustache
https://decor.nictiz.nl/decor/services/RetrieveTransaction?id={{transactionRef}}&version={{versionDate}}&format=xml
```
Zijn de volledige specs in XML te vinden. Met `format=html` dito in HTML.

Dit zijn de enige twee versieaanduidingen.

## Groepen volgen de dataset precies
```xml
<acute_overdracht ....>
    <zorgverlenerzorginstelling>
        <zorgverlener>
            <naam_zorgverlener value="V.E.R. Loskundige"/>
        </zorgverlener>
        <zorginstelling>
            <naam_zorginstelling value="Test instelling 1"/>
        </zorginstelling>
    </zorgverlenerzorginstelling>
    <vrouw>
        <burgerservicenummer value="123456095"/>
        <naamgegevens>
            <achternaam>
                <voorvoegsel value="van der"/>
                <achternaam value="Zwan"/>
            </achternaam>
        </naamgegevens>
    ...
</acute_overdracht>
```
Iedere groep wordt overgenomen van de dataset. Er mag geen groep worden overgeslagen. Dit borgt dat ieder element
altijd uniek te traceren is met paden: `acute_overdracht/vrouw/burgerservicenummer/@value`
## Gegevens zitten in @value of @enum
```xml
<burgerservicenummer value="999995856"/>
```
Identificaties zoals een BSN komen gewoon in de value.
```xml
<naam_zorginstelling value="Verloskundigenpraktijk Amstrecht Centrum"/>
```
Dito voor strings.
```xml
<bloedgroep_vrouw value="58460004"/>
```
Codes (hier: een Snomed code) worden opgenomen zoals ze in de valueSet voorkomen.

Er is één uitzondering: mocht een code tweemaal voorkomen in één valueSet (dat kan, als
de code uit een ander codesysteem komt), dan wordt de code/codesysteem combinatie vervangen door een uniek nummer (binnen die valueSet). Deze situatie komt in PWD 2.2 niet voor.

```xml
<hoeveelheid_bloedverlies value="600"/>
```

Hoeveelheden worden opgenomen als numerieke waarden. De bijbehorende eenheid is terug te vinden in de PWD specificaties.

```xml
<hoeveelheid_bloedverliesq value="true"/>
```

Booleans bevatten 'true' of 'false'.

```xml
<apgarscore_na_5_min value="8"/>
```

Scores en dergelijke worden ook opgenomen.

```xml
<duur_actieve_ontsluitingsfase_ontsluitingsduur value="4.17"/>
```

Dito numerieke waarden. Er worden decimale punten gebruikt, geen komma's.

```xml
<geboortedatum value="1990-01-01"/>
<datum_onderzoek value="2019-01-20T13:15:00"/>
```

Datums en tijden worden doorgegeven in ISO formaat. Waar tijden worden doorgegeven, wordt de separator 'T' gebruikt. Er wordt geen timezone doorgegeven.

### Enums

```xml
<rhesus_d_factor_vrouw enum="Rh_D_Positief"/>
```
Codes mogen ook opgenomen worden als enum attribuut. Bij iedere code wordt in het schema een unieke, leesbare enum naam gegenereerd. Dit is een alternatief voor het minder leesbare:
```xml
<rhesus_d_factor_vrouw value="165747007"/>
```
## Extensies

```xml
<vrouw>
    <burgerservicenummer value="999995856"/>
    <adaextension url="http://www.marcdegraauw.com/extension-example">
        <skype-id value="mgraauw" conceptId="1"/>
    </adaextension>
</vrouw>
```
Leveranciers kunnen gegevens die niet in PWD voorkomen doorgeven in een `adaextension` groep. Deze groep kan (optioneel) voorkomen als laatste element binnen ieder groepselement.

## Vorige zwangerschappen zijn losse aanleveringen
In PWD zit de "obstetrische anamnese per voorgaande zwangerschap". Deze wordt aangeleverd
als losse zwangerschap, met daarin de subset van gegevens die relevant zijn voor de vorige zwangerschap (dat is niet het complete dossier).

Dit is nodig bij aanlevering aan een repository, anders onstaat de volgende situatie:

* kind 1 geboren, er wordt een zwangerschapsdossier aangeleverd
* kind 2 geboren, er wordt een zwangerschapsdossier aangeleverd, met daarin gegevens van kind 1 weer in "obstetrische anamnese per voorgaande zwangerschap"
* kind 3 geboren, er wordt een zwangerschapsdossier aangeleverd, met daarin gegevens van kind 1 en 2 weer in "obstetrische anamnese per voorgaande zwangerschap"

Kortom, met 3 kinderen worden 6 zwangerschappen geregistreerd. Dat is niet wenselijk. Voor aanleveringen als de kernset aan Perined kunnen de vorige en huidige zwangerschappen eventueel weer tot één aanleverberichte geaggregreerd worden.

## Full ADA

Volledig ADA, met conceptId, code en codeSystem en unit is ook toegestaan als aanlevering:
```xml
<actuele_bloeddruk conceptId="2.16.840.1.113883.2.4.3.11.60.90.77.2.4.10807">
    <actuele_bloeddruk_systolisch value="160" unit="mm Hg"
         conceptId="2.16.840.1.113883.2.4.3.11.60.90.77.2.4.10808"/>
    <actuele_bloeddruk_diastolisch value="110" unit="mm Hg"
         conceptId="2.16.840.1.113883.2.4.3.11.60.90.77.2.4.10809"/>
</actuele_bloeddruk>
<bloedgroep_vrouw value="4" 
   conceptId="2.16.840.1.113883.2.4.3.11.60.90.77.2.4.10810" 
   code="58460004" 
   codeSystem="2.16.840.1.113883.6.96" 
   displayName="Blood group O (finding)"/>
```

## Een compleet voorbeeld

```xml
<?xml version="1.0" encoding="UTF-8"?>
<acute_overdracht transactionRef="2.16.840.1.113883.2.4.3.11.60.90.77.4.2301" versionDate="2018-11-09T12:31:45">
    <zorgverlenerzorginstelling>
        <zorgverlener>
            <naam_zorgverlener value="V.E.R. Loskundige"/>
        </zorgverlener>
        <zorginstelling>
            <naam_zorginstelling value="Test instelling 1"/>
        </zorginstelling>
    </zorgverlenerzorginstelling>
    <vrouw>
        <burgerservicenummer value="123456095"/>
        <naamgegevens>
            <achternaam>
                <voorvoegsel value="van der"/>
                <achternaam value="Zwan"/>
            </achternaam>
        </naamgegevens>
        <bloedgroep_vrouw value="58460004"/>
        <rhesus_d_factor_vrouw value="165747007"/>
        <rhesus_c_factor value="rhcpos"/>
    </vrouw>
    <zwangerschap>
        <graviditeit value="2"/>
    </zwangerschap>
    <medisch_onderzoek>
        <maternale_onderzoeksgegevens>
            <urine_bloed_en_aanvullende_onderzoeken>
                <hb value="7.3"/>
            </urine_bloed_en_aanvullende_onderzoeken>
        </maternale_onderzoeksgegevens>
    </medisch_onderzoek>
    <medisch_onderzoek>
        <maternale_onderzoeksgegevens>
            <urine_bloed_en_aanvullende_onderzoeken>
                <hb value="6.8"/>
            </urine_bloed_en_aanvullende_onderzoeken>
        </maternale_onderzoeksgegevens>
    </medisch_onderzoek>
</acute_overdracht>
```

## Documentatie/Inhoud

In de `ada-lite` sub-directory staan specificaties die van belang zijn voor leveranciers. De documentatie hiervoor is te vinden in de README van deze sub-directory. 

In de andere sub-directories staan materialen die gebruikt worden om de specificaties te maken; deze zijn niet van belang voor leveranciers.

Het volledige ADA formaat is gedefinieerd op: [https://www.art-decor.org/mediawiki/index.php/ADA_Documentation](https://www.art-decor.org/mediawiki/index.php/ADA_Documentation)

PWD specificaties zijn te vinden op: [https://decor.nictiz.nl/decor/services/ProjectIndex?prefix=peri20-&format=html](https://decor.nictiz.nl/decor/services/ProjectIndex?prefix=peri20-&format=html)

## Transacties
De volgende transacties worden gebruikt:

* `RetrieveTransaction-prio1-huidig.xml`: Een voorbeelddossier met een paar gegevens van de huidige zwangerschap, met name voor test- en demo-doeleinden.
* `RetrieveTransaction-prio1-vorig.xml`: Een voorbeelddossier met een paar gegevens van de voorgaande zwangerschap, met name voor test- en demo-doeleinden.
* `RetrieveTransaction-verloskundig-dossier-22.xml`: Het complete verloskundig dossier, gebaseerd op PWD 2.2, voor aanlevering aan Babyconnect.
* `RetrieveTransaction_kernset_22.xml`: De kernset, gebaseerd op PWD 2.2, voor aanlevering aan Perined.


### Op ART-DECOR

Deze transacties zijn te vinden bij Nictiz:

* [Prio1 huidig](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2493&language=nl-NL&effectiveDate=2020-01-08T13:13:15&format=html&hidecolumns=56bcdefghijklmnop)
* [Prio1 vorig](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2499&language=nl-NL&effectiveDate=2020-01-08T13:47:27&format=html&hidecolumns=56bcdefghijklmnop)
* [Kernset PWD 2.2](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2410&effectiveDate=2014-10-20T00:00:00&language=nl-NL&ui=nl-NL&version=2018-11-09T12:31:45&format=html&hidecolumns=45ghijklmnop)
* [Samenvatting voorgaande zwangerschap PWD 2.2](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2465&effectiveDate=2019-03-07T15:23:44&language=nl-NL&ui=nl-NL&version=2019-09-26T16:35:41&format=html&hidecolumns=45ghijklmnop)
* [Verloskundig dossier PWD 2.2](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2462&effectiveDate=2019-03-07T15:19:31&language=nl-NL&ui=nl-NL&version=2019-09-26T16:35:41&format=html&hidecolumns=45ghijklmnop)
* [Kernset PWD 2.3](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2437&effectiveDate=2016-11-22T08:24:02&language=nl-NL&ui=nl-NL&version=2018-11-09T12:31:45&format=html&hidecolumns=45ghijklmnop)
* [Samenvatting voorgaande zwangerschap PWD 2.3](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2469&effectiveDate=2019-03-13T11:59:46&language=nl-NL&ui=nl-NL&version=2019-09-26T16:35:41&format=html&hidecolumns=45ghijklmnop)
* [Verloskundig dossier PWD 2.3](https://decor.nictiz.nl/decor/services/RetrieveTransaction?id=2.16.840.1.113883.2.4.3.11.60.90.77.4.2467&effectiveDate=2019-03-13T11:57:08&language=nl-NL&ui=nl-NL&version=2019-09-26T16:35:41&format=html&hidecolumns=45ghijklmnop)
