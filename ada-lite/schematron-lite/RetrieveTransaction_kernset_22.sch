<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        queryBinding="xslt2"
        xml:lang="nl-NL">
   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(kernset_aanleverbericht) eq 1">Fout aantal voorkomens van "Kernset aanleverbericht": <value-of select="count(kernset_aanleverbericht)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Kernset aanleverbericht": Attribuut "transactionRef" ontbreekt</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2410')">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2410"</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2014-10-20T00:00:00')">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2014-10-20T00:00:00"</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Kernset aanleverbericht": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht"><!-- == Check occurrences of children of /kernset_aanleverbericht: == -->
         <assert test="count(zorgverlening) eq 1">Fout aantal voorkomens van "Zorgverlening": <value-of select="count(zorgverlening)"/> (verwacht: 1)</assert>
         <assert test="count(zorgverlenerzorginstelling) eq 1">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 1)</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1)</assert>
         <assert test="count(obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap) ge 0">Fout aantal voorkomens van "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": <value-of select="count(obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap)"/> (verwacht: 0 of meer)</assert>
         <assert test="count(zwangerschap) eq 1">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 1)</assert>
         <assert test="(count(bevalling) ge 0) and (count(bevalling) le 1)">Fout aantal voorkomens van "Bevalling": <value-of select="count(bevalling)"/> (verwacht: 0..1)</assert>
         <assert test="count(uitkomst_per_kind) ge 0">Fout aantal voorkomens van "Uitkomst (per kind)": <value-of select="count(uitkomst_per_kind)"/> (verwacht: 0 of meer)</assert>
         <assert test="count(medisch_onderzoek) ge 0">Fout aantal voorkomens van "Medisch onderzoek": <value-of select="count(medisch_onderzoek)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(postnatale_fase) ge 0) and (count(postnatale_fase) le 1)">Fout aantal voorkomens van "Postnatale fase": <value-of select="count(postnatale_fase)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht: == -->
      <rule context="/kernset_aanleverbericht/*[not(self::zorgverlening)][not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::medisch_onderzoek)][not(self::postnatale_fase)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.4')">Foutieve informatie voor "Zorgverlening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.4"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.17')">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.17"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postnatale fase": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.16')">Foutieve informatie voor "Postnatale fase": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.16"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Postnatale fase": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening: == -->
         <assert test="(count(datum_start_zorgverantwoordelijkheid) ge 0) and (count(datum_start_zorgverantwoordelijkheid) le 1)">Fout aantal voorkomens van "Datum start zorgverantwoordelijkheid": <value-of select="count(datum_start_zorgverantwoordelijkheid)"/> (verwacht: 0..1)</assert>
         <assert test="(count(datum_einde_zorgverantwoordelijkheid) ge 0) and (count(datum_einde_zorgverantwoordelijkheid) le 1)">Fout aantal voorkomens van "Datum einde zorgverantwoordelijkheid": <value-of select="count(datum_einde_zorgverantwoordelijkheid)"/> (verwacht: 0..1)</assert>
         <assert test="count(eindverantwoordelijk_in_welke_perinatale_periodeq) ge 0">Fout aantal voorkomens van "Eindverantwoordelijk in welke perinatale periode?": <value-of select="count(eindverantwoordelijk_in_welke_perinatale_periodeq)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(conclusie_risicostatus_na_intake) ge 0) and (count(conclusie_risicostatus_na_intake) le 1)">Fout aantal voorkomens van "Conclusie risicostatus na intake": <value-of select="count(conclusie_risicostatus_na_intake)"/> (verwacht: 0..1)</assert>
         <assert test="count(zorgverzoekdetails) ge 0">Fout aantal voorkomens van "Zorgverzoekdetails": <value-of select="count(zorgverzoekdetails)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(is_er_sprake_van_overdracht_aanq) ge 0) and (count(is_er_sprake_van_overdracht_aanq) le 1)">Fout aantal voorkomens van "Is er sprake van 'overdracht aan'?": <value-of select="count(is_er_sprake_van_overdracht_aanq)"/> (verwacht: 0..1)</assert>
         <assert test="count(overdrachtdetails) ge 0">Fout aantal voorkomens van "Overdrachtdetails": <value-of select="count(overdrachtdetails)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/*[not(self::datum_start_zorgverantwoordelijkheid)][not(self::datum_einde_zorgverantwoordelijkheid)][not(self::eindverantwoordelijk_in_welke_perinatale_periodeq)][not(self::conclusie_risicostatus_na_intake)][not(self::zorgverzoekdetails)][not(self::is_er_sprake_van_overdracht_aanq)][not(self::overdrachtdetails)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20290')">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20290"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20340')">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20340"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20355')">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20355"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', '7', '8', 'UNK', 'NI'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('start /intake zwangerschapszorg', 'zwangerschap vervolg', 'start baring/ontsluiting', 'uitdrijving', 'nageboortetijdperk', '1e 24 uur postpartum', '2e - 7e dag postpartum', 'follow-up eerste 6 wkn postpartum', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20305')">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20305"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('1e lijn (VIL A)', 'overlegsituatie (VIL B)', '2e lijn (VIL C)', '1e lijn met plaatsindicatie (VIL D)', '3e lijns zorg'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Conclusie risicostatus na intake": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverzoekdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.41')">Foutieve informatie voor "Zorgverzoekdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.41"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverzoekdetails": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20360')">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20360"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overdrachtdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.42')">Foutieve informatie voor "Overdrachtdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.42"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Overdrachtdetails": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails: == -->
         <assert test="(count(overname_van_zorginstelling) ge 0) and (count(overname_van_zorginstelling) le 1)">Fout aantal voorkomens van "Overname van zorginstelling": <value-of select="count(overname_van_zorginstelling)"/> (verwacht: 0..1)</assert>
         <assert test="(count(redenen_van_overname) ge 0) and (count(redenen_van_overname) le 1)">Fout aantal voorkomens van "Redenen van overname": <value-of select="count(redenen_van_overname)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/*[not(self::overname_van_zorginstelling)][not(self::redenen_van_overname)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overname van zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.411')">Foutieve informatie voor "Overname van zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.411"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Overname van zorginstelling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Redenen van overname": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20325')">Foutieve informatie voor "Redenen van overname": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20325"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Redenen van overname": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling: == -->
         <assert test="count(overname_van_zorginstelling_id) ge 0">Fout aantal voorkomens van "Overname van zorginstelling (id)": <value-of select="count(overname_van_zorginstelling_id)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/*[not(self::overname_van_zorginstelling_id)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overname van zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20320')">Foutieve informatie voor "Overname van zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20320"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overname van zorginstelling (id)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Overname van zorginstelling (id)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname: == -->
         <assert test="count(reden_van_overname_lijst_prn) ge 0">Fout aantal voorkomens van "Reden van overname (lijst PRN)": <value-of select="count(reden_van_overname_lijst_prn)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/*[not(self::reden_van_overname_lijst_prn)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20331')">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20331"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '133', '134', '135', '136', '137', '138', '139', '140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '176', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '200', '201', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '216', '217', '218', '219', '220', '221', '222', '223', '224', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '238', '239', '240', '241', '242', '243', '244', '245', '246', '247', '248', '249', '250', '251', '252', '253', '254', '255', '256', '257', '258', '259', '260', '261', '262', '263', '264', '265', '266', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1000', '1010', '1020', '1030', '1040', '1050', '1060', '1070', '1080', '1081', '1082', '1090', '1100', '1110', '1120', '1130', '1140', '1150', '1160', '1170', '1171', '1172', '1180', '1181', '1182', '1183', '1184', '1185', '1186', '1190', '1200', '1210', '1220', '1230', '1240', '1250', '1260', '1270', '1280', '1999', '2000', '2010', '2020', '2021', '2022', '2023', '2030', '2040', '2050', '2060', '2061', '2062', '2070', '2080', '2090', '2999', '3000', '3010', '3011', '3012', '3020', '3021', '3022', '3030', '3031', '3032', '3040', '3041', '3042', '3050', '3060', '3070', '3080', '3081', '3082', '3090', '3091', '3092', '3100', '3110', '3120', '3130', '3140', '3150', '3160', '3161', '3162', '3170', '3180', '3190', '3200', '3210', '3220', '3230', '3250', '3251', '3999', '4000', '4010', '4020', '4030', '4032', '4040', '4050', '4060', '4070', '4080', '4081', '4082', '4083', '4090', '4100', '4110', '4120', '4130', '4140', '4149', '4150', '4151', '4152', '4153', '4160', '4170', '4180', '4190', '4200', '4210', '4220', '4230', '4240', '4250', '4260', '4270', '4271', '4272', '4273', '4274', '4275', '4280', '4281', '4282', '4283', '4284', '4290', '4291', '4292', '4293', '4294', '4300', '4310', '4311', '4312', '4320', '4330', '4340', '4350', '4351', '4360', '4370', '4380', '4390', '4400', '4410', '4420', '4430', '4440', '4441', '4450', '4460', '4470', '4480', '4490', '4500', '4600', '4999', '5000', '5010', '5020', '5030', '5040', '5050', '5060', '5070', '5071', '5080', '5090', '5100', '5110', '5120', '5130', '5140', '5150', '5160', '5170', '5180', '5190', '5200', '5210', '5999', '6000', '6010', '6011', '6012', '6013', '6020', '6030', '6040', '6050', '6060', '6070', '6080', '6090', '6100', '6110', '6499', '6500', '6510', '6520', '6530', '6531', '6532', '6533', '6534', '6540', '6542', '6543', '6544', '6545', '6546', '6547', '6548', '6549', '6550', '6551', '6552', '6553', '6599', '7000', '7100', '7110', '7120', '7130', '7140', '7200', '7210', '7220', '7230', '7240', '7250', '7260', '7270', '7280', '7290', '7300', '7310', '7320', '7499', '8000', '8010', '8020', '8030', '8100', '8110', '8120', '8130', '8200', '8210', '8220', '8230', '8240', '8250', '8260', '8270', '8280', '8499', 'UNK', 'NI', 'NAV', 'OTH'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Indicaties vrouw wegens preëxistente aandoeningen – niet gynaecologisch', 'Epilepsie zonder medicatie', 'Epilepsie met medicatie', 'Neurologische bloedingen: o.a. subarachnoidale bloedingen/aneurysma pre-existent', 'Sclerose multiple preëxistente', 'Hernia nuclei pulposi preëxistente', 'Longfunctiestoornis/COPD preëxistente', 'Astma preëxistente', 'Tuberculose', 'Tuberculose met behandeling preëxistente', 'Tuberculose in de anamnese', 'HIV-infectie preëxistente', 'HBsAg-dragerschap preëxistente', 'Hepatitis C preëxistente', 'Hartafwijking met hemodynamische consequenties moeder', 'Trombose diep veneuse /longembolie preëxistente', 'Stollingsstoornissen preëxistente', 'Nierfunctiestoornissen preëxistente', 'Hypertensie, preëxistente', 'Diabetes mellitus', 'Diabetes mellitus Type I preëxistente', 'Diabetes mellitus Type II preëxistente', 'Schildklieraandoeningen', 'Hyperthyreoidie, geen medicatie, afwezig TSH-receptor antistoffen', 'Hyperthyreoidie, geen medicatie, aanwezig TSH-receptor antistoffen', 'Hyperthyreoidie, met medicatie preëxistente', 'Hypothyreoidie na chirurgische C67 of I-131 goed ingesteld, afwezig TSH-receptor antistoffen', 'Hypothyreoidie na chirurgische of I-131 goed ingesteld, aanwezig TSH-receptor antistoffen', 'Hypothyreoidie, Ziekte Hashimoto, goed ingesteld', 'Hemoglobinopathie preëxistente', 'Inflammatory Bowel Disease (Colitis ulcerosa, M. Crohn)', 'Systeemziekten en zeldzame aandoeningen', 'Harddrugs gebruik (heroïne, methadon, cocaïne, XTC en dergelijke)', 'Alcoholmisbruik preëxistente', 'Psychiatrische stoornissen preëxistente', 'GBS-dragerschap preëxistente', 'Adipositas (morbide = BMI &gt; 35)', 'Reumatoïde artritis', 'Maligniteit in anamnese', 'Overige preëxistente aandoeningen vrouw, niet gynaecologisch', 'Indicaties vrouw wegens preëxistente aandoeningen, gynaecologisch', 'Bekkenbodem reconstructie', 'Portio amputatie, Exconisatie, Cryo- en lisbehandeling', 'Portio amputatie', 'Exconisatie', 'Cryo- en lisbehandeling', 'Myoom enucleatie', 'Cervixcytologie afwijkend (diagnostiek, follow-up)', 'DES-dochter (onbehandeld en onder controle)', 'IUD', 'IUD Niet te verwijderen', 'IUD Status nadat het IUD verwijderd is', 'Fertiliteit (sub) behandeling in anamnese', 'Bekkenafwijking (trauma, symfyseruptuur, rachitis)', 'Besnijdenis/ernstige anatomische afwijking', 'Overige indicaties vrouw wegens preëxistente aandoeningen, gynaecologisch', 'Indicaties vrouw wegens obstetrische anamnese', 'Bloedgroepantagonisme', 'Rhesus, Kell, Duffy, Kidd', 'ABO-antagonisme', 'Zwangerschapshypertensieve syndromen vorige zwangerschap', 'Zwangerschapshypertensie in de vorige zwangerschap', '(Pre-)eclampsie/HELLP–syndroom in de vorige zwangerschap', 'Miskraam herhaald', 'MOLA in anamnese', 'abortus provocatus in anamnese', 'Vroeggeboorte, vorige zwangerschap', 'Vroeggeboorte (&lt;33 weken), vorige zwangerschap', 'Vroeggeboorte (&gt;=33 weken), vorige zwangerschap', 'Cervixinsufficiëntie en/of cerclage', 'Abruptio placentae (Solutio) in anamnese', 'Kunstverlossing vaginaal (forcipale extractie/vacuumextractie) in anamnese', 'Sectio caesarea in anamnese', 'Sectio Caesarea i.a, litteken OUS in anamnese', 'Sectio Caesarea i.a., litteken corporeel in anamnese', 'Dysmaturiteit (geboortegewicht &lt;p5)', 'Geboortegewicht &lt;p5 in anamnese', 'Geboortegewicht &lt;p2.3 in anamnese', 'Asfyxie (Apgar score 5min &lt;7) in anamnese', 'Perinatale sterfte in anamnese', 'Aangeboren afwijkingen en/of erfelijke afwijking eerder kind', 'Haemorrhagia / bloedverlies post partum ten gevolge van episiotomie in anamnese', 'Haemorrhagia/ bloedverlies post partum ten gevolge van cervixruptuur in anamnese', 'Haemorrhagia / bloedverlies post partum, andere oorzaken (&gt;1000 cc) in anamnese', 'Manuele placentaverwijdering in de anamnese', 'Placentaverwijdering manuele in de anamnese', 'Placenta accreta in anamnese', 'Ruptuur totaal in anamnese (wel/geen functioneel herstel)', 'Symfysiolyse in anamnese', 'Depressie post-partum in anamnese', 'Psychose post-partum in anamnese', 'Multipara Grande in anamnese', 'Serotiniteit in anamnese', 'GBS-ziekte eerder kind in anamnese', 'Traumatische partus in de anamnese', 'schouderdystocie in anamnese', 'Overige indicaties vrouw wegens obstetrische anamnese', 'Indicaties vrouw ontstaan/vastgesteld tijdens zwangerschap', 'Termijndiscussie', 'Anemie (Hb &lt; 5,6 mmol/l) tijdens zwangerschap', 'Urineweginfecties tijdens zwangerschap', 'Recidiverende urineweginfecties (2x) in de zwangerschap', 'Pyelitis tijdens zwangerschap', 'Toxoplasmose, diagnostiek en therapie tijdens zwangerschap', 'Rubella tijdens zwangerschap', 'Cytomegalie tijdens zwangerschap', 'Herpes genitalis', 'Herpes genitalis (primo-infect) tijdens zwangerschap', 'Herpes genitalis (recidief) tijdens zwangerschap', 'Herpes labialis tijdens zwangerschap', 'Parvovirusinfectie tijdens zwangerschap', 'Varicella/Zostervirusinfectie tijdens zwangerschap', 'HBsAg-dragerschap tijdens zwangerschap', 'Hepatitis virale A, B, C, D of E tijdens zwangerschap', 'Tuberculose tijdens zwangerschap', 'HIV-infectie / Aids tijdens zwangerschap', 'Infectieverdenking overig', 'Lues tijdens zwangerschap', 'Lues positieve serologie en behandeld tijdens zwangerschap', 'Lues positieve serologie en onbehandeld tijdens zwangerschap', 'Lues primo infectie tijdens zwangerschap', 'HNP ontstaan tijdens zwangerschap', 'Laparotomie tijdens zwangerschap', 'Cervixcytologie PAP III A of hoger tijdens zwangerschap', 'Geneesmiddelengebruik mogelijke effect op zwangere en ongeboren vrucht', 'Harddrugs gebruik (heroïne, methadon, cocaïne, XTC en dergelijke)', 'Alcoholmisbruik tijdens zwangerschap', 'Psychiatrische aandoeningen (neurosen/psychosen) tijdens zwangerschap', 'Hyperemesis gravidarum', 'Extra-uteriene graviditeit (EUG)', 'Prenatale diagnostiek met riscio op aangeboren afwijkingen', 'Vruchtwaterverlies (&lt;37 weken amenorroe) tijdens zwangerschap', 'Diabetes mellitus tijdens zwangerschap', 'Diabetes Mellitus Type I tijdens zwangerschap', 'Diabetes Mellitus type II tijdens zwangerschap', 'Diabetes gravidarum, zonder medicatie', 'Diabetes gravidarum + dieet', 'Diabetes gravidarum met insuline', 'Zwangerschapshypertensie definitie volgens de ISSHP', 'Zwangerschapshypertensie, diastolische RR &gt;= 90 en &lt; 95 mm Hg', 'Zwangerschapshypertensie, diastolische RR &gt;= 95 en &lt; 100 mm Hg', 'Zwangerschapshypertensie, diastolische RR &gt;= 100 mm Hg', 'Zwangerschapshypertensie, systolische RR &gt;140 mm Hg', 'Pre-eclampsie, gesuperponeerde pre-eclampsie, HELLP-syndroom', 'Pre-eclampsie tijdens zwangerschap', 'Pre-eclampsie gesuperponeerde tijdens zwangerschap', 'HELLP-syndroom tijdens zwangerschap', 'Eclampsie', 'Bloedgroepantagonisme', 'Trombose, diepveneus tijdens de zwangerschap', 'Rhesus, Kell, Duffy, Kidd', 'ABO-antagonisme', 'Stollingsstoornissen tijdens zwangerschap', 'Bloedverlies persisterend voor 16 weken tijdens zwangerschap', 'Bloedverlies na 16 weken deze zwangerschap', 'Abruptio placentae deze zwangerschap', 'Placenta praevia tijdens de zwangerschap', 'Groeivertraging foetus tijdens zwangerschap (verdenking op)', 'Positieve dyscongruentie (evaluatie van)', 'Serotiniteit ( &gt; 294 dagen amenorroe)', 'Vroeggeboorte (dreigende) deze zwangerschap', 'Cervixinsufficiëntie tijdens deze zwangerschap', 'Bekkenklachten in deze zwangerschap', 'Meerlingzwangerschap deze zwangerschap', 'Liggingsafwijking à terme (waaronder stuitligging)', 'Niet ingedaalde schedel à terme', 'Niet ingedaalde schedel na het breken van de vliezen (a terme)', 'Zorg geen voorgaande prenatale zorg (± à terme)', 'Afstandskind', 'Intrauteriene vruchtdood', 'Obstetrisch relevante uterus myomatosus', 'Mola deze zwangerschap', 'Minder leven', 'Foetale hartritmestoornis tijdens zwangerschap', 'Overige indicaties vrouw ontstaan/vastgesteld tijdens de zwangerschap', 'Indicaties vrouw ontstaan tijdens bevalling', 'Ligging afwijkend van het kind', 'Foetale nood tekenen van', 'Foetale sterfte durante partu', 'Gebroken vliezen zonder weeën', 'Niet-vorderende ontsluiting', 'Niet-vorderende uitdrijving', 'Bloedverlies overmatig tijdens de baring volgens inschatting zorgverlener', 'Haemorragia/bloedverlies postpartum deze baring', 'Abruptio placentae tijdens de baring', 'Vasa praevia tijdens de baring', 'Retentio placentae, vastzittende placenta', 'Ruptuur totaal deze baring', 'Meconiumhoudend vruchtwater', 'Koorts tijdens de baring', 'Pijnbestrijding/sedatie tijdens de baring', 'Vulvahematoom', 'Symfysiolyse', 'Prenatale zorg geen voorafgaande aan tijdens de baring', 'Placenta Previa tijdens de baring', 'Uterusdehiscentie littekendehiscentie', 'Uterusruptuur (met spill in buikholte)', 'Vaginawandruptuur deze baring', 'Overige indicaties vrouw ontstaan tijdens de bevalling', 'Indicaties vrouw ontstaan tijdens de kraamperiode', '(Dreigende) eclampsie, (verdenking op) HELLP-syndroom', 'Pre-eclampsie tijdens kraamperiode', 'Pre-eclampsie gesuperponeerde tijdens kraamperiode', 'HELLP-syndroom tijdens kraamperiode', 'Trombose diep veneuze tijdens kraamperiode', 'Psychose tijdens kraamperiode', 'Bloedverlies abnormaal vaginaal tijdens kraamperiode', 'Opname-indicatie voor het kind', 'Embolie tijdens kraamperiode', 'Hematoom postpartum', 'Bloedtransfusie postpartum', 'Mastitis tijdens kraamperiode', 'Endometritis tijdens kraamperiode', 'Cystitis en/of urineweg infectie tijdens kraamperiode', 'Overige indicaties vrouw tijdens de kraamperiode', 'Indicaties kind voor opname', 'Zwangerschaps duur als opname indicatie kind', 'Geboortegewicht als opname indicatie kind', 'Problemen partus', 'Kunstverlossing (problemen partus) als opname indicatie kind', 'Liggingsafwijkingen (problemen partus) als opname indicatie kind', 'Langdurig gebroken vliezen (problemen partus) als opname indicatie kind', 'Problemen partus overig als opname indicatie kind', 'Klinische conditie kind', 'Icterus neonatorum', 'Voedingsproblemen/ diarrhee kind', 'Infectieverdenking kind', 'Hartafwijking kind verdenking op', 'Ademhalingsproblemen kind', 'Hypoglycemie', 'Slechte start (verdenking Asfyxie)', 'Aangeboren afwijkingen kind', 'Convulsies kind', 'Huilen Excessief', 'Thrive failure to', 'Klinische condities kind overig', 'Overige indicaties kind voor opname', 'Medisch, Obstetrische High Care indicatie vrouw en kind wegens', 'Indicatie intensieve maternale bewaking:', 'HELLP syndroom', 'Preeclampsie ernstig', 'Obstetrische complicatie ernstig', 'Maternale OHC indicaties overig', 'Indicatie intensieve foetale bewaking:', 'Foetale groeivertraging met geschat gewicht &lt; 1200 g en/of &lt;32wk', 'Dreigende vroeggeboorte &lt; 32 weken', 'Alle zwangerschappen met hoog-complexe zorg voor foetus', 'Congenitaal afwijkend kind', 'Foetale hartritmestoornis met specifieke bewakingsbehoefte', 'Grote meerling (&gt;= 3)', 'Transfuseur-transfusée syndroom', 'Uitstelprocedure bij meerling (getemporiseerde partus)', 'Overige foetale OHC indicaties', 'Indicatie kraambed bij intensieve neonatale bewaking:', 'kraambed wegens neonaat op NICU', 'kraambed wegens neonaat op intensieve zorg anders dan NICU (bv chirurgie)', 'Overige indicaties vrouw/kind voor Obstetrische High Care', 'Niet medische indicatie vrouw en kind, wegens', 'Begin zorgverlening', 'Zorgverlening afgesloten', 'Adviesconsult', 'Redenen patiënt', 'Verhuizing e.a. logistieke redenen patient', 'Eigen keuze/verzoek patiënt', 'Overige niet medische redenen patiënt', 'Uitbesteding zorg', 'Uitbesteding zorg 1e lijn ivm capaciteitstekort', 'Uitbesteding zorg 1e lijn overige redenen', 'Uitbesteding zorg 2e lijn ivm capaciteitstekort', 'Uitbesteding zorg 2e lijn overige redenen', 'Uitbesteding zorg 3e lijn ivm capaciteitstekort', 'Uitbesteding zorg 3e lijn overige redenen', 'Uitbesteding zorg Pediatrie ivm capaciteitstekort', 'Uitbesteding zorg Pediatrie overige redenen', 'Overige niet medische indicaties vrouw en kind', 'onbekend', 'geen informatie', 'tijdelijk niet beschikbaar', 'anders'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Reden van overname (lijst PRN)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/overdrachtdetails: == -->
         <assert test="(count(datum_van_overdracht) ge 0) and (count(datum_van_overdracht) le 1)">Fout aantal voorkomens van "Datum van overdracht": <value-of select="count(datum_van_overdracht)"/> (verwacht: 0..1)</assert>
         <assert test="(count(overdracht_aan_zorginstelling_specialisme) ge 0) and (count(overdracht_aan_zorginstelling_specialisme) le 1)">Fout aantal voorkomens van "Overdracht aan zorginstelling (specialisme)": <value-of select="count(overdracht_aan_zorginstelling_specialisme)"/> (verwacht: 0..1)</assert>
         <assert test="count(overdracht_aan_zorginstelling_id) ge 0">Fout aantal voorkomens van "Overdracht aan zorginstelling (id)": <value-of select="count(overdracht_aan_zorginstelling_id)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(perinatale_periode_van_overdracht) ge 0) and (count(perinatale_periode_van_overdracht) le 1)">Fout aantal voorkomens van "Perinatale periode van overdracht": <value-of select="count(perinatale_periode_van_overdracht)"/> (verwacht: 0..1)</assert>
         <assert test="(count(redenen_van_overdracht_aan) ge 0) and (count(redenen_van_overdracht_aan) le 1)">Fout aantal voorkomens van "Redenen van 'overdracht aan'": <value-of select="count(redenen_van_overdracht_aan)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/overdrachtdetails: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/*[not(self::datum_van_overdracht)][not(self::overdracht_aan_zorginstelling_specialisme)][not(self::overdracht_aan_zorginstelling_id)][not(self::perinatale_periode_van_overdracht)][not(self::redenen_van_overdracht_aan)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20362')">Foutieve informatie voor "Datum van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20362"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum van overdracht": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum van overdracht": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20366')">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20366"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('01.046', '01.019', 'UNK', 'NI'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Gynaecoloog / obstetricus', 'Kinderarts', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overdracht aan zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20368')">Foutieve informatie voor "Overdracht aan zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20368"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overdracht aan zorginstelling (id)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Overdracht aan zorginstelling (id)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20367')">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20367"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('100', '1', '2', '3', '4', '200', '5', '6', '7', '300', '8', '9', '91', '92', '10', 'UNK', 'NI'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Ante partum', 'Na eerste controle', 'Voor 28e week', '28e tot en met 36e week', 'Vanaf 37e week', 'Durante partu', 'Tijdens ontsluiting', 'Tijdens uitdrijving', 'Nageboortetijdperk', 'Postpartum', 'Direct postpartum', 'Tijdens kraambed', 'Binnen 24 uur', '2e t/m 7e dag', '2e week of later', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Perinatale periode van overdracht": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Redenen van 'overdracht aan'": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20365')">Foutieve informatie voor "Redenen van 'overdracht aan'": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20365"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Redenen van 'overdracht aan'": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan: == -->
         <assert test="count(reden_overdracht_aan_lijst_prn) ge 0">Fout aantal voorkomens van "Reden 'overdracht aan' (lijst PRN)": <value-of select="count(reden_overdracht_aan_lijst_prn)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/*[not(self::reden_overdracht_aan_lijst_prn)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20371')">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20371"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '133', '134', '135', '136', '137', '138', '139', '140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '176', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '200', '201', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '216', '217', '218', '219', '220', '221', '222', '223', '224', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '238', '239', '240', '241', '242', '243', '244', '245', '246', '247', '248', '249', '250', '251', '252', '253', '254', '255', '256', '257', '258', '259', '260', '261', '262', '263', '264', '265', '266', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1000', '1010', '1020', '1030', '1040', '1050', '1060', '1070', '1080', '1081', '1082', '1090', '1100', '1110', '1120', '1130', '1140', '1150', '1160', '1170', '1171', '1172', '1180', '1181', '1182', '1183', '1184', '1185', '1186', '1190', '1200', '1210', '1220', '1230', '1240', '1250', '1260', '1270', '1280', '1999', '2000', '2010', '2020', '2021', '2022', '2023', '2030', '2040', '2050', '2060', '2061', '2062', '2070', '2080', '2090', '2999', '3000', '3010', '3011', '3012', '3020', '3021', '3022', '3030', '3031', '3032', '3040', '3041', '3042', '3050', '3060', '3070', '3080', '3081', '3082', '3090', '3091', '3092', '3100', '3110', '3120', '3130', '3140', '3150', '3160', '3161', '3162', '3170', '3180', '3190', '3200', '3210', '3220', '3230', '3250', '3251', '3999', '4000', '4010', '4020', '4030', '4032', '4040', '4050', '4060', '4070', '4080', '4081', '4082', '4083', '4090', '4100', '4110', '4120', '4130', '4140', '4149', '4150', '4151', '4152', '4153', '4160', '4170', '4180', '4190', '4200', '4210', '4220', '4230', '4240', '4250', '4260', '4270', '4271', '4272', '4273', '4274', '4275', '4280', '4281', '4282', '4283', '4284', '4290', '4291', '4292', '4293', '4294', '4300', '4310', '4311', '4312', '4320', '4330', '4340', '4350', '4351', '4360', '4370', '4380', '4390', '4400', '4410', '4420', '4430', '4440', '4441', '4450', '4460', '4470', '4480', '4490', '4500', '4600', '4999', '5000', '5010', '5020', '5030', '5040', '5050', '5060', '5070', '5071', '5080', '5090', '5100', '5110', '5120', '5130', '5140', '5150', '5160', '5170', '5180', '5190', '5200', '5210', '5999', '6000', '6010', '6011', '6012', '6013', '6020', '6030', '6040', '6050', '6060', '6070', '6080', '6090', '6100', '6110', '6499', '6500', '6510', '6520', '6530', '6531', '6532', '6533', '6534', '6540', '6542', '6543', '6544', '6545', '6546', '6547', '6548', '6549', '6550', '6551', '6552', '6553', '6599', '7000', '7100', '7110', '7120', '7130', '7140', '7200', '7210', '7220', '7230', '7240', '7250', '7260', '7270', '7280', '7290', '7300', '7310', '7320', '7499', '8000', '8010', '8020', '8030', '8100', '8110', '8120', '8130', '8200', '8210', '8220', '8230', '8240', '8250', '8260', '8270', '8280', '8499', 'UNK', 'NI', 'NAV', 'OTH'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Indicaties vrouw wegens preëxistente aandoeningen – niet gynaecologisch', 'Epilepsie zonder medicatie', 'Epilepsie met medicatie', 'Neurologische bloedingen: o.a. subarachnoidale bloedingen/aneurysma pre-existent', 'Sclerose multiple preëxistente', 'Hernia nuclei pulposi preëxistente', 'Longfunctiestoornis/COPD preëxistente', 'Astma preëxistente', 'Tuberculose', 'Tuberculose met behandeling preëxistente', 'Tuberculose in de anamnese', 'HIV-infectie preëxistente', 'HBsAg-dragerschap preëxistente', 'Hepatitis C preëxistente', 'Hartafwijking met hemodynamische consequenties moeder', 'Trombose diep veneuse /longembolie preëxistente', 'Stollingsstoornissen preëxistente', 'Nierfunctiestoornissen preëxistente', 'Hypertensie, preëxistente', 'Diabetes mellitus', 'Diabetes mellitus Type I preëxistente', 'Diabetes mellitus Type II preëxistente', 'Schildklieraandoeningen', 'Hyperthyreoidie, geen medicatie, afwezig TSH-receptor antistoffen', 'Hyperthyreoidie, geen medicatie, aanwezig TSH-receptor antistoffen', 'Hyperthyreoidie, met medicatie preëxistente', 'Hypothyreoidie na chirurgische C67 of I-131 goed ingesteld, afwezig TSH-receptor antistoffen', 'Hypothyreoidie na chirurgische of I-131 goed ingesteld, aanwezig TSH-receptor antistoffen', 'Hypothyreoidie, Ziekte Hashimoto, goed ingesteld', 'Hemoglobinopathie preëxistente', 'Inflammatory Bowel Disease (Colitis ulcerosa, M. Crohn)', 'Systeemziekten en zeldzame aandoeningen', 'Harddrugs gebruik (heroïne, methadon, cocaïne, XTC en dergelijke)', 'Alcoholmisbruik preëxistente', 'Psychiatrische stoornissen preëxistente', 'GBS-dragerschap preëxistente', 'Adipositas (morbide = BMI &gt; 35)', 'Reumatoïde artritis', 'Maligniteit in anamnese', 'Overige preëxistente aandoeningen vrouw, niet gynaecologisch', 'Indicaties vrouw wegens preëxistente aandoeningen, gynaecologisch', 'Bekkenbodem reconstructie', 'Portio amputatie, Exconisatie, Cryo- en lisbehandeling', 'Portio amputatie', 'Exconisatie', 'Cryo- en lisbehandeling', 'Myoom enucleatie', 'Cervixcytologie afwijkend (diagnostiek, follow-up)', 'DES-dochter (onbehandeld en onder controle)', 'IUD', 'IUD Niet te verwijderen', 'IUD Status nadat het IUD verwijderd is', 'Fertiliteit (sub) behandeling in anamnese', 'Bekkenafwijking (trauma, symfyseruptuur, rachitis)', 'Besnijdenis/ernstige anatomische afwijking', 'Overige indicaties vrouw wegens preëxistente aandoeningen, gynaecologisch', 'Indicaties vrouw wegens obstetrische anamnese', 'Bloedgroepantagonisme', 'Rhesus, Kell, Duffy, Kidd', 'ABO-antagonisme', 'Zwangerschapshypertensieve syndromen vorige zwangerschap', 'Zwangerschapshypertensie in de vorige zwangerschap', '(Pre-)eclampsie/HELLP–syndroom in de vorige zwangerschap', 'Miskraam herhaald', 'MOLA in anamnese', 'abortus provocatus in anamnese', 'Vroeggeboorte, vorige zwangerschap', 'Vroeggeboorte (&lt;33 weken), vorige zwangerschap', 'Vroeggeboorte (&gt;=33 weken), vorige zwangerschap', 'Cervixinsufficiëntie en/of cerclage', 'Abruptio placentae (Solutio) in anamnese', 'Kunstverlossing vaginaal (forcipale extractie/vacuumextractie) in anamnese', 'Sectio caesarea in anamnese', 'Sectio Caesarea i.a, litteken OUS in anamnese', 'Sectio Caesarea i.a., litteken corporeel in anamnese', 'Dysmaturiteit (geboortegewicht &lt;p5)', 'Geboortegewicht &lt;p5 in anamnese', 'Geboortegewicht &lt;p2.3 in anamnese', 'Asfyxie (Apgar score 5min &lt;7) in anamnese', 'Perinatale sterfte in anamnese', 'Aangeboren afwijkingen en/of erfelijke afwijking eerder kind', 'Haemorrhagia / bloedverlies post partum ten gevolge van episiotomie in anamnese', 'Haemorrhagia/ bloedverlies post partum ten gevolge van cervixruptuur in anamnese', 'Haemorrhagia / bloedverlies post partum, andere oorzaken (&gt;1000 cc) in anamnese', 'Manuele placentaverwijdering in de anamnese', 'Placentaverwijdering manuele in de anamnese', 'Placenta accreta in anamnese', 'Ruptuur totaal in anamnese (wel/geen functioneel herstel)', 'Symfysiolyse in anamnese', 'Depressie post-partum in anamnese', 'Psychose post-partum in anamnese', 'Multipara Grande in anamnese', 'Serotiniteit in anamnese', 'GBS-ziekte eerder kind in anamnese', 'Traumatische partus in de anamnese', 'schouderdystocie in anamnese', 'Overige indicaties vrouw wegens obstetrische anamnese', 'Indicaties vrouw ontstaan/vastgesteld tijdens zwangerschap', 'Termijndiscussie', 'Anemie (Hb &lt; 5,6 mmol/l) tijdens zwangerschap', 'Urineweginfecties tijdens zwangerschap', 'Recidiverende urineweginfecties (2x) in de zwangerschap', 'Pyelitis tijdens zwangerschap', 'Toxoplasmose, diagnostiek en therapie tijdens zwangerschap', 'Rubella tijdens zwangerschap', 'Cytomegalie tijdens zwangerschap', 'Herpes genitalis', 'Herpes genitalis (primo-infect) tijdens zwangerschap', 'Herpes genitalis (recidief) tijdens zwangerschap', 'Herpes labialis tijdens zwangerschap', 'Parvovirusinfectie tijdens zwangerschap', 'Varicella/Zostervirusinfectie tijdens zwangerschap', 'HBsAg-dragerschap tijdens zwangerschap', 'Hepatitis virale A, B, C, D of E tijdens zwangerschap', 'Tuberculose tijdens zwangerschap', 'HIV-infectie / Aids tijdens zwangerschap', 'Infectieverdenking overig', 'Lues tijdens zwangerschap', 'Lues positieve serologie en behandeld tijdens zwangerschap', 'Lues positieve serologie en onbehandeld tijdens zwangerschap', 'Lues primo infectie tijdens zwangerschap', 'HNP ontstaan tijdens zwangerschap', 'Laparotomie tijdens zwangerschap', 'Cervixcytologie PAP III A of hoger tijdens zwangerschap', 'Geneesmiddelengebruik mogelijke effect op zwangere en ongeboren vrucht', 'Harddrugs gebruik (heroïne, methadon, cocaïne, XTC en dergelijke)', 'Alcoholmisbruik tijdens zwangerschap', 'Psychiatrische aandoeningen (neurosen/psychosen) tijdens zwangerschap', 'Hyperemesis gravidarum', 'Extra-uteriene graviditeit (EUG)', 'Prenatale diagnostiek met riscio op aangeboren afwijkingen', 'Vruchtwaterverlies (&lt;37 weken amenorroe) tijdens zwangerschap', 'Diabetes mellitus tijdens zwangerschap', 'Diabetes Mellitus Type I tijdens zwangerschap', 'Diabetes Mellitus type II tijdens zwangerschap', 'Diabetes gravidarum, zonder medicatie', 'Diabetes gravidarum + dieet', 'Diabetes gravidarum met insuline', 'Zwangerschapshypertensie definitie volgens de ISSHP', 'Zwangerschapshypertensie, diastolische RR &gt;= 90 en &lt; 95 mm Hg', 'Zwangerschapshypertensie, diastolische RR &gt;= 95 en &lt; 100 mm Hg', 'Zwangerschapshypertensie, diastolische RR &gt;= 100 mm Hg', 'Zwangerschapshypertensie, systolische RR &gt;140 mm Hg', 'Pre-eclampsie, gesuperponeerde pre-eclampsie, HELLP-syndroom', 'Pre-eclampsie tijdens zwangerschap', 'Pre-eclampsie gesuperponeerde tijdens zwangerschap', 'HELLP-syndroom tijdens zwangerschap', 'Eclampsie', 'Bloedgroepantagonisme', 'Trombose, diepveneus tijdens de zwangerschap', 'Rhesus, Kell, Duffy, Kidd', 'ABO-antagonisme', 'Stollingsstoornissen tijdens zwangerschap', 'Bloedverlies persisterend voor 16 weken tijdens zwangerschap', 'Bloedverlies na 16 weken deze zwangerschap', 'Abruptio placentae deze zwangerschap', 'Placenta praevia tijdens de zwangerschap', 'Groeivertraging foetus tijdens zwangerschap (verdenking op)', 'Positieve dyscongruentie (evaluatie van)', 'Serotiniteit ( &gt; 294 dagen amenorroe)', 'Vroeggeboorte (dreigende) deze zwangerschap', 'Cervixinsufficiëntie tijdens deze zwangerschap', 'Bekkenklachten in deze zwangerschap', 'Meerlingzwangerschap deze zwangerschap', 'Liggingsafwijking à terme (waaronder stuitligging)', 'Niet ingedaalde schedel à terme', 'Niet ingedaalde schedel na het breken van de vliezen (a terme)', 'Zorg geen voorgaande prenatale zorg (± à terme)', 'Afstandskind', 'Intrauteriene vruchtdood', 'Obstetrisch relevante uterus myomatosus', 'Mola deze zwangerschap', 'Minder leven', 'Foetale hartritmestoornis tijdens zwangerschap', 'Overige indicaties vrouw ontstaan/vastgesteld tijdens de zwangerschap', 'Indicaties vrouw ontstaan tijdens bevalling', 'Ligging afwijkend van het kind', 'Foetale nood tekenen van', 'Foetale sterfte durante partu', 'Gebroken vliezen zonder weeën', 'Niet-vorderende ontsluiting', 'Niet-vorderende uitdrijving', 'Bloedverlies overmatig tijdens de baring volgens inschatting zorgverlener', 'Haemorragia/bloedverlies postpartum deze baring', 'Abruptio placentae tijdens de baring', 'Vasa praevia tijdens de baring', 'Retentio placentae, vastzittende placenta', 'Ruptuur totaal deze baring', 'Meconiumhoudend vruchtwater', 'Koorts tijdens de baring', 'Pijnbestrijding/sedatie tijdens de baring', 'Vulvahematoom', 'Symfysiolyse', 'Prenatale zorg geen voorafgaande aan tijdens de baring', 'Placenta Previa tijdens de baring', 'Uterusdehiscentie littekendehiscentie', 'Uterusruptuur (met spill in buikholte)', 'Vaginawandruptuur deze baring', 'Overige indicaties vrouw ontstaan tijdens de bevalling', 'Indicaties vrouw ontstaan tijdens de kraamperiode', '(Dreigende) eclampsie, (verdenking op) HELLP-syndroom', 'Pre-eclampsie tijdens kraamperiode', 'Pre-eclampsie gesuperponeerde tijdens kraamperiode', 'HELLP-syndroom tijdens kraamperiode', 'Trombose diep veneuze tijdens kraamperiode', 'Psychose tijdens kraamperiode', 'Bloedverlies abnormaal vaginaal tijdens kraamperiode', 'Opname-indicatie voor het kind', 'Embolie tijdens kraamperiode', 'Hematoom postpartum', 'Bloedtransfusie postpartum', 'Mastitis tijdens kraamperiode', 'Endometritis tijdens kraamperiode', 'Cystitis en/of urineweg infectie tijdens kraamperiode', 'Overige indicaties vrouw tijdens de kraamperiode', 'Indicaties kind voor opname', 'Zwangerschaps duur als opname indicatie kind', 'Geboortegewicht als opname indicatie kind', 'Problemen partus', 'Kunstverlossing (problemen partus) als opname indicatie kind', 'Liggingsafwijkingen (problemen partus) als opname indicatie kind', 'Langdurig gebroken vliezen (problemen partus) als opname indicatie kind', 'Problemen partus overig als opname indicatie kind', 'Klinische conditie kind', 'Icterus neonatorum', 'Voedingsproblemen/ diarrhee kind', 'Infectieverdenking kind', 'Hartafwijking kind verdenking op', 'Ademhalingsproblemen kind', 'Hypoglycemie', 'Slechte start (verdenking Asfyxie)', 'Aangeboren afwijkingen kind', 'Convulsies kind', 'Huilen Excessief', 'Thrive failure to', 'Klinische condities kind overig', 'Overige indicaties kind voor opname', 'Medisch, Obstetrische High Care indicatie vrouw en kind wegens', 'Indicatie intensieve maternale bewaking:', 'HELLP syndroom', 'Preeclampsie ernstig', 'Obstetrische complicatie ernstig', 'Maternale OHC indicaties overig', 'Indicatie intensieve foetale bewaking:', 'Foetale groeivertraging met geschat gewicht &lt; 1200 g en/of &lt;32wk', 'Dreigende vroeggeboorte &lt; 32 weken', 'Alle zwangerschappen met hoog-complexe zorg voor foetus', 'Congenitaal afwijkend kind', 'Foetale hartritmestoornis met specifieke bewakingsbehoefte', 'Grote meerling (&gt;= 3)', 'Transfuseur-transfusée syndroom', 'Uitstelprocedure bij meerling (getemporiseerde partus)', 'Overige foetale OHC indicaties', 'Indicatie kraambed bij intensieve neonatale bewaking:', 'kraambed wegens neonaat op NICU', 'kraambed wegens neonaat op intensieve zorg anders dan NICU (bv chirurgie)', 'Overige indicaties vrouw/kind voor Obstetrische High Care', 'Niet medische indicatie vrouw en kind, wegens', 'Begin zorgverlening', 'Zorgverlening afgesloten', 'Adviesconsult', 'Redenen patiënt', 'Verhuizing e.a. logistieke redenen patient', 'Eigen keuze/verzoek patiënt', 'Overige niet medische redenen patiënt', 'Uitbesteding zorg', 'Uitbesteding zorg 1e lijn ivm capaciteitstekort', 'Uitbesteding zorg 1e lijn overige redenen', 'Uitbesteding zorg 2e lijn ivm capaciteitstekort', 'Uitbesteding zorg 2e lijn overige redenen', 'Uitbesteding zorg 3e lijn ivm capaciteitstekort', 'Uitbesteding zorg 3e lijn overige redenen', 'Uitbesteding zorg Pediatrie ivm capaciteitstekort', 'Uitbesteding zorg Pediatrie overige redenen', 'Overige niet medische indicaties vrouw en kind', 'onbekend', 'geen informatie', 'tijdelijk niet beschikbaar', 'anders'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlenerzorginstelling: == -->
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlenerzorginstelling: == -->
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/*[not(self::zorginstelling)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="count(zorginstelling_lvrid) eq 1">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_lvrid)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw: == -->
         <assert test="(count(burgerservicenummer) ge 0) and (count(burgerservicenummer) le 1)">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 0..1)</assert>
         <assert test="(count(lokale_persoonsidentificatie) ge 0) and (count(lokale_persoonsidentificatie) le 1)">Fout aantal voorkomens van "Lokale persoonsidentificatie": <value-of select="count(lokale_persoonsidentificatie)"/> (verwacht: 0..1)</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1)</assert>
         <assert test="(count(adres) ge 0) and (count(adres) le 1)">Fout aantal voorkomens van "Adres": <value-of select="count(adres)"/> (verwacht: 0..1)</assert>
         <assert test="(count(etniciteit) ge 0) and (count(etniciteit) le 1)">Fout aantal voorkomens van "Etniciteit": <value-of select="count(etniciteit)"/> (verwacht: 0..1)</assert>
         <assert test="(count(anamnese) ge 0) and (count(anamnese) le 1)">Fout aantal voorkomens van "Anamnese": <value-of select="count(anamnese)"/> (verwacht: 0..1)</assert>
         <assert test="(count(lengte_gemeten) ge 0) and (count(lengte_gemeten) le 1)">Fout aantal voorkomens van "Lengte (gemeten)": <value-of select="count(lengte_gemeten)"/> (verwacht: 0..1)</assert>
         <assert test="(count(vrouwelijke_genitale_verminkingq) ge 0) and (count(vrouwelijke_genitale_verminkingq) le 1)">Fout aantal voorkomens van "Vrouwelijke genitale verminking?": <value-of select="count(vrouwelijke_genitale_verminkingq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(type_vrouwelijke_genitale_verminking) ge 0) and (count(type_vrouwelijke_genitale_verminking) le 1)">Fout aantal voorkomens van "Type vrouwelijke genitale verminking": <value-of select="count(type_vrouwelijke_genitale_verminking)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw: == -->
      <rule context="/kernset_aanleverbericht/vrouw/*[not(self::burgerservicenummer)][not(self::lokale_persoonsidentificatie)][not(self::geboortedatum)][not(self::adres)][not(self::etniciteit)][not(self::anamnese)][not(self::lengte_gemeten)][not(self::vrouwelijke_genitale_verminkingq)][not(self::type_vrouwelijke_genitale_verminking)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lokale persoonsidentificatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10031')">Foutieve informatie voor "Lokale persoonsidentificatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10031"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Lokale persoonsidentificatie": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Lokale persoonsidentificatie": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/geboortedatum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/adres: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/adres"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adres": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10300')">Foutieve informatie voor "Adres": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10300"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Adres": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/etniciteit: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/etniciteit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10400')">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10400"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('14', '13', '12', '3', '4', '5', '8', '11', 'UNK'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Latijns Amerikaans', 'Hindoestaans', 'Kaukasisch', 'Noord-Afrikaans', 'Overig Afrikaans', 'Turks', 'Overig Aziatisch', 'Meervoudige afkomst / Overig', 'onbekend'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Etniciteit": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811')">Foutieve informatie voor "Anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Anamnese": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/lengte_gemeten: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/lengte_gemeten"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20212')">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20212"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Lengte (gemeten)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 60)">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 60 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 270)">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 270 zijn</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'cm')">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "cm"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Lengte (gemeten)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouwelijke genitale verminking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80675')">Foutieve informatie voor "Vrouwelijke genitale verminking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80675"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Vrouwelijke genitale verminking?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Vrouwelijke genitale verminking?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Vrouwelijke genitale verminking?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80676')">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80676"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('130631000119108', '130621000119105', '130611000119103', '107411000119108', 'UNK', 'NI'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Female genital mutilation type 1 (disorder)', 'Female genital mutilation type 2 (disorder)', 'Female genital mutilation type 3 (disorder)', 'Female genital mutilation type 4 (disorder)', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type vrouwelijke genitale verminking": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/adres"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw/adres: == -->
         <assert test="(count(postcode) ge 0) and (count(postcode) le 1)">Fout aantal voorkomens van "Postcode": <value-of select="count(postcode)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw/adres: == -->
      <rule context="/kernset_aanleverbericht/vrouw/adres/*[not(self::postcode)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/adres/postcode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/adres/postcode"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10304')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10304"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Postcode": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw/anamnese: == -->
         <assert test="(count(onder_behandeling_geweestq) ge 0) and (count(onder_behandeling_geweestq) le 1)">Fout aantal voorkomens van "Onder behandeling (geweest)?": <value-of select="count(onder_behandeling_geweestq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(algemene_anamnese) ge 0) and (count(algemene_anamnese) le 1)">Fout aantal voorkomens van "Algemene anamnese": <value-of select="count(algemene_anamnese)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw/anamnese: == -->
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/*[not(self::onder_behandeling_geweestq)][not(self::algemene_anamnese)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Onder behandeling (geweest)?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82020')">Foutieve informatie voor "Onder behandeling (geweest)?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82020"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Onder behandeling (geweest)?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Onder behandeling (geweest)?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Onder behandeling (geweest)?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Algemene anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80904')">Foutieve informatie voor "Algemene anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80904"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Algemene anamnese": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese: == -->
         <assert test="(count(autoimmuun_aandoeningq) ge 0) and (count(autoimmuun_aandoeningq) le 1)">Fout aantal voorkomens van "Auto-immuun aandoening?": <value-of select="count(autoimmuun_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(autoimmuun_aandoening) ge 0">Fout aantal voorkomens van "Auto-immuun aandoening": <value-of select="count(autoimmuun_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(cardiovasculaire_aandoeningq) ge 0) and (count(cardiovasculaire_aandoeningq) le 1)">Fout aantal voorkomens van "Cardiovasculaire aandoening?": <value-of select="count(cardiovasculaire_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(cardiovasculaire_aandoening) ge 0">Fout aantal voorkomens van "Cardiovasculaire aandoening": <value-of select="count(cardiovasculaire_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(urogenitale_aandoeningq) ge 0) and (count(urogenitale_aandoeningq) le 1)">Fout aantal voorkomens van "Urogenitale aandoening?": <value-of select="count(urogenitale_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(urogenitale_aandoening) ge 0">Fout aantal voorkomens van "Urogenitale aandoening": <value-of select="count(urogenitale_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(oncologische_aandoeningq) ge 0) and (count(oncologische_aandoeningq) le 1)">Fout aantal voorkomens van "Oncologische aandoening?": <value-of select="count(oncologische_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(oncologische_aandoening) ge 0">Fout aantal voorkomens van "Oncologische aandoening": <value-of select="count(oncologische_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(schildklier_aandoeningq) ge 0) and (count(schildklier_aandoeningq) le 1)">Fout aantal voorkomens van "Schildklier aandoening?": <value-of select="count(schildklier_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(schildklier_aandoening) ge 0) and (count(schildklier_aandoening) le 1)">Fout aantal voorkomens van "Schildklier aandoening": <value-of select="count(schildklier_aandoening)"/> (verwacht: 0..1)</assert>
         <assert test="(count(diabetes_mellitusq) ge 0) and (count(diabetes_mellitusq) le 1)">Fout aantal voorkomens van "Diabetes mellitus?": <value-of select="count(diabetes_mellitusq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(neurologische_aandoeningq) ge 0) and (count(neurologische_aandoeningq) le 1)">Fout aantal voorkomens van "Neurologische aandoening?": <value-of select="count(neurologische_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(neurologische_aandoening) ge 0">Fout aantal voorkomens van "Neurologische aandoening": <value-of select="count(neurologische_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(infectieziekteq) ge 0) and (count(infectieziekteq) le 1)">Fout aantal voorkomens van "Infectieziekte?": <value-of select="count(infectieziekteq)"/> (verwacht: 0..1)</assert>
         <assert test="count(infectieziekte) ge 0">Fout aantal voorkomens van "Infectieziekte": <value-of select="count(infectieziekte)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(mdl_aandoeningq) ge 0) and (count(mdl_aandoeningq) le 1)">Fout aantal voorkomens van "MDL aandoening?": <value-of select="count(mdl_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(mdl_aandoening) ge 0">Fout aantal voorkomens van "MDL aandoening": <value-of select="count(mdl_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(anemieq) ge 0) and (count(anemieq) le 1)">Fout aantal voorkomens van "Anemie?": <value-of select="count(anemieq)"/> (verwacht: 0..1)</assert>
         <assert test="count(anemie) ge 0">Fout aantal voorkomens van "Anemie": <value-of select="count(anemie)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(longaandoeningq) ge 0) and (count(longaandoeningq) le 1)">Fout aantal voorkomens van "Longaandoening?": <value-of select="count(longaandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(longaandoening) ge 0">Fout aantal voorkomens van "Longaandoening": <value-of select="count(longaandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(gynaecologische_aandoeningq) ge 0) and (count(gynaecologische_aandoeningq) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening?": <value-of select="count(gynaecologische_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(gynaecologische_aandoening) ge 0">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(orthopedische_afwijkingq) ge 0) and (count(orthopedische_afwijkingq) le 1)">Fout aantal voorkomens van "Orthopedische afwijking?": <value-of select="count(orthopedische_afwijkingq)"/> (verwacht: 0..1)</assert>
         <assert test="count(orthopedische_afwijking) ge 0">Fout aantal voorkomens van "Orthopedische afwijking": <value-of select="count(orthopedische_afwijking)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(bloedtransfusieq) ge 0) and (count(bloedtransfusieq) le 1)">Fout aantal voorkomens van "Bloedtransfusie?": <value-of select="count(bloedtransfusieq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(transfusiereactieq) ge 0) and (count(transfusiereactieq) le 1)">Fout aantal voorkomens van "Transfusiereactie?": <value-of select="count(transfusiereactieq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(operatieq) ge 0) and (count(operatieq) le 1)">Fout aantal voorkomens van "Operatie?": <value-of select="count(operatieq)"/> (verwacht: 0..1)</assert>
         <assert test="count(type_operatie) ge 0">Fout aantal voorkomens van "Type operatie": <value-of select="count(type_operatie)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(stollingsprobleemq) ge 0) and (count(stollingsprobleemq) le 1)">Fout aantal voorkomens van "Stollingsprobleem?": <value-of select="count(stollingsprobleemq)"/> (verwacht: 0..1)</assert>
         <assert test="count(type_stollingsprobleem) ge 0">Fout aantal voorkomens van "Type stollingsprobleem": <value-of select="count(type_stollingsprobleem)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(psychiatrieq) ge 0) and (count(psychiatrieq) le 1)">Fout aantal voorkomens van "Psychiatrie?": <value-of select="count(psychiatrieq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(overige_aandoeningq) ge 0) and (count(overige_aandoeningq) le 1)">Fout aantal voorkomens van "Overige aandoening?": <value-of select="count(overige_aandoeningq)"/> (verwacht: 0..1)</assert>
         <assert test="count(overige_aandoening) ge 0">Fout aantal voorkomens van "Overige aandoening": <value-of select="count(overige_aandoening)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese: == -->
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/*[not(self::autoimmuun_aandoeningq)][not(self::autoimmuun_aandoening)][not(self::cardiovasculaire_aandoeningq)][not(self::cardiovasculaire_aandoening)][not(self::urogenitale_aandoeningq)][not(self::urogenitale_aandoening)][not(self::oncologische_aandoeningq)][not(self::oncologische_aandoening)][not(self::schildklier_aandoeningq)][not(self::schildklier_aandoening)][not(self::diabetes_mellitusq)][not(self::neurologische_aandoeningq)][not(self::neurologische_aandoening)][not(self::infectieziekteq)][not(self::infectieziekte)][not(self::mdl_aandoeningq)][not(self::mdl_aandoening)][not(self::anemieq)][not(self::anemie)][not(self::longaandoeningq)][not(self::longaandoening)][not(self::gynaecologische_aandoeningq)][not(self::gynaecologische_aandoening)][not(self::orthopedische_afwijkingq)][not(self::orthopedische_afwijking)][not(self::bloedtransfusieq)][not(self::transfusiereactieq)][not(self::operatieq)][not(self::type_operatie)][not(self::stollingsprobleemq)][not(self::type_stollingsprobleem)][not(self::psychiatrieq)][not(self::overige_aandoeningq)][not(self::overige_aandoening)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Auto-immuun aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80905')">Foutieve informatie voor "Auto-immuun aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80905"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Auto-immuun aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Auto-immuun aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Auto-immuun aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82220')">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82220"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('55464009', '396332003', 'OTH'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Systemic lupus erythematosus (disorder)', 'Rheumatism (disorder)', 'Overig'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Auto-immuun aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cardiovasculaire aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82216')">Foutieve informatie voor "Cardiovasculaire aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82216"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Cardiovasculaire aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cardiovasculaire aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Cardiovasculaire aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80906')">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80906"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('38341003', '85898001', '698247007', '128599005', 'OTH'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Hypertensive disorder, systemic arterial (disorder)', 'Cardiomyopathy (disorder)', 'Cardiac arrhythmia (disorder)', 'Structural disorder of heart (disorder)', 'Overig'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Cardiovasculaire aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urogenitale aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80907')">Foutieve informatie voor "Urogenitale aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80907"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Urogenitale aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Urogenitale aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Urogenitale aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82267')">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82267"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('45816000', '61373006', '236425005'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Pyelonephritis (disorder)', 'Bacteriuria (finding)', 'Chronic renal impairment (disorder)'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Urogenitale aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Oncologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80908')">Foutieve informatie voor "Oncologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80908"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Oncologische aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Oncologische aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Oncologische aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82221')">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82221"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('93796005', '285432005', '93143009', '93880001', '372244006', 'OTH'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Primary malignant neoplasm of female breast (disorder)', 'Carcinoma of cervix (disorder)', 'Leukemia, disease (disorder)', 'Primary malignant neoplasm of lung (disorder)', 'Malignant melanoma (disorder)', 'other'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Oncologische aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Schildklier aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82217')">Foutieve informatie voor "Schildklier aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82217"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Schildklier aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Schildklier aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Schildklier aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80909')">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80909"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('40930008', '34486009'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Hypothyroidism (disorder)', 'Hyperthyroidism (disorder)'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Schildklier aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes mellitus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80910')">Foutieve informatie voor "Diabetes mellitus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80910"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Diabetes mellitus?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes mellitus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Diabetes mellitus?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Neurologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82218')">Foutieve informatie voor "Neurologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82218"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Neurologische aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Neurologische aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Neurologische aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80912')">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80912"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('84757009', '230690007', '24700007', '37796009', '84857004', '399244003', 'OTH'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Epilepsy (disorder)', 'Cerebrovascular accident (disorder)', 'Multiple sclerosis (disorder)', 'Migraine (disorder)', 'Herniation of nucleus pulposus (disorder)', 'Disease of pituitary gland (disorder)', 'Overig'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Neurologische aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectieziekte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80913')">Foutieve informatie voor "Infectieziekte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80913"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Infectieziekte?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Infectieziekte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Infectieziekte?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82210')">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82210"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('87628006', '240589008', '15628003', '426933007', '266096002', '56717001', '34014006', '28944009', '23513009', '165806002', '86406008', '66071002', '50711007', '36653000', '309465005', '186748004', '17322007', '76272004', '187192000', '23502006', '61462000', '56335008', 'OTH'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Bacterial infectious disease (disorder)', 'Chlamydia trachomatis infection (disorder)', 'Gonorrhea (disorder)', 'Streptococcus agalactiae infection (disorder)', 'Methicillin resistant Staphylococcus aureus infection (disorder)', 'Tuberculosis (disorder)', 'Viral disease (disorder)', 'Cytomegalovirus infection (disorder)', 'Herpesvirus infection (disorder)', 'Hepatitis B surface antigen positive (finding)', 'Human immunodeficiency virus infection (disorder)', 'Type B viral hepatitis (disorder)', 'Viral hepatitis C (disorder)', 'Rubella (disorder)', 'Varicella-zoster virus infection (disorder)', 'Parvovirus infection (disorder)', 'Disease caused by parasite (disorder)', 'Syphilis (disorder)', 'Toxoplasmosis (disorder)', 'Lyme disease (disorder)', 'Malaria (disorder)', 'Infection by Trichomonas (disorder)', 'Overig'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Infectieziekte": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "MDL aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80914')">Foutieve informatie voor "MDL aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80914"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "MDL aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "MDL aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "MDL aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82219')">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82219"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('328383001', '64766004', '34000006'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Chronic liver disease (disorder)', 'Ulcerative colitis (disorder)', 'Crohn''s disease (disorder)'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "MDL aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anemie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80915')">Foutieve informatie voor "Anemie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80915"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Anemie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Anemie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Anemie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anemie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82222')">Foutieve informatie voor "Anemie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82222"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('87522002', '80141007', '127040003', '40108008'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Iron deficiency anemia (disorder)', 'Hemoglobinopathy (disorder)', 'Hereditary hemoglobinopathy disorder homozygous for hemoglobin S (disorder)', 'Thalassemia (disorder)'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Anemie": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Longaandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80916')">Foutieve informatie voor "Longaandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80916"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Longaandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Longaandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Longaandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82266')">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82266"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('195967001', '13645005', '31541009', 'OTH', 'NI'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Asthma (disorder)', 'Chronic obstructive lung disease (disorder)', 'Sarcoidosis (disorder)', 'Overig', 'Geen informatie'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Longaandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82211')">Foutieve informatie voor "Gynaecologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82211"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gynaecologische aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Gynaecologische aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80917')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80917"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Endometriosis (disorder)', 'Uterine leiomyoma (disorder)', 'Congenital uterine anomaly (disorder)', 'Overig'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Orthopedische afwijking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82213')">Foutieve informatie voor "Orthopedische afwijking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82213"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Orthopedische afwijking?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Orthopedische afwijking?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Orthopedische afwijking?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80918')">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80918"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('48334007', '282771003', 'OTH'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Congenital dislocation of hip (disorder)', 'Pelvic injury (disorder)', 'Overig'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Orthopedische afwijking": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedtransfusie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10805')">Foutieve informatie voor "Bloedtransfusie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10805"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bloedtransfusie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedtransfusie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Bloedtransfusie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Transfusiereactie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82231')">Foutieve informatie voor "Transfusiereactie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82231"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Transfusiereactie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Transfusiereactie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Transfusiereactie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Operatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80939')">Foutieve informatie voor "Operatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80939"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Operatie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Operatie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Operatie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80818')">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80818"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('12658000', '68688001', '11466000', '28233006', '79876008', '42010004', '64887002', '112697007', '12745006', '129152004:260686004=129284003', '21371007', '86481000', '80146002', '177250006', '34853001', '392090004', '118717007:260686004=129284003', '175898006', '15463004', '64915003', '13119002', '16545005', 'UNK', 'OTH'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Operation on female genital organs (procedure)', 'Curettage (procedure)', 'Cesarean section (procedure)', 'Manual removal of retained placenta (procedure)', 'Operation on uterus (procedure)', 'Uterine myomectomy (procedure)', 'Operation on ovary (procedure)', 'Operation on musculoskeletal system (procedure)', 'Operative procedure on pelvis (procedure)', 'Operation on back (procedure)', 'Operation on abdominal region (procedure)', 'Laparotomy (procedure)', 'Appendectomy (procedure)', 'Abdominoplasty (procedure)', 'Operation on intestine (procedure)', 'Operation on breast (procedure)', 'Operation on organ (procedure)', 'Kidney operation (procedure)', 'Operation on thyroid gland (procedure)', 'Operation on heart (procedure)', 'Operation on adrenal gland (procedure)', 'Operation on nervous system (procedure)', 'Onbekend', 'Overig'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type operatie": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Stollingsprobleem?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80940')">Foutieve informatie voor "Stollingsprobleem?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80940"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Stollingsprobleem?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Stollingsprobleem?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Stollingsprobleem?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80817')">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80817"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('128105004', '90935002', '302215000', '67406007', '234467004', '36351005', '76407009', '1563006', '307116001', '307115002', '46981006', '128053003', '59282003', 'OTH'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('von Willebrand disorder (disorder)', 'Hemophilia (disorder)', 'Thrombocytopenic disorder (disorder)', 'Disseminated intravascular coagulation (disorder)', 'Thrombophilia (disorder)', 'Antithrombin III deficiency (disorder)', 'Protein C deficiency disease (disorder)', 'Protein S deficiency disease (disorder)', 'Heterozygous Factor V Leiden mutation (disorder)', 'Homozygous Factor V Leiden mutation (disorder)', 'Factor XII deficiency disease (disorder)', 'Deep venous thrombosis (disorder)', 'Pulmonary embolism (disorder)', 'Overig'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type stollingsprobleem": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Psychiatrie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82159')">Foutieve informatie voor "Psychiatrie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82159"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Psychiatrie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Psychiatrie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Psychiatrie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82212')">Foutieve informatie voor "Overige aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82212"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overige aandoening?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Overige aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Overige aandoening?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80919')">Foutieve informatie voor "Overige aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80919"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overige aandoening": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Overige aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap: == -->
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1)</assert>
         <assert test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)">Fout aantal voorkomens van "Definitieve à terme datum": <value-of select="count(definitieve_a_terme_datum)"/> (verwacht: 0..1)</assert>
         <assert test="count(diagnose) ge 0">Fout aantal voorkomens van "Diagnose": <value-of select="count(diagnose)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)">Fout aantal voorkomens van "Irregulaire antistoffen?": <value-of select="count(irregulaire_antistoffenq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(eerdere_bevalling) ge 0) and (count(eerdere_bevalling) le 1)">Fout aantal voorkomens van "Eerdere bevalling": <value-of select="count(eerdere_bevalling)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/*[not(self::wijze_einde_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::diagnose)][not(self::irregulaire_antistoffenq)][not(self::eerdere_bevalling)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80623')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80623"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82337')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82337"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Definitieve à terme datum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Definitieve à terme datum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82314')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82314"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82214')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82214"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Irregulaire antistoffen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Eerdere bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.18')">Foutieve informatie voor "Eerdere bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.18"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Eerdere bevalling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose: == -->
         <assert test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0..1)</assert>
         <assert test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)">Fout aantal voorkomens van "Bloedverlies?": <value-of select="count(bloedverliesq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)">Fout aantal voorkomens van "Cervixinsufficiëntie?": <value-of select="count(cervixinsufficientieq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(infectie) ge 0) and (count(infectie) le 1)">Fout aantal voorkomens van "Infectie": <value-of select="count(infectie)"/> (verwacht: 0..1)</assert>
         <assert test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)">Fout aantal voorkomens van "Hyperemesis gravidarum?": <value-of select="count(hyperemesis_gravidarumq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)">Fout aantal voorkomens van "Hypertensieve aandoening": <value-of select="count(hypertensieve_aandoening)"/> (verwacht: 0..1)</assert>
         <assert test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)">Fout aantal voorkomens van "Zwangerschapscholestase?": <value-of select="count(zwangerschapscholestaseq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)">Fout aantal voorkomens van "Diabetes gravidarum met insuline?": <value-of select="count(diabetes_gravidarum_met_insulineq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)">Fout aantal voorkomens van "Afwijkende groei foetus": <value-of select="count(afwijkende_groei_foetus)"/> (verwacht: 0..1)</assert>
         <assert test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)">Fout aantal voorkomens van "Dreigende partus immaturus?": <value-of select="count(dreigende_partus_immaturusq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)">Fout aantal voorkomens van "Dreigende partus prematurus?": <value-of select="count(dreigende_partus_prematurusq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)">Fout aantal voorkomens van "Abruptio placentae?": <value-of select="count(abruptio_placentaeq)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/*[not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82317')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82317"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Endometriosis (disorder)', 'Uterine leiomyoma (disorder)', 'Congenital uterine anomaly (disorder)', 'Overig'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82318')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82318"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bloedverlies?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Bloedverlies?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82320')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82320"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Cervixinsufficiëntie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82321')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82321"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Infection of uterus (disorder)', 'Urinary tract infection in pregnancy (disorder)', 'Pyelonephritis (disorder)', 'Infectious colitis, enteritis and gastroenteritis (disorder)', 'Overig', 'Geen informatie'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Infectie": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82322')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82322"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Hyperemesis gravidarum?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82323')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82323"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Pregnancy-induced hypertension (disorder)', 'Pre-eclampsia (disorder)', 'Hemolysis-elevated liver enzymes-low platelet count syndrome (disorder)', 'Eclampsia (disorder)'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Hypertensieve aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82324')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82324"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zwangerschapscholestase?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82325')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82325"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Diabetes gravidarum met insuline?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82326')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82326"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Large-for-dates fetus (disorder)', 'Small for gestational age fetus (disorder)', 'Geen informatie'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Afwijkende groei foetus": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82327')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82327"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Dreigende partus immaturus?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82328')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82328"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Dreigende partus prematurus?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82329')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82329"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Abruptio placentae?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Abruptio placentae?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling: == -->
         <assert test="(count(placenta) ge 0) and (count(placenta) le 1)">Fout aantal voorkomens van "Placenta": <value-of select="count(placenta)"/> (verwacht: 0..1)</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1)</assert>
         <assert test="count(vorige_uitkomst_per_kind) ge 0">Fout aantal voorkomens van "Vorige uitkomst (per kind)": <value-of select="count(vorige_uitkomst_per_kind)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/*[not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::vorige_uitkomst_per_kind)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80718')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80718"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Placenta": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10598')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10598"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vorige uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.19')">Foutieve informatie voor "Vorige uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.19"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vorige uitkomst (per kind)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta: == -->
         <assert test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)">Fout aantal voorkomens van "Geboorte placenta": <value-of select="count(geboorte_placenta)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/*[not(self::geboorte_placenta)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82336')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82336"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Spontaan', 'Controlled cord traction', 'Manuele placentaverwijdering', 'Placentaverwijdering bij SC', 'Overig', 'Geen informatie', 'Onbekend'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Geboorte placenta": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind: == -->
         <assert test="(count(vorige_baring) ge 0) and (count(vorige_baring) le 1)">Fout aantal voorkomens van "Vorige baring": <value-of select="count(vorige_baring)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/*[not(self::vorige_baring)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vorige baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80709')">Foutieve informatie voor "Vorige baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80709"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vorige baring": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring: == -->
         <assert test="count(demografische_gegevens) ge 0">Fout aantal voorkomens van "Demografische gegevens": <value-of select="count(demografische_gegevens)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(kindspecifieke_gegevens_vorige_uitkomsten) ge 0) and (count(kindspecifieke_gegevens_vorige_uitkomsten) le 1)">Fout aantal voorkomens van "Kindspecifieke gegevens vorige uitkomsten": <value-of select="count(kindspecifieke_gegevens_vorige_uitkomsten)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/*[not(self::demografische_gegevens)][not(self::kindspecifieke_gegevens_vorige_uitkomsten)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80696')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80696"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.21')">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.21"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens: == -->
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/*[not(self::geboortedatum)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80702')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80702"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1)</assert>
         <assert test="(count(percentiel_van_het_geboortegewicht) ge 0) and (count(percentiel_van_het_geboortegewicht) le 1)">Fout aantal voorkomens van "Percentiel van het geboortegewicht": <value-of select="count(percentiel_van_het_geboortegewicht)"/> (verwacht: 0..1)</assert>
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1)</assert>
         <assert test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen?": <value-of select="count(congenitale_afwijkingenq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen (groep)": <value-of select="count(congenitale_afwijkingen_groep)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/*[not(self::type_partus)][not(self::percentiel_van_het_geboortegewicht)][not(self::apgarscore_na_5_min)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80624')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80624"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10605')">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10605"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'NI'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('&lt; 2,3', '2,3 ≤ P &lt; 10', '10 ≤ P &lt; 50', '50 ≤ P &lt; 90', '90 ≤ P ≤ 97,7', '&gt; 97,7', 'Geen informatie'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Percentiel van het geboortegewicht": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10606')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10606"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80997')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80997"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80998')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80998"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep: == -->
         <assert test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)">Fout aantal voorkomens van "Chromosomale afwijkingen?": <value-of select="count(chromosomale_afwijkingenq)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/*[not(self::chromosomale_afwijkingenq)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.81002')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.81002"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Chromosomale afwijkingen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap: == -->
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1)</assert>
         <assert test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)">Fout aantal voorkomens van "Pariteit (vóór deze zwangerschap)": <value-of select="count(pariteit_voor_deze_zwangerschap)"/> (verwacht: 0..1)</assert>
         <assert test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)">Fout aantal voorkomens van "Definitieve à terme datum": <value-of select="count(definitieve_a_terme_datum)"/> (verwacht: 0..1)</assert>
         <assert test="(count(voornemens) ge 0) and (count(voornemens) le 1)">Fout aantal voorkomens van "Voornemens": <value-of select="count(voornemens)"/> (verwacht: 0..1)</assert>
         <assert test="count(prenatale_controle) ge 0">Fout aantal voorkomens van "Prenatale controle": <value-of select="count(prenatale_controle)"/> (verwacht: 0 of meer)</assert>
         <assert test="count(diagnose) ge 0">Fout aantal voorkomens van "Diagnose": <value-of select="count(diagnose)"/> (verwacht: 0 of meer)</assert>
         <assert test="count(intrauteriene_behandeling) ge 0">Fout aantal voorkomens van "Intra-uteriene behandeling": <value-of select="count(intrauteriene_behandeling)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(maternale_sterfteq) ge 0) and (count(maternale_sterfteq) le 1)">Fout aantal voorkomens van "Maternale sterfte?": <value-of select="count(maternale_sterfteq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/*[not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::voornemens)][not(self::prenatale_controle)][not(self::diagnose)][not(self::intrauteriene_behandeling)][not(self::maternale_sterfteq)][not(self::wijze_einde_zwangerschap)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 0)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 30)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Definitieve à terme datum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Definitieve à terme datum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/voornemens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornemens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80671')">Foutieve informatie voor "Voornemens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80671"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Voornemens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prenatale controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80732')">Foutieve informatie voor "Prenatale controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80732"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Prenatale controle": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82230')">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82230"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('45460008', '265633004', '386809009', '177112007', '236949002', 'OTH'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Intrauterine transfusion (procedure)', 'Selective destruction of fetus (procedure)', 'Operation on fetus (procedure)', 'Therapeutic drainage of amniotic fluid (procedure)', 'Operation on placenta (procedure)', 'Overig'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Intra-uteriene behandeling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/maternale_sterfteq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/maternale_sterfteq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20670')">Foutieve informatie voor "Maternale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20670"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Maternale sterfte?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Maternale sterfte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Maternale sterfte?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap/voornemens: == -->
         <assert test="(count(voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie) ge 0) and (count(voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie) le 1)">Fout aantal voorkomens van "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": <value-of select="count(voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap/voornemens: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens/*[not(self::voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20261')">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20261"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('169813005', '23', '22232009', '05', '00', 'UNK', 'NI'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Home birth (finding)', 'Geboortecentrum', 'Hospital (environment)', 'Nog niet bepaald', 'Geen voorkeur', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap/prenatale_controle: == -->
         <assert test="count(datum_controle) eq 1">Fout aantal voorkomens van "Datum controle": <value-of select="count(datum_controle)"/> (verwacht: 1)</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1)</assert>
         <assert test="(count(leven_voelen) ge 0) and (count(leven_voelen) le 1)">Fout aantal voorkomens van "Leven voelen": <value-of select="count(leven_voelen)"/> (verwacht: 0..1)</assert>
         <assert test="(count(rookgedrag) ge 0) and (count(rookgedrag) le 1)">Fout aantal voorkomens van "Rookgedrag": <value-of select="count(rookgedrag)"/> (verwacht: 0..1)</assert>
         <assert test="(count(alcoholgebruik) ge 0) and (count(alcoholgebruik) le 1)">Fout aantal voorkomens van "Alcoholgebruik": <value-of select="count(alcoholgebruik)"/> (verwacht: 0..1)</assert>
         <assert test="(count(drugsgebruikq) ge 0) and (count(drugsgebruikq) le 1)">Fout aantal voorkomens van "Drugsgebruik?": <value-of select="count(drugsgebruikq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(gewicht_gemeten) ge 0) and (count(gewicht_gemeten) le 1)">Fout aantal voorkomens van "Gewicht (gemeten)": <value-of select="count(gewicht_gemeten)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap/prenatale_controle: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/*[not(self::datum_controle)][not(self::zwangerschapsduur)][not(self::leven_voelen)][not(self::rookgedrag)][not(self::alcoholgebruik)][not(self::drugsgebruikq)][not(self::gewicht_gemeten)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80737')">Foutieve informatie voor "Datum controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80737"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum controle": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum controle": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80738')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80738"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80746')">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80746"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('289431008', '276372004', '276369006', '289432001'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Fetal movements present (finding)', 'Weak fetal movements (finding)', 'Reduced fetal movement (finding)', 'Fetal movements absent (context-dependent category)'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Leven voelen": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80810')">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80810"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'UNK'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('niet gerookt', '1 - 10 per dag', '11 - 20 per dag', 'meer dan 20 per dag', 'gestopt vóór huidige zwangerschap', 'gestopt tijdens huidige zwangerschap', 'Unknown'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Rookgedrag": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80747')">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80747"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.59', '2.16.840.1.113883.2.4.4.13.59', '2.16.840.1.113883.2.4.4.13.59'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('geen', '&lt; 2 eenheden per dag', '≥ 2 eenheden per dag'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Alcoholgebruik": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Drugsgebruik?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82102')">Foutieve informatie voor "Drugsgebruik?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82102"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Drugsgebruik?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Drugsgebruik?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Drugsgebruik?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20211')">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20211"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gewicht (gemeten)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 25)">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 25 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 249.9)">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 249.9 zijn</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'kg')">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "kg"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Gewicht (gemeten)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap/diagnose: == -->
         <assert test="(count(datum) ge 0) and (count(datum) le 1)">Fout aantal voorkomens van "Datum": <value-of select="count(datum)"/> (verwacht: 0..1)</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1)</assert>
         <assert test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0..1)</assert>
         <assert test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)">Fout aantal voorkomens van "Bloedverlies?": <value-of select="count(bloedverliesq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(partiele_molaq) ge 0) and (count(partiele_molaq) le 1)">Fout aantal voorkomens van "Partiële mola?": <value-of select="count(partiele_molaq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)">Fout aantal voorkomens van "Cervixinsufficiëntie?": <value-of select="count(cervixinsufficientieq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(infectie) ge 0) and (count(infectie) le 1)">Fout aantal voorkomens van "Infectie": <value-of select="count(infectie)"/> (verwacht: 0..1)</assert>
         <assert test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)">Fout aantal voorkomens van "Hyperemesis gravidarum?": <value-of select="count(hyperemesis_gravidarumq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)">Fout aantal voorkomens van "Hypertensieve aandoening": <value-of select="count(hypertensieve_aandoening)"/> (verwacht: 0..1)</assert>
         <assert test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)">Fout aantal voorkomens van "Zwangerschapscholestase?": <value-of select="count(zwangerschapscholestaseq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)">Fout aantal voorkomens van "Diabetes gravidarum met insuline?": <value-of select="count(diabetes_gravidarum_met_insulineq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)">Fout aantal voorkomens van "Afwijkende groei foetus": <value-of select="count(afwijkende_groei_foetus)"/> (verwacht: 0..1)</assert>
         <assert test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)">Fout aantal voorkomens van "Dreigende partus immaturus?": <value-of select="count(dreigende_partus_immaturusq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)">Fout aantal voorkomens van "Dreigende partus prematurus?": <value-of select="count(dreigende_partus_prematurusq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)">Fout aantal voorkomens van "Abruptio placentae?": <value-of select="count(abruptio_placentaeq)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap/diagnose: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/*[not(self::datum)][not(self::zwangerschapsduur)][not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::partiele_molaq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82272')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82272"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82285')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82285"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Endometriosis (disorder)', 'Uterine leiomyoma (disorder)', 'Congenital uterine anomaly (disorder)', 'Overig'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bloedverlies?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Bloedverlies?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Partiële mola?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82286')">Foutieve informatie voor "Partiële mola?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82286"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Partiële mola?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Partiële mola?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Partiële mola?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Cervixinsufficiëntie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/infectie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/infectie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Infection of uterus (disorder)', 'Urinary tract infection in pregnancy (disorder)', 'Pyelonephritis (disorder)', 'Infectious colitis, enteritis and gastroenteritis (disorder)', 'Overig', 'Geen informatie'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Infectie": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Hyperemesis gravidarum?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Pregnancy-induced hypertension (disorder)', 'Pre-eclampsia (disorder)', 'Hemolysis-elevated liver enzymes-low platelet count syndrome (disorder)', 'Eclampsia (disorder)'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Hypertensieve aandoening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zwangerschapscholestase?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Diabetes gravidarum met insuline?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Large-for-dates fetus (disorder)', 'Small for gestational age fetus (disorder)', 'Geen informatie'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Afwijkende groei foetus": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Dreigende partus immaturus?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Dreigende partus prematurus?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Abruptio placentae?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Abruptio placentae?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling: == -->
         <assert test="(count(partusnummer) ge 0) and (count(partusnummer) le 1)">Fout aantal voorkomens van "Partusnummer": <value-of select="count(partusnummer)"/> (verwacht: 0..1)</assert>
         <assert test="(count(diagnose_bevalling) ge 0) and (count(diagnose_bevalling) le 1)">Fout aantal voorkomens van "Diagnose bevalling": <value-of select="count(diagnose_bevalling)"/> (verwacht: 0..1)</assert>
         <assert test="(count(aantal_geboren_kinderen) ge 0) and (count(aantal_geboren_kinderen) le 1)">Fout aantal voorkomens van "Aantal geboren kinderen": <value-of select="count(aantal_geboren_kinderen)"/> (verwacht: 0..1)</assert>
         <assert test="(count(risicostatus_voor_baring) ge 0) and (count(risicostatus_voor_baring) le 1)">Fout aantal voorkomens van "Risicostatus vóór baring": <value-of select="count(risicostatus_voor_baring)"/> (verwacht: 0..1)</assert>
         <assert test="(count(wijze_waarop_de_baring_begon) ge 0) and (count(wijze_waarop_de_baring_begon) le 1)">Fout aantal voorkomens van "Wijze waarop de baring begon": <value-of select="count(wijze_waarop_de_baring_begon)"/> (verwacht: 0..1)</assert>
         <assert test="count(interventies_begin_baring_groep) ge 0">Fout aantal voorkomens van "Interventies begin baring (groep)": <value-of select="count(interventies_begin_baring_groep)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(tijdstip_begin_actieve_ontsluiting) ge 0) and (count(tijdstip_begin_actieve_ontsluiting) le 1)">Fout aantal voorkomens van "Tijdstip begin actieve ontsluiting": <value-of select="count(tijdstip_begin_actieve_ontsluiting)"/> (verwacht: 0..1)</assert>
         <assert test="(count(bijstimulatie_toegediendq) ge 0) and (count(bijstimulatie_toegediendq) le 1)">Fout aantal voorkomens van "Bijstimulatie toegediend?": <value-of select="count(bijstimulatie_toegediendq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(medicatie_nageboortetijdperk_groep) ge 0) and (count(medicatie_nageboortetijdperk_groep) le 1)">Fout aantal voorkomens van "Medicatie nageboortetijdperk (groep)": <value-of select="count(medicatie_nageboortetijdperk_groep)"/> (verwacht: 0..1)</assert>
         <assert test="(count(placenta) ge 0) and (count(placenta) le 1)">Fout aantal voorkomens van "Placenta": <value-of select="count(placenta)"/> (verwacht: 0..1)</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1)</assert>
         <assert test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)">Fout aantal voorkomens van "Conditie perineum postpartum": <value-of select="count(conditie_perineum_postpartum)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling: == -->
      <rule context="/kernset_aanleverbericht/bevalling/*[not(self::partusnummer)][not(self::diagnose_bevalling)][not(self::aantal_geboren_kinderen)][not(self::risicostatus_voor_baring)][not(self::wijze_waarop_de_baring_begon)][not(self::interventies_begin_baring_groep)][not(self::tijdstip_begin_actieve_ontsluiting)][not(self::bijstimulatie_toegediendq)][not(self::medicatie_nageboortetijdperk_groep)][not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/partusnummer: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/partusnummer"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20500')">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20500"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Partusnummer": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (string-length(@value) ge 1)">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 1 karakters bevatten</assert>
         <assert test="empty(@value) or (string-length(@value) le 30)">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 30 karakters bevatten</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Partusnummer": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose bevalling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/aantal_geboren_kinderen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20505')">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20505"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Aantal geboren kinderen": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 0)">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 9)">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 9 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Aantal geboren kinderen": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/risicostatus_voor_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/risicostatus_voor_baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20530')">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20530"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '3', '4', '5', 'UNK', 'NI'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('1e lijn (VIL A)', '2e lijn (VIL C)', '1e lijn met plaatsindicatie (VIL D)', '3e lijn', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Risicostatus vóór baring": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550')">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('spontane weeën', 'spontane vliesscheur', 'interventie om baring op gang te brengen', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Wijze waarop de baring begon": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555')">Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Interventies begin baring (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20590')">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20590"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bijstimulatie toegediend?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20616')">Foutieve informatie voor "Bijstimulatie toegediend?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20616"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bijstimulatie toegediend?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bijstimulatie toegediend?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Bijstimulatie toegediend?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20619')">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20619"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/placenta"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Placenta": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/conditie_perineum_postpartum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Perineum intact  (finding)', 'First degree perineal tear during delivery - delivered (disorder)', 'Second degree perineal tear during delivery - delivered  (disorder)', 'Third degree perineal tear during delivery - delivered  (disorder)', 'Type 3a third degree laceration of perineum  (disorder)', 'Type 3b third degree laceration of perineum (disorder)', 'Type 3c third degree laceration of perineum (disorder)', 'Fourth degree perineal tear during delivery - delivered  (disorder)', 'Episiotomy wound  (morphologic abnormality)', 'Anders', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/diagnose_bevalling: == -->
         <assert test="(count(ppromq) ge 0) and (count(ppromq) le 1)">Fout aantal voorkomens van "PPROM?": <value-of select="count(ppromq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(promq) ge 0) and (count(promq) le 1)">Fout aantal voorkomens van "PROM?": <value-of select="count(promq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(koortsq) ge 0) and (count(koortsq) le 1)">Fout aantal voorkomens van "Koorts?": <value-of select="count(koortsq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(niet_vorderende_ontsluitingq) ge 0) and (count(niet_vorderende_ontsluitingq) le 1)">Fout aantal voorkomens van "Niet vorderende ontsluiting?": <value-of select="count(niet_vorderende_ontsluitingq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(niet_vorderende_uitdrijvingq) ge 0) and (count(niet_vorderende_uitdrijvingq) le 1)">Fout aantal voorkomens van "Niet vorderende uitdrijving?": <value-of select="count(niet_vorderende_uitdrijvingq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(verdenking_foetale_noodq) ge 0) and (count(verdenking_foetale_noodq) le 1)">Fout aantal voorkomens van "Verdenking foetale nood?": <value-of select="count(verdenking_foetale_noodq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(vastzittende_placentaq) ge 0) and (count(vastzittende_placentaq) le 1)">Fout aantal voorkomens van "Vastzittende placenta?": <value-of select="count(vastzittende_placentaq)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/diagnose_bevalling: == -->
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/*[not(self::ppromq)][not(self::promq)][not(self::koortsq)][not(self::niet_vorderende_ontsluitingq)][not(self::niet_vorderende_uitdrijvingq)][not(self::verdenking_foetale_noodq)][not(self::vastzittende_placentaq)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PPROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82338')">Foutieve informatie voor "PPROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82338"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "PPROM?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "PPROM?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "PPROM?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/promq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82290')">Foutieve informatie voor "PROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82290"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "PROM?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "PROM?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "PROM?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Koorts?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82292')">Foutieve informatie voor "Koorts?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82292"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Koorts?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Koorts?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Koorts?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Niet vorderende ontsluiting?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82293')">Foutieve informatie voor "Niet vorderende ontsluiting?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82293"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Niet vorderende ontsluiting?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Niet vorderende ontsluiting?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Niet vorderende ontsluiting?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Niet vorderende uitdrijving?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82294')">Foutieve informatie voor "Niet vorderende uitdrijving?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82294"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Niet vorderende uitdrijving?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Niet vorderende uitdrijving?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Niet vorderende uitdrijving?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Verdenking foetale nood?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82296')">Foutieve informatie voor "Verdenking foetale nood?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82296"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Verdenking foetale nood?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Verdenking foetale nood?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Verdenking foetale nood?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vastzittende placenta?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82295')">Foutieve informatie voor "Vastzittende placenta?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82295"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Vastzittende placenta?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Vastzittende placenta?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Vastzittende placenta?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep: == -->
         <assert test="(count(interventie_begin_baring) ge 0) and (count(interventie_begin_baring) le 1)">Fout aantal voorkomens van "Interventie begin baring": <value-of select="count(interventie_begin_baring)"/> (verwacht: 0..1)</assert>
         <assert test="(count(indicatie_interventie_begin_baring) ge 0) and (count(indicatie_interventie_begin_baring) le 1)">Fout aantal voorkomens van "Indicatie interventie begin baring": <value-of select="count(indicatie_interventie_begin_baring)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep: == -->
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/*[not(self::interventie_begin_baring)][not(self::indicatie_interventie_begin_baring)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560')">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Sweeping of membrane (procedure)', 'Induction of labour by artificial rupture of membranes (procedure)', 'Cervical ripening with balloon (procedure)', 'Cervical ripening with Prostaglandin E2 (procedure)', 'Oxytocin induction of labour (procedure)', 'Prostaglandin induction of labour (procedure)', 'Elective caesarean section (procedure)', 'Overig', 'Geen informatie'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Interventie begin baring": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570')">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('10', '1', '3', '8', '20', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('gevaar moeder', 'acuut levensbedreigend', 'niet levensbedreigend', 'onbekend', 'gevaar kind', 'acuut levensbedreigend', 'niet levensbedreigend', 'onbekend', 'baring op korte termijn geïndiceerd door zorgverlener', 'wens zorgverlener (incl: wetenschappelijk onderzoek)', 'wens patiënt', 'overig', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Indicatie interventie begin baring": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep: == -->
         <assert test="(count(medicatie_nageboortetijdperkq) ge 0) and (count(medicatie_nageboortetijdperkq) le 1)">Fout aantal voorkomens van "Medicatie nageboortetijdperk?": <value-of select="count(medicatie_nageboortetijdperkq)"/> (verwacht: 0..1)</assert>
         <assert test="count(soort_medicatie_nageboortetijdperk) ge 0">Fout aantal voorkomens van "Soort medicatie nageboortetijdperk": <value-of select="count(soort_medicatie_nageboortetijdperk)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep: == -->
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/*[not(self::medicatie_nageboortetijdperkq)][not(self::soort_medicatie_nageboortetijdperk)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medicatie nageboortetijdperk?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20620')">Foutieve informatie voor "Medicatie nageboortetijdperk?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20620"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Medicatie nageboortetijdperk?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Medicatie nageboortetijdperk?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Medicatie nageboortetijdperk?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20626')">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20626"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('H01BB02', 'G02AD', 'G02AB', 'OTH', 'UNK'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.73', '2.16.840.1.113883.6.73', '2.16.840.1.113883.6.73', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Oxytocin', 'Prostaglandins', 'Ergot alkaloids', 'Overig', 'Onbekend'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/placenta"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/placenta: == -->
         <assert test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)">Fout aantal voorkomens van "Geboorte placenta": <value-of select="count(geboorte_placenta)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/placenta: == -->
      <rule context="/kernset_aanleverbericht/bevalling/placenta/*[not(self::geboorte_placenta)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/placenta/geboorte_placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Spontaan', 'Controlled cord traction', 'Manuele placentaverwijdering', 'Placentaverwijdering bij SC', 'Overig', 'Geen informatie', 'Onbekend'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Geboorte placenta": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind: == -->
         <assert test="(count(baring) ge 0) and (count(baring) le 1)">Fout aantal voorkomens van "Baring": <value-of select="count(baring)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/*[not(self::baring)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring: == -->
         <assert test="(count(werkelijke_plaats_baring_type_locatie) ge 0) and (count(werkelijke_plaats_baring_type_locatie) le 1)">Fout aantal voorkomens van "Werkelijke plaats baring (type locatie)": <value-of select="count(werkelijke_plaats_baring_type_locatie)"/> (verwacht: 0..1)</assert>
         <assert test="(count(ziekenhuis_baring) ge 0) and (count(ziekenhuis_baring) le 1)">Fout aantal voorkomens van "Ziekenhuis baring": <value-of select="count(ziekenhuis_baring)"/> (verwacht: 0..1)</assert>
         <assert test="(count(demografische_gegevens) ge 0) and (count(demografische_gegevens) le 1)">Fout aantal voorkomens van "Demografische gegevens": <value-of select="count(demografische_gegevens)"/> (verwacht: 0..1)</assert>
         <assert test="(count(kindspecifieke_maternale_gegevens) ge 0) and (count(kindspecifieke_maternale_gegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke maternale gegevens": <value-of select="count(kindspecifieke_maternale_gegevens)"/> (verwacht: 0..1)</assert>
         <assert test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke uitkomstgegevens": <value-of select="count(kindspecifieke_uitkomstgegevens)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/*[not(self::werkelijke_plaats_baring_type_locatie)][not(self::ziekenhuis_baring)][not(self::demografische_gegevens)][not(self::kindspecifieke_maternale_gegevens)][not(self::kindspecifieke_uitkomstgegevens)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003')">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('169813005', '23', '22232009', '40', 'UNK', 'NI'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Home birth (finding)', 'Geboortecentrum', 'Hospital (environment)', 'Onderweg', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ziekenhuis baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114')">Foutieve informatie voor "Ziekenhuis baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Ziekenhuis baring": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke maternale gegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
         <assert test="(count(ziekenhuisnummer_lvrid) ge 0) and (count(ziekenhuisnummer_lvrid) le 1)">Fout aantal voorkomens van "Ziekenhuisnummer (LVR-id)": <value-of select="count(ziekenhuisnummer_lvrid)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/*[not(self::ziekenhuisnummer_lvrid)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005')">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten</assert>
         <assert test="empty(@value) or (string-length(@value) le 4)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 4 karakters bevatten</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens: == -->
         <assert test="(count(identificaties_kind) ge 0) and (count(identificaties_kind) le 1)">Fout aantal voorkomens van "Identificaties kind": <value-of select="count(identificaties_kind)"/> (verwacht: 0..1)</assert>
         <assert test="(count(geslacht_medische_observatie) ge 0) and (count(geslacht_medische_observatie) le 1)">Fout aantal voorkomens van "Geslacht (medische observatie)": <value-of select="count(geslacht_medische_observatie)"/> (verwacht: 0..1)</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1)</assert>
         <assert test="(count(rangnummer_kind) ge 0) and (count(rangnummer_kind) le 1)">Fout aantal voorkomens van "Rangnummer kind": <value-of select="count(rangnummer_kind)"/> (verwacht: 0..1)</assert>
         <assert test="(count(perinatale_sterfte_groep) ge 0) and (count(perinatale_sterfte_groep) le 1)">Fout aantal voorkomens van "Perinatale sterfte (groep)": <value-of select="count(perinatale_sterfte_groep)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/*[not(self::identificaties_kind)][not(self::geslacht_medische_observatie)][not(self::geboortedatum)][not(self::rangnummer_kind)][not(self::perinatale_sterfte_groep)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Identificaties kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40007')">Foutieve informatie voor "Identificaties kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40007"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Identificaties kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041')">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Mannelijk', 'Vrouwelijk', 'Niet conclusief', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Geslacht (medische observatie)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40025')">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40025"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Rangnummer kind": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 1)">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 9)">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 9 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Rangnummer kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279')">Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Perinatale sterfte (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind: == -->
         <assert test="(count(bsn_kind) ge 0) and (count(bsn_kind) le 1)">Fout aantal voorkomens van "BSN kind": <value-of select="count(bsn_kind)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/*[not(self::bsn_kind)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "BSN kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40010')">Foutieve informatie voor "BSN kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40010"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "BSN kind": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "BSN kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
         <assert test="(count(perinatale_sterfteq) ge 0) and (count(perinatale_sterfteq) le 1)">Fout aantal voorkomens van "Perinatale sterfte?": <value-of select="count(perinatale_sterfteq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(fase_perinatale_sterfte) ge 0) and (count(fase_perinatale_sterfte) le 1)">Fout aantal voorkomens van "Fase perinatale sterfte": <value-of select="count(fase_perinatale_sterfte)"/> (verwacht: 0..1)</assert>
         <assert test="(count(datumtijd_vaststelling_perinatale_sterfte) ge 0) and (count(datumtijd_vaststelling_perinatale_sterfte) le 1)">Fout aantal voorkomens van "Datum/tijd vaststelling perinatale sterfte": <value-of select="count(datumtijd_vaststelling_perinatale_sterfte)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/*[not(self::perinatale_sterfteq)][not(self::fase_perinatale_sterfte)][not(self::datumtijd_vaststelling_perinatale_sterfte)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280')">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Perinatale sterfte?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Perinatale sterfte?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290')">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('237361005', '237362003', '276506001', 'NI'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Antepartum fetal death (event)', 'Intrapartum fetal death (event)', 'Newborn death (event)', 'Geen informatie'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Fase perinatale sterfte": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40300')">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40300"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
         <assert test="(count(tijdstip_breken_vliezen) ge 0) and (count(tijdstip_breken_vliezen) le 1)">Fout aantal voorkomens van "Tijdstip breken vliezen": <value-of select="count(tijdstip_breken_vliezen)"/> (verwacht: 0..1)</assert>
         <assert test="(count(kleur_en_consistentie_vruchtwater) ge 0) and (count(kleur_en_consistentie_vruchtwater) le 1)">Fout aantal voorkomens van "Kleur en consistentie vruchtwater": <value-of select="count(kleur_en_consistentie_vruchtwater)"/> (verwacht: 0..1)</assert>
         <assert test="(count(tijdstip_actief_meepersen) ge 0) and (count(tijdstip_actief_meepersen) le 1)">Fout aantal voorkomens van "Tijdstip actief meepersen": <value-of select="count(tijdstip_actief_meepersen)"/> (verwacht: 0..1)</assert>
         <assert test="(count(episiotomieq) ge 0) and (count(episiotomieq) le 1)">Fout aantal voorkomens van "Episiotomie?": <value-of select="count(episiotomieq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(locatie_episiotomie) ge 0) and (count(locatie_episiotomie) le 1)">Fout aantal voorkomens van "Locatie episiotomie": <value-of select="count(locatie_episiotomie)"/> (verwacht: 0..1)</assert>
         <assert test="(count(ruggeprik_gewenst_niet_gekregenq) ge 0) and (count(ruggeprik_gewenst_niet_gekregenq) le 1)">Fout aantal voorkomens van "Ruggeprik gewenst, niet gekregen?": <value-of select="count(ruggeprik_gewenst_niet_gekregenq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(pijnbestrijdingq) ge 0) and (count(pijnbestrijdingq) le 1)">Fout aantal voorkomens van "Pijnbestrijding?": <value-of select="count(pijnbestrijdingq)"/> (verwacht: 0..1)</assert>
         <assert test="count(pijnbestrijding) ge 0">Fout aantal voorkomens van "Pijnbestrijding": <value-of select="count(pijnbestrijding)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(sedatieq) ge 0) and (count(sedatieq) le 1)">Fout aantal voorkomens van "Sedatie?": <value-of select="count(sedatieq)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/*[not(self::tijdstip_breken_vliezen)][not(self::kleur_en_consistentie_vruchtwater)][not(self::tijdstip_actief_meepersen)][not(self::episiotomieq)][not(self::locatie_episiotomie)][not(self::ruggeprik_gewenst_niet_gekregenq)][not(self::pijnbestrijdingq)][not(self::pijnbestrijding)][not(self::sedatieq)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip breken vliezen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80619')">Foutieve informatie voor "Tijdstip breken vliezen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80619"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Tijdstip breken vliezen": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Tijdstip breken vliezen": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20610')">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20610"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('kleurloos', 'meconium', 'bloederig', 'overig', 'geen informatie', 'onbekend'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Kleur en consistentie vruchtwater": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30030')">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30030"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Tijdstip actief meepersen": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Tijdstip actief meepersen": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Episiotomie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30050')">Foutieve informatie voor "Episiotomie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30050"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Episiotomie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Episiotomie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Episiotomie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30055')">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30055"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', 'UNK', 'NI'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.60', '2.16.840.1.113883.2.4.3.22.1.3.60', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('mediolaterale episiotomie', 'mediane episiotomie', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Locatie episiotomie": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82089')">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82089"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pijnbestrijding?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82090')">Foutieve informatie voor "Pijnbestrijding?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82090"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pijnbestrijding?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Pijnbestrijding?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pijnbestrijding?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pijnbestrijding": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82091')">Foutieve informatie voor "Pijnbestrijding": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82091"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Pijnbestrijding": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Sedatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80827')">Foutieve informatie voor "Sedatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80827"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Sedatie?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Sedatie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Sedatie?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding: == -->
         <assert test="count(methode) eq 1">Fout aantal voorkomens van "Methode": <value-of select="count(methode)"/> (verwacht: 1)</assert>
         <assert test="(count(periode) ge 0) and (count(periode) le 1)">Fout aantal voorkomens van "Periode": <value-of select="count(periode)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/*[not(self::methode)][not(self::periode)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82093')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82093"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Methode": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Periode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82097')">Foutieve informatie voor "Periode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82097"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('OntLt3', 'OntMt3', 'Uitdr', 'Sectio', 'Postpartum'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('tijdens ontsluitingsperiode &lt;= 3 cm', 'tijdens ontsluitingsperiode &gt; 3 cm', 'tijdens uitdrijving', 'tijdens sectio', 'na geboorte kind'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Periode": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode: == -->
         <assert test="count(methode) eq 1">Fout aantal voorkomens van "Methode": <value-of select="count(methode)"/> (verwacht: 1)</assert>
         <assert test="count(overig_middel) ge 0">Fout aantal voorkomens van "Overig middel": <value-of select="count(overig_middel)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/*[not(self::methode)][not(self::overig_middel)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82092')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82092"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('231249005', '18946005', '50697003', 'OTH'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Local anesthetic intrathecal block (procedure)', 'Epidural anesthesia (procedure)', 'General anesthesia (procedure)', 'Overig'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Methode": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overig middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82094')">Foutieve informatie voor "Overig middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82094"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Overig middel": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel: == -->
         <assert test="(count(middel) ge 0) and (count(middel) le 1)">Fout aantal voorkomens van "Middel": <value-of select="count(middel)"/> (verwacht: 0..1)</assert>
         <assert test="(count(toediening) ge 0) and (count(toediening) le 1)">Fout aantal voorkomens van "Toediening": <value-of select="count(toediening)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/*[not(self::middel)][not(self::toediening)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82095')">Foutieve informatie voor "Middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82095"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('52685006:363701004=404642006', '281706009:363701004=11713004', '229559001', '426060003', 'OTH'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Administration of morphinomimetic analgesic (procedure)', 'Sterile water injection (procedure)', 'Transcutaneous electrical nerve stimulation (regime/therapy)', 'Nitrous oxide and oxygen gas analgesia in labor (procedure)', 'overig'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Middel": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Toediening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82096')">Foutieve informatie voor "Toediening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82096"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('434589000', '78746004', '386356001', '431215000', '431784008', '241716000', '241717009', 'OTH'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Administration of substance via oral route (procedure)', 'Neurostimulation procedure (procedure)', 'Medication administration: intramuscular (procedure)', 'Administration of substance via intravenous route (procedure)', 'Administration of substance via subcutaneous route (procedure)', 'Patient controlled analgesia (procedure)', 'Inhalational analgesia (procedure)', 'overig'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Toediening": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1)</assert>
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1)</assert>
         <assert test="(count(ligging_bij_geboorte) ge 0) and (count(ligging_bij_geboorte) le 1)">Fout aantal voorkomens van "Ligging bij geboorte": <value-of select="count(ligging_bij_geboorte)"/> (verwacht: 0..1)</assert>
         <assert test="(count(aanpakker_kind_groep) ge 0) and (count(aanpakker_kind_groep) le 1)">Fout aantal voorkomens van "Aanpakker kind (groep)": <value-of select="count(aanpakker_kind_groep)"/> (verwacht: 0..1)</assert>
         <assert test="(count(supervisor_groep) ge 0) and (count(supervisor_groep) le 1)">Fout aantal voorkomens van "Supervisor (groep)": <value-of select="count(supervisor_groep)"/> (verwacht: 0..1)</assert>
         <assert test="count(vaginale_kunstverlossing_groep) ge 0">Fout aantal voorkomens van "Vaginale kunstverlossing (groep)": <value-of select="count(vaginale_kunstverlossing_groep)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(sectio_caesarea_group) ge 0) and (count(sectio_caesarea_group) le 1)">Fout aantal voorkomens van "Sectio caesarea (group)": <value-of select="count(sectio_caesarea_group)"/> (verwacht: 0..1)</assert>
         <assert test="count(overige_interventies) ge 0">Fout aantal voorkomens van "Overige interventies": <value-of select="count(overige_interventies)"/> (verwacht: 0 of meer)</assert>
         <assert test="count(lichamelijk_onderzoek_kind) ge 0">Fout aantal voorkomens van "Lichamelijk onderzoek kind": <value-of select="count(lichamelijk_onderzoek_kind)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen?": <value-of select="count(congenitale_afwijkingenq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen (groep)": <value-of select="count(congenitale_afwijkingen_groep)"/> (verwacht: 0..1)</assert>
         <assert test="(count(problematiek_kindq) ge 0) and (count(problematiek_kindq) le 1)">Fout aantal voorkomens van "Problematiek kind?": <value-of select="count(problematiek_kindq)"/> (verwacht: 0..1)</assert>
         <assert test="count(problematiek_kind) ge 0">Fout aantal voorkomens van "Problematiek kind": <value-of select="count(problematiek_kind)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(kinderarts_betrokkenq) ge 0) and (count(kinderarts_betrokkenq) le 1)">Fout aantal voorkomens van "Kinderarts betrokken?": <value-of select="count(kinderarts_betrokkenq)"/> (verwacht: 0..1)</assert>
         <assert test="count(betrokkenheid_kinderarts) ge 0">Fout aantal voorkomens van "Betrokkenheid kinderarts": <value-of select="count(betrokkenheid_kinderarts)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::apgarscore_na_5_min)][not(self::ligging_bij_geboorte)][not(self::aanpakker_kind_groep)][not(self::supervisor_groep)][not(self::vaginale_kunstverlossing_groep)][not(self::sectio_caesarea_group)][not(self::overige_interventies)][not(self::lichamelijk_onderzoek_kind)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)][not(self::problematiek_kindq)][not(self::problematiek_kind)][not(self::kinderarts_betrokkenq)][not(self::betrokkenheid_kinderarts)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <assert test="empty(@value) or (xs:decimal(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40140')">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40140"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('37235006', '70028003', '249079005', '21882006', '8014007', '49168004', '38049006', '18559007', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Occipitoposterior position (finding)', 'Vertex presentation (finding)', 'Fontanelles presenting (finding)', 'Face presentation (finding)', 'Brow presentation (finding)', 'Complete breech presentation (finding)', 'Incomplete breech presentation (finding)', 'Frank breech presentation (finding)', 'Overig', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Ligging bij geboorte": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Aanpakker kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40149')">Foutieve informatie voor "Aanpakker kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40149"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Aanpakker kind (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Supervisor (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40169')">Foutieve informatie voor "Supervisor (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40169"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Supervisor (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Sectio caesarea (group)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219')">Foutieve informatie voor "Sectio caesarea (group)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Sectio caesarea (group)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240')">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('32189006', '237008007', '40792007', 'OTH'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Pubiotomy (procedure)', 'Maneuvers for delivery in shoulder dystocia (procedure)', 'Kristeller maneuver (procedure)', 'overig'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Overige interventies": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Problematiek kind?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82334')">Foutieve informatie voor "Problematiek kind?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82334"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Problematiek kind?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Problematiek kind?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Problematiek kind?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80789')">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80789"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('56110009', '126941005', '206399009', '206192007', '219', '371129000', '290', '82353009', '35742006', '73893000', '59527008', '1857005', '206376005', '39367000', '1450', '406', '414030009', '414028007', '13404009', '3580', '267574006', '276647007', '206576006', '87476004', '205294008', '415297005', '95827002', '363696006', '206596003', '276519002', '276508000', '5800', '363225006', '46775006', '276533002', '67569000', '6990', '7100', '281610001', '7700', '363221002', '52767006', '276557002', '190268003', '8490', '363224005'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Birth trauma of fetus (disorder)', 'Subdural intracranial hemorrhage due to birth trauma (disorder)', 'Intracranial subarachnoid hemorrhage due to birth injury (disorder)', 'Tentorial tear due to birth trauma (disorder)', 'Overige bloedingen (geboortetrauma)', 'Paralysis from birth trauma (disorder)', 'Overige geboortetraumata', 'Congenital infectious disease (disorder)', 'Congenital syphilis (disorder)', 'Congenital toxoplasmosis (disorder)', 'Congenital cytomegalovirus infection (disorder)', 'Congenital rubella syndrome (disorder)', 'Sepsis of the newborn (disorder)', 'Inflammatory disease of the central nervous system (disorder)', 'Overige infecties', 'Immunologische en haematologische stoornissen', 'Disorder of immune structure (disorder)', 'Disorder of hematopoietic system in newborn (disorder)', 'Twin-to-twin blood transfer (disorder)', 'Overig haematologisch', 'Nervous system and sense organ diseases (disorder)', 'Perinatal intracranial hemorrhage (disorder)', 'Neonatal cerebral ischemia (disorder)', 'Convulsions in the newborn (disorder)', 'Neonatal hypotonia (disorder)', 'Retinopathy of prematurity (disorder)', 'Congenital hearing disorder (disorder)', 'Neonatal cardiovascular disorder (disorder)', 'Neonatal hypertension (disorder)', 'Neonatal hypotension (disorder)', 'Hydrops fetalis (disorder)', 'Overige circulatoire problemen', 'Neonatal respiratory system disorder (disorder)', 'Respiratory distress syndrome in the newborn (disorder)', 'Neonatal aspiration syndromes (disorder)', 'Bronchopulmonary dysplasia of newborn (disorder)', 'Overige respiratoire problemen', 'Stoornissen tractus digestivus en navel', 'Neonatal hyperbilirubinemia (disorder)', 'Overige stoornissen tractus digestivus en navel', 'Neonatal metabolic and endocrinologic disorder (disorder)', 'Neonatal hypoglycemia (disorder)', 'Neonatal hyperglycemia (disorder)', 'Congenital hypothyroidism (disorder)', 'Overige endocriene, metabole en milieu interieur stoornissen', 'Neonatal renal disorder (disorder)'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Problematiek kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kinderarts betrokken?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82119')">Foutieve informatie voor "Kinderarts betrokken?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82119"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Kinderarts betrokken?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Kinderarts betrokken?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Kinderarts betrokken?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Betrokkenheid kinderarts": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82120')">Foutieve informatie voor "Betrokkenheid kinderarts": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82120"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Betrokkenheid kinderarts": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep: == -->
         <assert test="(count(rol_aanpakker_kind) ge 0) and (count(rol_aanpakker_kind) le 1)">Fout aantal voorkomens van "Rol aanpakker kind": <value-of select="count(rol_aanpakker_kind)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/*[not(self::rol_aanpakker_kind)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40150')">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40150"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('11', '25', '12', '01.046', '22', '24', '13', '01.015', '15', '23', '30.000', '32', '33', 'UNK', 'NI'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('1e lijns verloskundige', 'klinisch verloskundige', 'verloskundige in opleiding', 'gynaecoloog', 'gynaecoloog in opleiding', 'arts-assistent', 'co-assistent', 'huisarts', 'huisarts in opleiding', 'arts, niet in opleiding', 'verpleegkundige', 'kraamverzorgende', 'niet medisch geschoolde', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Rol aanpakker kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep: == -->
         <assert test="(count(rol_supervisor) ge 0) and (count(rol_supervisor) le 1)">Fout aantal voorkomens van "Rol supervisor": <value-of select="count(rol_supervisor)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/*[not(self::rol_supervisor)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40170')">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40170"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('11', '25', '01.046', '22', '24', '01.015', 'NI'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('1e lijns verloskundige', 'klinisch verloskundige', 'gynaecoloog', 'gynaecoloog in opleiding', 'arts-assistent', 'huisarts', 'geen informatie'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Rol supervisor": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
         <assert test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing": <value-of select="count(vaginale_kunstverlossing)"/> (verwacht: 0..1)</assert>
         <assert test="(count(succes_vaginale_kunstverlossingq) ge 0) and (count(succes_vaginale_kunstverlossingq) le 1)">Fout aantal voorkomens van "Succes vaginale kunstverlossing?": <value-of select="count(succes_vaginale_kunstverlossingq)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::succes_vaginale_kunstverlossingq)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Forceps delivery (procedure)', 'Delivery by vacuum extraction (procedure)', 'Obstetrical version with extraction (procedure)', 'Partial breech extraction (procedure)', 'Total breech extraction (procedure)', 'anders', 'geen informatie'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Succes vaginale kunstverlossing?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40200')">Foutieve informatie voor "Succes vaginale kunstverlossing?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40200"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Succes vaginale kunstverlossing?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Succes vaginale kunstverlossing?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Succes vaginale kunstverlossing?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
         <assert test="(count(beslismoment_sectio_caesarea) ge 0) and (count(beslismoment_sectio_caesarea) le 1)">Fout aantal voorkomens van "Beslismoment sectio caesarea": <value-of select="count(beslismoment_sectio_caesarea)"/> (verwacht: 0..1)</assert>
         <assert test="count(indicatie_sectio_caesarea) ge 1">Fout aantal voorkomens van "Indicatie sectio caesarea": <value-of select="count(indicatie_sectio_caesarea)"/> (verwacht: 1 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/*[not(self::beslismoment_sectio_caesarea)][not(self::indicatie_sectio_caesarea)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225')">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('2', '3', 'NI'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Tijdens ontsluiting besloten', 'Tijdens uitdrijving besloten', 'Geen informatie'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Beslismoment sectio caesarea": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230')">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('History of third degree perineal laceration (situation)', 'History of fourth degree perineal laceration (situation)', 'Abnormal fetal presentation (finding)', 'Failure to progress in first stage of labor (finding)', 'Failure to progress in second stage of labor (finding)', 'Suspected fetal distress (situation) ', 'Patient condition finding (finding)', 'Maternal request for treatment (finding)', 'overig, medische reden', 'overig, niet-medische reden', 'geen informatie'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Indicatie sectio caesarea": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
         <assert test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)">Fout aantal voorkomens van "Geboortegewicht": <value-of select="count(geboortegewicht)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortegewicht": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (xs:decimal(@value) ge 0)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'gram')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
         <assert test="count(specificatie_congenitale_afwijking_groep) ge 0">Fout aantal voorkomens van "Specificatie congenitale afwijking (groep)": <value-of select="count(specificatie_congenitale_afwijking_groep)"/> (verwacht: 0 of meer)</assert>
         <assert test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)">Fout aantal voorkomens van "Chromosomale afwijkingen?": <value-of select="count(chromosomale_afwijkingenq)"/> (verwacht: 0..1)</assert>
         <assert test="count(specificatie_chromosomale_afwijking_groep) ge 0">Fout aantal voorkomens van "Specificatie chromosomale afwijking (groep)": <value-of select="count(specificatie_chromosomale_afwijking_groep)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/*[not(self::specificatie_congenitale_afwijking_groep)][not(self::chromosomale_afwijkingenq)][not(self::specificatie_chromosomale_afwijking_groep)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082')">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Chromosomale afwijkingen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111')">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
         <assert test="(count(specificatie_congenitale_afwijking) ge 0) and (count(specificatie_congenitale_afwijking) le 1)">Fout aantal voorkomens van "Specificatie congenitale afwijking": <value-of select="count(specificatie_congenitale_afwijking)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/*[not(self::specificatie_congenitale_afwijking)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090')">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Congenital anomaly of nervous system (disorder)', 'Fetal anencephaly (disorder)', 'Fetal microcephaly (disorder)', 'Spina bifida occulta (disorder)', 'Meningomyelocele (disorder)', 'Meningocele (disorder)', 'Congenital hydrocephalus (disorder)', 'Holoprosencephaly sequence (disorder)', 'Encephalocele (disorder)', 'Neonatal neuromuscular disorder (disorder)', 'overige congenitale afwijkingen zenuwstelsel', 'zintuigen', 'Congenital anomaly of eye (disorder)', 'Microphthalmos (disorder)', 'overige congenitale afwijkingen ogen', 'Congenital anomaly of ear (disorder)', 'overige congenitale afwijkingen zintuigen', 'Congenital anomaly of cardiovascular system (disorder)', 'Single umbilical artery (disorder)', 'Discordant ventriculoarterial connection (disorder)', 'Tetralogy of Fallot (disorder)', 'Ventricular septal defect (disorder)', 'Hypoplastic left heart syndrome (disorder)', 'Coarctation of aorta (disorder)', 'Congenital anomaly of tricuspid valve (disorder)', 'Multiple congenital cardiac defects (disorder)', 'overige congenitale afwijking hart en bloedvaten', 'Congenital anomaly of digestive tract (disorder)', 'Cleft lip (disorder)', 'Cleft palate (disorder)', 'Congenital anomaly of esophagus (disorder)', 'Congenital atresia of small intestine (disorder)', 'Atresia of large intestine (disorder)', 'Anal atresia (disorder)', 'Hirschsprung''s disease (disorder)', 'Congenital malrotation of intestine (disorder)', 'Intestinal volvulus (disorder)', 'overige congenitale afwijking tractus digestivus', 'Congenital anomaly of respiratory system (disorder)', 'Choanal atresia (disorder)', 'Congenital anomaly of trachea (disorder)', 'Congenital hypoplasia of lung (disorder)', 'Congenital lobar emphysema (disorder)', 'Congenital cystic adenomatoid malformation of lung (disorder)', 'Hydrothorax (disorder)', 'Chylothorax (disorder)', 'Congenital diaphragmatic hernia (disorder)', 'Relaxation of diaphragm (disorder)', 'overige congenitale afwijking tractus respiratorius', 'Genitourinary congenital anomalies (disorder)', 'Hypospadias (disorder)', 'Epispadias (disorder)', 'Undescended testicle (disorder)', 'Exstrophy of bladder sequence (disorder)', 'Oligohydramnios sequence (disorder)', 'Congenital cystic kidney disease (disorder)', 'Urinary tract obstruction (disorder)', 'Disorder of sexual differentiation (disorder)', 'overige congenitale afwijking tractus urogenitalis', 'Congenital anomaly of skin (disorder)', 'Hemangioma of skin (disorder)', 'Congenital pigmented melanocytic nevus of skin (disorder)', 'overige congenitale huidafwijking', 'Congenital anomaly of abdominal wall (disorder)', 'Gastroschisis (disorder)', 'Congenital omphalocele (disorder)', 'Umbilical hernia (disorder)', 'Congenital inguinal hernia (disorder)', 'overige congenitale afwijking buikwand', 'Congenital anomaly of musculoskeletal system (disorder)', 'Polydactyly (disorder)', 'Syndactyly (disorder)', 'Congenital deformity of foot (disorder)', 'Reduction deformity of upper limb (disorder)', 'Reduction deformity of lower limb (disorder)', 'overige congenitale afwijking extremiteiten', 'Congenital subluxation of hip (disorder)', 'overige congenitale afwijking skelet en spierstelsel', 'multipele/syndromale congenitale afwijkingen (niet chromosomaal)', 'Dysmorphism (disorder)', 'Situs inversus viscerum (disorder)', 'Multiple congenital anomalies (disorder)', 'Multiple system malformation syndrome (disorder)', 'overige multipele/syndromale afwijkingen', 'overige congenitale afwijkingen', 'Congenital iodine deficiency syndrome (disorder)', 'Inborn error of metabolism (disorder)', 'andere endocrinologische afwijkingen', 'Congenital malignant neoplastic disease (disorder)', 'overig', 'geen informatie'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Specificatie congenitale afwijking": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
         <assert test="count(specificatie_chromosomale_afwijking) eq 1">Fout aantal voorkomens van "Specificatie chromosomale afwijking": <value-of select="count(specificatie_chromosomale_afwijking)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/*[not(self::specificatie_chromosomale_afwijking)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120')">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Complete trisomy 21 syndrome (disorder)', 'Complete trisomy 18 syndrome (disorder)', 'Complete trisomy 13 syndrome (disorder)', 'Andere numerieke chromosomale afwijkingen', 'Overige chromosomale afwijkingen', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Specificatie chromosomale afwijking": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts: == -->
         <assert test="(count(datum_betrokkenheid) ge 0) and (count(datum_betrokkenheid) le 1)">Fout aantal voorkomens van "Datum betrokkenheid": <value-of select="count(datum_betrokkenheid)"/> (verwacht: 0..1)</assert>
         <assert test="(count(reden_betrokkenheid) ge 0) and (count(reden_betrokkenheid) le 1)">Fout aantal voorkomens van "Reden betrokkenheid": <value-of select="count(reden_betrokkenheid)"/> (verwacht: 0..1)</assert>
         <assert test="(count(type_betrokkenheid) ge 0) and (count(type_betrokkenheid) le 1)">Fout aantal voorkomens van "Type betrokkenheid": <value-of select="count(type_betrokkenheid)"/> (verwacht: 0..1)</assert>
         <assert test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/*[not(self::datum_betrokkenheid)][not(self::reden_betrokkenheid)][not(self::type_betrokkenheid)][not(self::zorginstelling_lvrid)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82122')">Foutieve informatie voor "Datum betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82122"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum betrokkenheid": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum betrokkenheid": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82123')">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82123"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('276614003', '276609002', '289261003', '8571000146103', '289365005', '12729009', '364737004', '168092006', '387712008', '161838002', '473130003', '394886001', '281667005', '95607001', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Gestation abnormality (disorder)', 'Birth weight abnormality (disorder)', 'Delivery problem (finding)', 'Fetal or neonatal effect of assisted delivery (disorder)', 'Finding of malposition of foetus (finding)', 'Prolonged rupture of membranes (disorder)', 'Finding of neonatal condition (finding)', 'Amniotic fluid -meconium stain (finding)', 'Neonatal jaundice (disorder)', 'Infant feeding problem (finding)', 'Suspected infectious disease (situation)', 'Suspected heart disease (situation)', 'Maternal history of disorder (situation)', 'Maternal drug use (disorder)', 'Overig', 'Onbekend', 'geen informatie'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Reden betrokkenheid": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82121')">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82121"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', 'UNK', 'NI'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.17', '2.16.840.1.113883.2.4.4.13.17', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('consultatie', 'overdracht', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type betrokkenheid": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82335')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82335"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek: == -->
         <assert test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)">Fout aantal voorkomens van "Maternale onderzoeksgegevens": <value-of select="count(maternale_onderzoeksgegevens)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
         <assert test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)">Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
         <assert test="(count(psie) ge 0) and (count(psie) le 1)">Fout aantal voorkomens van "PSIE": <value-of select="count(psie)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::psie)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PSIE": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949')">Foutieve informatie voor "PSIE": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "PSIE": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
         <assert test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)">Fout aantal voorkomens van "Irregulaire antistoffen?": <value-of select="count(irregulaire_antistoffenq)"/> (verwacht: 0..1)</assert>
         <assert test="count(welke_irregulaire_antistoffen_vrouw_aanwezig) ge 0">Fout aantal voorkomens van "Welke irregulaire antistoffen vrouw aanwezig.": <value-of select="count(welke_irregulaire_antistoffen_vrouw_aanwezig)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/*[not(self::irregulaire_antistoffenq)][not(self::welke_irregulaire_antistoffen_vrouw_aanwezig)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Irregulaire antistoffen?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10813')">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10813"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('112162009', '8362009', '62523009', '405844003', '8376005', '25453008', 'OTH', 'UNK'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Rhesus D', 'Rhesus c', 'Rhesus e', 'Kell', 'Duffy', 'Kidd', 'overig', 'onbekend'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase: == -->
         <assert test="count(diagnose_postpartum) ge 0">Fout aantal voorkomens van "Diagnose postpartum": <value-of select="count(diagnose_postpartum)"/> (verwacht: 0 of meer)</assert>
         <assert test="count(kindspecifieke_gegevens) ge 0">Fout aantal voorkomens van "Kindspecifieke gegevens": <value-of select="count(kindspecifieke_gegevens)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/*[not(self::diagnose_postpartum)][not(self::kindspecifieke_gegevens)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82297')">Foutieve informatie voor "Diagnose postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82297"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose postpartum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.161')">Foutieve informatie voor "Kindspecifieke gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.161"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke gegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum: == -->
         <assert test="(count(datum) ge 0) and (count(datum) le 1)">Fout aantal voorkomens van "Datum": <value-of select="count(datum)"/> (verwacht: 0..1)</assert>
         <assert test="(count(pathologie_vrouwq) ge 0) and (count(pathologie_vrouwq) le 1)">Fout aantal voorkomens van "Pathologie vrouw?": <value-of select="count(pathologie_vrouwq)"/> (verwacht: 0..1)</assert>
         <assert test="(count(pathologie_vrouw) ge 0) and (count(pathologie_vrouw) le 1)">Fout aantal voorkomens van "Pathologie vrouw": <value-of select="count(pathologie_vrouw)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/*[not(self::datum)][not(self::pathologie_vrouwq)][not(self::pathologie_vrouw)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82298')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82298"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pathologie vrouw?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82208')">Foutieve informatie voor "Pathologie vrouw?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82208"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pathologie vrouw?": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Pathologie vrouw?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pathologie vrouw?": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82209')">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82209"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('6010', '398254007', '67359005', '303063000', '95605009', '56272000', '58703003', '18260003', '301822002', '414086009', '385494008', '116859006', '178280004', '78623009', '45198002', '68566005', '300927001', '6150', 'OTH'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('(Dreigende) eclampsie, (verdenking op) HELLP-syndroom', 'Pre-eclampsia (disorder)', 'Pre-eclampsia added to pre-existing hypertension (disorder)', 'Eclampsia in puerperium (disorder)', 'Hemolysis-elevated liver enzymes-low platelet count syndrome (disorder)', 'Postpartum deep phlebothrombosis (disorder)', 'Postpartum depression (disorder)', 'Postpartum psychosis (disorder)', 'Abnormal vaginal bleeding (finding)', 'Embolism (disorder)', 'Hematoma (disorder)', 'Transfusion of blood product (procedure)', 'Postnatal infection (disorder)', 'Endometritis (disorder)', 'Mastitis (disorder)', 'Urinary tract infectious disease (disorder)', 'Episiotomy infection (disorder)', 'Overige infecties', 'Overig'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Pathologie vrouw": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens: == -->
         <assert test="(count(voeding_kind_groep) ge 0) and (count(voeding_kind_groep) le 1)">Fout aantal voorkomens van "Voeding kind (groep)": <value-of select="count(voeding_kind_groep)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/*[not(self::voeding_kind_groep)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voeding kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70009')">Foutieve informatie voor "Voeding kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70009"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Voeding kind (groep)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep: == -->
         <assert test="(count(voeding_kind_datum) ge 0) and (count(voeding_kind_datum) le 1)">Fout aantal voorkomens van "Voeding kind (datum)": <value-of select="count(voeding_kind_datum)"/> (verwacht: 0..1)</assert>
         <assert test="count(substantie_voeding_kind) ge 1">Fout aantal voorkomens van "Substantie voeding kind": <value-of select="count(substantie_voeding_kind)"/> (verwacht: 1 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/*[not(self::voeding_kind_datum)][not(self::substantie_voeding_kind)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voeding kind (datum)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70011')">Foutieve informatie voor "Voeding kind (datum)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70011"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voeding kind (datum)": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voeding kind (datum)": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70030')">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70030"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', 'UNK', 'NI'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.4.8', '2.16.840.1.113883.2.4.3.22.1.4.8', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Borstvoeding', 'Kunstvoeding', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Substantie voeding kind": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
</schema>
