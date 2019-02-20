# ADA Lite voor de Geboortezorg

ADA Lite is een aanleverformaat voor de Geboortezorg, in eerste instantie voor verloskundige informatie.
Aanlevering gegevens op basis van HL7v3 berichten is vaak complex en foutgevoelig. Daarnaast staan de 
gegevensstructuren zoals die in HL7v3 gehanteerd worden vaak ver af van de gegevens zoals 
die in de verloskunde gehanteerd worden. Binnen de geboortezorg is daarom behoefte aan een 
eenvoudiger formaat, wat dicht aansluit op de praktijk. Mogelijk kan op termijn FHIR in die behoefte voorzien.
Daarvoor zijn op dit moment (begin 2019) de FHIR specificaties voor Geboortezorg nog onvoldoende 
ontwikkeld. ADA is gebaseerd op het PWD en volgt de structuur van de dataset daarin.
## ADA Lite
### Aanlevering is XML
```xml
<?xml version="1.0" encoding="UTF-8"?>
Aanbevolen is de XML declaratie op te nemen. Uitwisseling gebeurt in UTF-8.
```
### Hoofdniveau is een transactie
```xml
<acute_overdracht transactionRef="2.16.840.1.113883.2.4.3.11.60.90.77.4.2301" versionDate="2018-11-09T12:31:45">
   .... details ....
</acute_overdracht>
```
Het root element is altijd de naam van een transactie. Hier wordt - net als voor alle elementnamen - 
de ADA shortName genomen. Dit is de Nederlandse naam van het concept, maar dan geschikt gemaakt voor
gebruik als XML tagnaam. Concreet betekent dit:

* alleen lowercase
* whitespace wordt vervangen door een enkele underscore
* diakrieten worden vervangen door gewone letters
* '?' wordt vervangen door een 'q'

Op het root element zitten twee attributen die de versie van de transactie bepalen. Dit zijn:

* transactionRef met het id van de transaction
* versionDate met de timestamp van de release

Met deze twee gegevens en de volgende URI:
``` mustache
https://decor.nictiz.nl/decor/services/RetrieveTransaction?id={{transactionRef}}&version={{versionDate}}&format=xml
```
Zijn de volledige specs in XML te vinden. Met `format=html` dito in HTML.

Dit zijn de enige twee versieaanduidingen.

### Groepen volgen de dataset precies
```xml
<acute_overdracht ....>
    <vrouw>
        <burgerservicenummer value="999995856"/>
    </vrouw>
    <zorgverlenerzorginstelling>
        <zorgverlener>
            <naam_zorgverlener>
                <achternamen value="Gessel"/>
            </naam_zorgverlener>
    ...            
</acute_overdracht>
```
Iedere groep wordt overgenomen van de dataset. Er mag geen groep worden overgeslagen. Dit borgt dat ieder element 
altijd uniek te traceren is met paden: `acute_overdracht/vrouw/burgerservicenummer/@value`
### Gegevens zitten altijd in @value
```xml
<burgerservicenummer value="999995856"/>
```
Identificaties zoals een BSN komen gewoon in de value.
```xml
<naam_zorginstelling value="Verloskundigenpraktijk Astrid Limburg"/>
```
Dito voor strings.
```xml
<bloedgroep_vrouw value="112144000"/>
```
Codes (hier: een Snomed code) worden opgenomen zoals ze in de valueSet voorkomen.

Er is één uitzondering: mocht een code tweemaal voorkomen in één valueSet (dat kan, als
de code uit een ander codesysteem komt), dan wordt de code/codesysteem combinatie vervangen 
door een uniek nummer (binnen die valueSet). Deze situatie komt in PWD 2.2 niet voor.
```xml
<hoeveelheid_bloedverlies value="600"/>
Hoeveelheden worden opgenomen als numerieke waarden. De bijbehorende eenheid is terug te vinden in 
de PWD specificaties.
```
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
<datum_onderzoek value="2019-01-20T13:15:00"/>```
Datums en tijden worden doorgegeven in ISO formaat. Waar tijden worden doorgegeven, wordt de separator 'T' gebruikt.
Er wordt geen timezone doorgegeven.
### Extensies
```xml
<vrouw>
    <burgerservicenummer value="999995856"/>
    <adaextension url="http://www.marcdegraauw.com/extension-example">
        <skype-id value="mgraauw" conceptId="1"/>
    </adaextension>
</vrouw>
```
Leveranciers kunnen gegevens die niet in PWD voorkomen doorgeven in een `adaextension` groep. Deze groep kan (optioneel) voorkomen
als laatste element binnen ieder groepselement.
### Een compleet voorbeeld
```xml
<?xml version="1.0" encoding="UTF-8"?>
<acute_overdracht transactionRef="2.16.840.1.113883.2.4.3.11.60.90.77.4.2301" versionDate="2018-11-09T12:31:45">
    <vrouw>
        <burgerservicenummer value="999995856"/>
        <extension url="http://www.marcdegraauw.com/extension-example">
            <skype-id value="mgraauw" conceptId="1"/>
        </extension>
    </vrouw>
    <zorgverlenerzorginstelling>
        <zorgverlener>
            <naam_zorgverlener>
                <achternamen value="Gessel"/>
            </naam_zorgverlener>
            <zorginstelling>
                <naam_zorginstelling value="Verloskundigenpraktijk Astrid Limburg"/>
            </zorginstelling>
        </zorgverlener>
    </zorgverlenerzorginstelling>
    <bloedgroep_vrouw value="112144000"/>
    <rhesus_d_factor_vrouw value="165747007"/>
    <rhesus_c_factor value="rhcneg"/>
    <obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap>
        <wijze_einde_zwangerschap value="1"/>
        <eerdere_bevalling>
            <hoeveelheid_bloedverlies value="600"/>
            <conditie_perineum_postpartum value="F"/>
            <kindspecifieke_gegevens_vorige_uitkomsten>
                <type_partus value="267278005"/>
                <geboortegewicht value="3810"/>
                <apgarscore_na_5_min value="8"/>
                <vaginale_kunstverlossing/>
            </kindspecifieke_gegevens_vorige_uitkomsten>
        </eerdere_bevalling>
    </obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap>
    <obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap>
        <wijze_einde_zwangerschap value="4"/>
    </obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap>
    <obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap>
        <wijze_einde_zwangerschap value="1"/>
        <eerdere_bevalling>
            <hoeveelheid_bloedverlies value="400"/>
            <conditie_perineum_postpartum value="A"/>
            <kindspecifieke_gegevens_vorige_uitkomsten>
                <type_partus value="48782003"/>
                <geboortegewicht value="3150"/>
                <apgarscore_na_5_min value="10"/>
            </kindspecifieke_gegevens_vorige_uitkomsten>
        </eerdere_bevalling>
    </obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap>
    <zwangerschap>
        <graviditeit value="4"/>
    </zwangerschap>
</acute_overdracht>
```

## Documentatie
Het volledige ADA formaat is gedefinieerd op: https://www.art-decor.org/mediawiki/index.php/ADA_Documentation

PWD specificaties zijn te vinden op: https://decor.nictiz.nl/decor/services/ProjectIndex?prefix=peri20-&format=html
