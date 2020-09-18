<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:local="#local"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://purl.oclc.org/dsdl/schematron"
        queryBinding="xslt2"
        xml:lang="nl-NL">
<!--
MIT License

Copyright (c) 2019 Marc de Graauw and Erik Siegel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<!-- == Generated Schematron file for validating ADA Full kernset_aanleverbericht documents == --><!-- == Source: design/specs-full/kernset-22.xml == --><!-- == Generator(s): design/xsl/ada-rtd2ada-schema-simple.xsl; design/xsl/ada-schema-simple2ada-schematron.xsl == -->
   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(kernset_aanleverbericht) eq 1">Fout aantal voorkomens van "Kernset aanleverbericht": <value-of select="count(kernset_aanleverbericht)"/> (verwacht: 1) [/kernset_aanleverbericht]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Kernset aanleverbericht": Attribuut "transactionRef" ontbreekt [/kernset_aanleverbericht/@transactionRef]</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat [/kernset_aanleverbericht/@transactionRef; type=t-id]</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2410')">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2410" [/kernset_aanleverbericht/@transactionRef]</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="exists(@transactionEffectiveDate)">Foutieve informatie voor "Kernset aanleverbericht": Attribuut "transactionEffectiveDate" ontbreekt [/kernset_aanleverbericht/@transactionEffectiveDate]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/kernset_aanleverbericht/@transactionEffectiveDate; type=xs:dateTime]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2014-10-20T00:00:00')">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2014-10-20T00:00:00" [/kernset_aanleverbericht/@transactionEffectiveDate]</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="exists(@versionDate)">Foutieve informatie voor "Kernset aanleverbericht": Attribuut "versionDate" ontbreekt [/kernset_aanleverbericht/@versionDate]</assert>
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Kernset aanleverbericht": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat [/kernset_aanleverbericht/@versionDate; type=xs:dateTime]</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="exists(@prefix)">Foutieve informatie voor "Kernset aanleverbericht": Attribuut "prefix" ontbreekt [/kernset_aanleverbericht/@prefix]</assert>
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Kernset aanleverbericht": Ongeldige attributen aangetroffen [/kernset_aanleverbericht; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/kernset_aanleverbericht"><!-- == Check occurrences of children of /kernset_aanleverbericht: == -->
         <assert test="count(zorgverlening) eq 1">Fout aantal voorkomens van "Zorgverlening": <value-of select="count(zorgverlening)"/> (verwacht: 1) [/kernset_aanleverbericht/zorgverlening]</assert>
         <assert test="count(zorgverlenerzorginstelling) eq 1">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 1) [/kernset_aanleverbericht/zorgverlenerzorginstelling]</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1) [/kernset_aanleverbericht/vrouw]</assert>
         <assert test="count(obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap) ge 0">Fout aantal voorkomens van "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": <value-of select="count(obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap]</assert>
         <assert test="count(zwangerschap) eq 1">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 1) [/kernset_aanleverbericht/zwangerschap]</assert>
         <assert test="(count(bevalling) ge 0) and (count(bevalling) le 1)">Fout aantal voorkomens van "Bevalling": <value-of select="count(bevalling)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling]</assert>
         <assert test="count(uitkomst_per_kind) ge 0">Fout aantal voorkomens van "Uitkomst (per kind)": <value-of select="count(uitkomst_per_kind)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind]</assert>
         <assert test="count(medisch_onderzoek) ge 0">Fout aantal voorkomens van "Medisch onderzoek": <value-of select="count(medisch_onderzoek)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/medisch_onderzoek]</assert>
         <assert test="(count(postnatale_fase) ge 0) and (count(postnatale_fase) le 1)">Fout aantal voorkomens van "Postnatale fase": <value-of select="count(postnatale_fase)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht: == -->
      <rule context="/kernset_aanleverbericht/*[not(self::zorgverlening)][not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::medisch_onderzoek)][not(self::postnatale_fase)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.4')">Foutieve informatie voor "Zorgverlening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.4" [/kernset_aanleverbericht/zorgverlening/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener/Zorginstelling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlenerzorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/kernset_aanleverbericht/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vrouw": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/kernset_aanleverbericht/vrouw/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.17')">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.17" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Obstetrische anamnese gegroepeerd per voorgaande zwangerschap": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschap": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/kernset_aanleverbericht/zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bevalling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6" [/kernset_aanleverbericht/bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Uitkomst (per kind)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7" [/kernset_aanleverbericht/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Medisch onderzoek": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14" [/kernset_aanleverbericht/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Postnatale fase": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postnatale fase": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.16')">Foutieve informatie voor "Postnatale fase": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.16" [/kernset_aanleverbericht/postnatale_fase/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Postnatale fase": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening: == -->
         <assert test="(count(datum_start_zorgverantwoordelijkheid) ge 0) and (count(datum_start_zorgverantwoordelijkheid) le 1)">Fout aantal voorkomens van "Datum start zorgverantwoordelijkheid": <value-of select="count(datum_start_zorgverantwoordelijkheid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid]</assert>
         <assert test="(count(datum_einde_zorgverantwoordelijkheid) ge 0) and (count(datum_einde_zorgverantwoordelijkheid) le 1)">Fout aantal voorkomens van "Datum einde zorgverantwoordelijkheid": <value-of select="count(datum_einde_zorgverantwoordelijkheid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid]</assert>
         <assert test="count(eindverantwoordelijk_in_welke_perinatale_periodeq) ge 0">Fout aantal voorkomens van "Eindverantwoordelijk in welke perinatale periode?": <value-of select="count(eindverantwoordelijk_in_welke_perinatale_periodeq)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq]</assert>
         <assert test="(count(conclusie_risicostatus_na_intake) ge 0) and (count(conclusie_risicostatus_na_intake) le 1)">Fout aantal voorkomens van "Conclusie risicostatus na intake": <value-of select="count(conclusie_risicostatus_na_intake)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake]</assert>
         <assert test="count(zorgverzoekdetails) ge 0">Fout aantal voorkomens van "Zorgverzoekdetails": <value-of select="count(zorgverzoekdetails)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails]</assert>
         <assert test="(count(is_er_sprake_van_overdracht_aanq) ge 0) and (count(is_er_sprake_van_overdracht_aanq) le 1)">Fout aantal voorkomens van "Is er sprake van 'overdracht aan'?": <value-of select="count(is_er_sprake_van_overdracht_aanq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq]</assert>
         <assert test="count(overdrachtdetails) ge 0">Fout aantal voorkomens van "Overdrachtdetails": <value-of select="count(overdrachtdetails)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/*[not(self::datum_start_zorgverantwoordelijkheid)][not(self::datum_einde_zorgverantwoordelijkheid)][not(self::eindverantwoordelijk_in_welke_perinatale_periodeq)][not(self::conclusie_risicostatus_na_intake)][not(self::zorgverzoekdetails)][not(self::is_er_sprake_van_overdracht_aanq)][not(self::overdrachtdetails)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlening/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20290')">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20290" [/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum start zorgverantwoordelijkheid": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/datum_start_zorgverantwoordelijkheid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20340')">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20340" [/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum einde zorgverantwoordelijkheid": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/datum_einde_zorgverantwoordelijkheid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20355')">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20355" [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', '7', '8', 'UNK', 'NI'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@code; allowed=('1', '2', '3', '4', '5', '6', '7', '8', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.2.4.3.22.1.2.20', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Eindverantwoordelijk in welke perinatale periode?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/eindverantwoordelijk_in_welke_perinatale_periodeq; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Conclusie risicostatus na intake": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20305')">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20305" [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Conclusie risicostatus na intake": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Conclusie risicostatus na intake": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@code; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Conclusie risicostatus na intake": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26'))">Foutieve informatie voor "Conclusie risicostatus na intake": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26', '2.16.840.1.113883.2.4.4.13.26')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Conclusie risicostatus na intake": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Conclusie risicostatus na intake": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/conclusie_risicostatus_na_intake; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverzoekdetails": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverzoekdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.41')">Foutieve informatie voor "Zorgverzoekdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.41" [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverzoekdetails": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20360')">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20360" [/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Is er sprake van 'overdracht aan'?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/is_er_sprake_van_overdracht_aanq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overdrachtdetails": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overdrachtdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.42')">Foutieve informatie voor "Overdrachtdetails": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.42" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Overdrachtdetails": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlening/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails: == -->
         <assert test="(count(overname_van_zorginstelling) ge 0) and (count(overname_van_zorginstelling) le 1)">Fout aantal voorkomens van "Overname van zorginstelling": <value-of select="count(overname_van_zorginstelling)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling]</assert>
         <assert test="(count(redenen_van_overname) ge 0) and (count(redenen_van_overname) le 1)">Fout aantal voorkomens van "Redenen van overname": <value-of select="count(redenen_van_overname)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/*[not(self::overname_van_zorginstelling)][not(self::redenen_van_overname)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overname van zorginstelling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overname van zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.411')">Foutieve informatie voor "Overname van zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.411" [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Overname van zorginstelling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Redenen van overname": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Redenen van overname": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20325')">Foutieve informatie voor "Redenen van overname": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20325" [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Redenen van overname": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling: == -->
         <assert test="count(overname_van_zorginstelling_id) ge 0">Fout aantal voorkomens van "Overname van zorginstelling (id)": <value-of select="count(overname_van_zorginstelling_id)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/*[not(self::overname_van_zorginstelling_id)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overname van zorginstelling (id)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overname van zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20320')">Foutieve informatie voor "Overname van zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20320" [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Overname van zorginstelling (id)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/overname_van_zorginstelling_id; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/overname_van_zorginstelling/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname: == -->
         <assert test="count(reden_van_overname_lijst_prn) ge 0">Fout aantal voorkomens van "Reden van overname (lijst PRN)": <value-of select="count(reden_van_overname_lijst_prn)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/*[not(self::reden_van_overname_lijst_prn)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Reden van overname (lijst PRN)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20331')">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20331" [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Reden van overname (lijst PRN)": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '5', '6', '7', '8', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '42', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '56', '59', '60', '62', '63', '64', '65', '66', '68', '69', '70', '71', '72', '73', '74', '75', '77', '78', '79', '80', '81', '82', '83', '84', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '99', '100', '102', '103', '104', '105', '106', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '134', '135', '136', '137', '138', '140', '141', '142', '143', '145', '146', '147', '148', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '217', '218', '220', '221', '222', '223', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '240', '241', '242', '243', '245', '246', '247', '248', '249', '250', '251', '252', '253', '255', '256', '257', '259', '260', '261', '263', '264', '265', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@value; allowed=('2', '3', '4', '5', '6', '7', '8', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '42', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '56', '59', '60', '62', '63', '64', '65', '66', '68', '69', '70', '71', '72', '73', '74', '75', '77', '78', '79', '80', '81', '82', '83', '84', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '99', '100', '102', '103', '104', '105', '106', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '134', '135', '136', '137', '138', '140', '141', '142', '143', '145', '146', '147', '148', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '217', '218', '220', '221', '222', '223', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '240', '241', '242', '243', '245', '246', '247', '248', '249', '250', '251', '252', '253', '255', '256', '257', '259', '260', '261', '263', '264', '265', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Reden van overname (lijst PRN)": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@code]</assert>
         <assert test="empty(@code) or (@code = ('1010', '1020', '1030', '1040', '1050', '1060', '1070', '1081', '1082', '1090', '1100', '1110', '1120', '1130', '1140', '1150', '1160', '1171', '1172', '1181', '1182', '1183', '1184', '1185', '1186', '1190', '1200', '1210', '1220', '1230', '1240', '1250', '1260', '1270', '1280', '1999', '2010', '2021', '2022', '2023', '2030', '2040', '2050', '2061', '2062', '2070', '2080', '2090', '2999', '3011', '3012', '3021', '3022', '3030', '3031', '3032', '3041', '3042', '3050', '3060', '3070', '3080', '3081', '3082', '3091', '3092', '3100', '3110', '3120', '3130', '3140', '3150', '3161', '3162', '3170', '3180', '3190', '3200', '3210', '3220', '3230', '3250', '3251', '3999', '4010', '4020', '4032', '4040', '4050', '4060', '4070', '4081', '4082', '4083', '4090', '4100', '4110', '4120', '4130', '4140', '4149', '4151', '4152', '4153', '4160', '4170', '4180', '4190', '4200', '4210', '4220', '4230', '4240', '4250', '4260', '4271', '4272', '4273', '4274', '4275', '4281', '4282', '4283', '4284', '4291', '4292', '4293', '4294', '4310', '4311', '4312', '4320', '4330', '4340', '4350', '4351', '4360', '4370', '4380', '4390', '4400', '4410', '4420', '4430', '4440', '4441', '4450', '4460', '4470', '4480', '4490', '4500', '4600', '4999', '5010', '5020', '5030', '5040', '5050', '5060', '5070', '5071', '5080', '5090', '5100', '5110', '5120', '5130', '5140', '5150', '5160', '5170', '5180', '5190', '5200', '5210', '5999', '6011', '6012', '6013', '6020', '6030', '6040', '6050', '6060', '6070', '6080', '6090', '6100', '6110', '6499', '6510', '6520', '6531', '6532', '6533', '6534', '6542', '6543', '6544', '6545', '6546', '6547', '6548', '6549', '6550', '6551', '6552', '6553', '6599', '7110', '7120', '7130', '7140', '7210', '7220', '7230', '7240', '7250', '7260', '7270', '7280', '7290', '7310', '7320', '7499', '8010', '8020', '8030', '8110', '8120', '8130', '8210', '8220', '8230', '8240', '8250', '8260', '8270', '8280', '8499', 'UNK', 'NI', 'NAV', 'OTH'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@code; allowed=('1010', '1020', '1030', '1040', '1050', '1060', '1070', '1081', '1082', '1090', '1100', '1110', '1120', '1130', '1140', '1150', '1160', '1171', '1172', '1181', '1182', '1183', '1184', '1185', '1186', '1190', '1200', '1210', '1220', '1230', '1240', '1250', '1260', '1270', '1280', '1999', '2010', '2021', '2022', '2023', '2030', '2040', '2050', '2061', '2062', '2070', '2080', '2090', '2999', '3011', '3012', '3021', '3022', '3030', '3031', '3032', '3041', '3042', '3050', '3060', '3070', '3080', '3081', '3082', '3091', '3092', '3100', '3110', '3120', '3130', '3140', '3150', '3161', '3162', '3170', '3180', '3190', '3200', '3210', '3220', '3230', '3250', '3251', '3999', '4010', '4020', '4032', '4040', '4050', '4060', '4070', '4081', '4082', '4083', '4090', '4100', '4110', '4120', '4130', '4140', '4149', '4151', '4152', '4153', '4160', '4170', '4180', '4190', '4200', '4210', '4220', '4230', '4240', '4250', '4260', '4271', '4272', '4273', '4274', '4275', '4281', '4282', '4283', '4284', '4291', '4292', '4293', '4294', '4310', '4311', '4312', '4320', '4330', '4340', '4350', '4351', '4360', '4370', '4380', '4390', '4400', '4410', '4420', '4430', '4440', '4441', '4450', '4460', '4470', '4480', '4490', '4500', '4600', '4999', '5010', '5020', '5030', '5040', '5050', '5060', '5070', '5071', '5080', '5090', '5100', '5110', '5120', '5130', '5140', '5150', '5160', '5170', '5180', '5190', '5200', '5210', '5999', '6011', '6012', '6013', '6020', '6030', '6040', '6050', '6060', '6070', '6080', '6090', '6100', '6110', '6499', '6510', '6520', '6531', '6532', '6533', '6534', '6542', '6543', '6544', '6545', '6546', '6547', '6548', '6549', '6550', '6551', '6552', '6553', '6599', '7110', '7120', '7130', '7140', '7210', '7220', '7230', '7240', '7250', '7260', '7270', '7280', '7290', '7310', '7320', '7499', '8010', '8020', '8030', '8110', '8120', '8130', '8210', '8220', '8230', '8240', '8250', '8260', '8270', '8280', '8499', 'UNK', 'NI', 'NAV', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Reden van overname (lijst PRN)": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Reden van overname (lijst PRN)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Reden van overname (lijst PRN)": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Reden van overname (lijst PRN)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/reden_van_overname_lijst_prn; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlening/zorgverzoekdetails/redenen_van_overname/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/overdrachtdetails: == -->
         <assert test="(count(datum_van_overdracht) ge 0) and (count(datum_van_overdracht) le 1)">Fout aantal voorkomens van "Datum van overdracht": <value-of select="count(datum_van_overdracht)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht]</assert>
         <assert test="(count(overdracht_aan_zorginstelling_specialisme) ge 0) and (count(overdracht_aan_zorginstelling_specialisme) le 1)">Fout aantal voorkomens van "Overdracht aan zorginstelling (specialisme)": <value-of select="count(overdracht_aan_zorginstelling_specialisme)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme]</assert>
         <assert test="count(overdracht_aan_zorginstelling_id) ge 0">Fout aantal voorkomens van "Overdracht aan zorginstelling (id)": <value-of select="count(overdracht_aan_zorginstelling_id)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id]</assert>
         <assert test="(count(perinatale_periode_van_overdracht) ge 0) and (count(perinatale_periode_van_overdracht) le 1)">Fout aantal voorkomens van "Perinatale periode van overdracht": <value-of select="count(perinatale_periode_van_overdracht)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht]</assert>
         <assert test="(count(redenen_van_overdracht_aan) ge 0) and (count(redenen_van_overdracht_aan) le 1)">Fout aantal voorkomens van "Redenen van 'overdracht aan'": <value-of select="count(redenen_van_overdracht_aan)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/overdrachtdetails: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/*[not(self::datum_van_overdracht)][not(self::overdracht_aan_zorginstelling_specialisme)][not(self::overdracht_aan_zorginstelling_id)][not(self::perinatale_periode_van_overdracht)][not(self::redenen_van_overdracht_aan)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum van overdracht": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20362')">Foutieve informatie voor "Datum van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20362" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum van overdracht": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum van overdracht": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/datum_van_overdracht; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20366')">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20366" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@code]</assert>
         <assert test="empty(@code) or (@code = ('01.046', '01.019', 'UNK', 'NI'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@code; allowed=('01.046', '01.019', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@codeSystem; allowed=('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Overdracht aan zorginstelling (specialisme)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_specialisme; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overdracht aan zorginstelling (id)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overdracht aan zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20368')">Foutieve informatie voor "Overdracht aan zorginstelling (id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20368" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Overdracht aan zorginstelling (id)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/overdracht_aan_zorginstelling_id; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Perinatale periode van overdracht": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20367')">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20367" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Perinatale periode van overdracht": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '5', '7', '8', '9', '11', '12', '13', '14', '15', '16', '17'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@value; allowed=('2', '3', '4', '5', '7', '8', '9', '11', '12', '13', '14', '15', '16', '17')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Perinatale periode van overdracht": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '91', '92', '10', 'UNK', 'NI'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@code; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '91', '92', '10', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Perinatale periode van overdracht": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Perinatale periode van overdracht": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.2.4.3.22.1.2.52', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Perinatale periode van overdracht": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Perinatale periode van overdracht": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/perinatale_periode_van_overdracht; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Redenen van 'overdracht aan'": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Redenen van 'overdracht aan'": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20365')">Foutieve informatie voor "Redenen van 'overdracht aan'": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20365" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Redenen van 'overdracht aan'": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlening/overdrachtdetails/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan: == -->
         <assert test="count(reden_overdracht_aan_lijst_prn) ge 0">Fout aantal voorkomens van "Reden 'overdracht aan' (lijst PRN)": <value-of select="count(reden_overdracht_aan_lijst_prn)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan: == -->
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/*[not(self::reden_overdracht_aan_lijst_prn)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20371')">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20371" [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '5', '6', '7', '8', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '42', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '56', '59', '60', '62', '63', '64', '65', '66', '68', '69', '70', '71', '72', '73', '74', '75', '77', '78', '79', '80', '81', '82', '83', '84', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '99', '100', '102', '103', '104', '105', '106', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '134', '135', '136', '137', '138', '140', '141', '142', '143', '145', '146', '147', '148', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '217', '218', '220', '221', '222', '223', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '240', '241', '242', '243', '245', '246', '247', '248', '249', '250', '251', '252', '253', '255', '256', '257', '259', '260', '261', '263', '264', '265', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@value; allowed=('2', '3', '4', '5', '6', '7', '8', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '42', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '56', '59', '60', '62', '63', '64', '65', '66', '68', '69', '70', '71', '72', '73', '74', '75', '77', '78', '79', '80', '81', '82', '83', '84', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '99', '100', '102', '103', '104', '105', '106', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '134', '135', '136', '137', '138', '140', '141', '142', '143', '145', '146', '147', '148', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '217', '218', '220', '221', '222', '223', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '240', '241', '242', '243', '245', '246', '247', '248', '249', '250', '251', '252', '253', '255', '256', '257', '259', '260', '261', '263', '264', '265', '267', '268', '269', '270', '271', '272', '273', '274', '275', '276', '277', '278', '279')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@code]</assert>
         <assert test="empty(@code) or (@code = ('1010', '1020', '1030', '1040', '1050', '1060', '1070', '1081', '1082', '1090', '1100', '1110', '1120', '1130', '1140', '1150', '1160', '1171', '1172', '1181', '1182', '1183', '1184', '1185', '1186', '1190', '1200', '1210', '1220', '1230', '1240', '1250', '1260', '1270', '1280', '1999', '2010', '2021', '2022', '2023', '2030', '2040', '2050', '2061', '2062', '2070', '2080', '2090', '2999', '3011', '3012', '3021', '3022', '3030', '3031', '3032', '3041', '3042', '3050', '3060', '3070', '3080', '3081', '3082', '3091', '3092', '3100', '3110', '3120', '3130', '3140', '3150', '3161', '3162', '3170', '3180', '3190', '3200', '3210', '3220', '3230', '3250', '3251', '3999', '4010', '4020', '4032', '4040', '4050', '4060', '4070', '4081', '4082', '4083', '4090', '4100', '4110', '4120', '4130', '4140', '4149', '4151', '4152', '4153', '4160', '4170', '4180', '4190', '4200', '4210', '4220', '4230', '4240', '4250', '4260', '4271', '4272', '4273', '4274', '4275', '4281', '4282', '4283', '4284', '4291', '4292', '4293', '4294', '4310', '4311', '4312', '4320', '4330', '4340', '4350', '4351', '4360', '4370', '4380', '4390', '4400', '4410', '4420', '4430', '4440', '4441', '4450', '4460', '4470', '4480', '4490', '4500', '4600', '4999', '5010', '5020', '5030', '5040', '5050', '5060', '5070', '5071', '5080', '5090', '5100', '5110', '5120', '5130', '5140', '5150', '5160', '5170', '5180', '5190', '5200', '5210', '5999', '6011', '6012', '6013', '6020', '6030', '6040', '6050', '6060', '6070', '6080', '6090', '6100', '6110', '6499', '6510', '6520', '6531', '6532', '6533', '6534', '6542', '6543', '6544', '6545', '6546', '6547', '6548', '6549', '6550', '6551', '6552', '6553', '6599', '7110', '7120', '7130', '7140', '7210', '7220', '7230', '7240', '7250', '7260', '7270', '7280', '7290', '7310', '7320', '7499', '8010', '8020', '8030', '8110', '8120', '8130', '8210', '8220', '8230', '8240', '8250', '8260', '8270', '8280', '8499', 'UNK', 'NI', 'NAV', 'OTH'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@code; allowed=('1010', '1020', '1030', '1040', '1050', '1060', '1070', '1081', '1082', '1090', '1100', '1110', '1120', '1130', '1140', '1150', '1160', '1171', '1172', '1181', '1182', '1183', '1184', '1185', '1186', '1190', '1200', '1210', '1220', '1230', '1240', '1250', '1260', '1270', '1280', '1999', '2010', '2021', '2022', '2023', '2030', '2040', '2050', '2061', '2062', '2070', '2080', '2090', '2999', '3011', '3012', '3021', '3022', '3030', '3031', '3032', '3041', '3042', '3050', '3060', '3070', '3080', '3081', '3082', '3091', '3092', '3100', '3110', '3120', '3130', '3140', '3150', '3161', '3162', '3170', '3180', '3190', '3200', '3210', '3220', '3230', '3250', '3251', '3999', '4010', '4020', '4032', '4040', '4050', '4060', '4070', '4081', '4082', '4083', '4090', '4100', '4110', '4120', '4130', '4140', '4149', '4151', '4152', '4153', '4160', '4170', '4180', '4190', '4200', '4210', '4220', '4230', '4240', '4250', '4260', '4271', '4272', '4273', '4274', '4275', '4281', '4282', '4283', '4284', '4291', '4292', '4293', '4294', '4310', '4311', '4312', '4320', '4330', '4340', '4350', '4351', '4360', '4370', '4380', '4390', '4400', '4410', '4420', '4430', '4440', '4441', '4450', '4460', '4470', '4480', '4490', '4500', '4600', '4999', '5010', '5020', '5030', '5040', '5050', '5060', '5070', '5071', '5080', '5090', '5100', '5110', '5120', '5130', '5140', '5150', '5160', '5170', '5180', '5190', '5200', '5210', '5999', '6011', '6012', '6013', '6020', '6030', '6040', '6050', '6060', '6070', '6080', '6090', '6100', '6110', '6499', '6510', '6520', '6531', '6532', '6533', '6534', '6542', '6543', '6544', '6545', '6546', '6547', '6548', '6549', '6550', '6551', '6552', '6553', '6599', '7110', '7120', '7130', '7140', '7210', '7220', '7230', '7240', '7250', '7260', '7270', '7280', '7290', '7310', '7320', '7499', '8010', '8020', '8030', '8110', '8120', '8130', '8210', '8220', '8230', '8240', '8250', '8260', '8270', '8280', '8499', 'UNK', 'NI', 'NAV', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Reden 'overdracht aan' (lijst PRN)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/reden_overdracht_aan_lijst_prn; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlening/overdrachtdetails/redenen_van_overdracht_aan/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlenerzorginstelling: == -->
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1) [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlenerzorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlenerzorginstelling: == -->
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/*[not(self::zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlenerzorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlenerzorginstelling/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="count(zorginstelling_lvrid) eq 1">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 1) [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_lvrid)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023" [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; max-length=5]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zorgverlenerzorginstelling/zorginstelling/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw: == -->
         <assert test="(count(burgerservicenummer) ge 0) and (count(burgerservicenummer) le 1)">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/burgerservicenummer]</assert>
         <assert test="(count(lokale_persoonsidentificatie) ge 0) and (count(lokale_persoonsidentificatie) le 1)">Fout aantal voorkomens van "Lokale persoonsidentificatie": <value-of select="count(lokale_persoonsidentificatie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie]</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/geboortedatum]</assert>
         <assert test="(count(adres) ge 0) and (count(adres) le 1)">Fout aantal voorkomens van "Adres": <value-of select="count(adres)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/adres]</assert>
         <assert test="(count(etniciteit) ge 0) and (count(etniciteit) le 1)">Fout aantal voorkomens van "Etniciteit": <value-of select="count(etniciteit)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/etniciteit]</assert>
         <assert test="(count(anamnese) ge 0) and (count(anamnese) le 1)">Fout aantal voorkomens van "Anamnese": <value-of select="count(anamnese)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese]</assert>
         <assert test="(count(lengte_gemeten) ge 0) and (count(lengte_gemeten) le 1)">Fout aantal voorkomens van "Lengte (gemeten)": <value-of select="count(lengte_gemeten)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/lengte_gemeten]</assert>
         <assert test="(count(vrouwelijke_genitale_verminkingq) ge 0) and (count(vrouwelijke_genitale_verminkingq) le 1)">Fout aantal voorkomens van "Vrouwelijke genitale verminking?": <value-of select="count(vrouwelijke_genitale_verminkingq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq]</assert>
         <assert test="(count(type_vrouwelijke_genitale_verminking) ge 0) and (count(type_vrouwelijke_genitale_verminking) le 1)">Fout aantal voorkomens van "Type vrouwelijke genitale verminking": <value-of select="count(type_vrouwelijke_genitale_verminking)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw: == -->
      <rule context="/kernset_aanleverbericht/vrouw/*[not(self::burgerservicenummer)][not(self::lokale_persoonsidentificatie)][not(self::geboortedatum)][not(self::adres)][not(self::etniciteit)][not(self::anamnese)][not(self::lengte_gemeten)][not(self::vrouwelijke_genitale_verminkingq)][not(self::type_vrouwelijke_genitale_verminking)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/vrouw/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Burgerservicenummer": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/burgerservicenummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/burgerservicenummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/kernset_aanleverbericht/vrouw/burgerservicenummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/kernset_aanleverbericht/vrouw/burgerservicenummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/kernset_aanleverbericht/vrouw/burgerservicenummer/@value; max-length=9]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Lokale persoonsidentificatie": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lokale persoonsidentificatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10031')">Foutieve informatie voor "Lokale persoonsidentificatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10031" [/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Lokale persoonsidentificatie": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/lokale_persoonsidentificatie; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/geboortedatum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/geboortedatum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040" [/kernset_aanleverbericht/vrouw/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/geboortedatum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/geboortedatum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/adres: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/adres"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Adres": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/adres/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adres": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/adres/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10300')">Foutieve informatie voor "Adres": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10300" [/kernset_aanleverbericht/vrouw/adres/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Adres": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/adres; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/etniciteit: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/etniciteit"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Etniciteit": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/etniciteit/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/etniciteit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10400')">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10400" [/kernset_aanleverbericht/vrouw/etniciteit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Etniciteit": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/etniciteit/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/etniciteit/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Etniciteit": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/etniciteit/@code]</assert>
         <assert test="empty(@code) or (@code = ('14', '13', '12', '3', '4', '5', '8', '11', 'UNK'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/etniciteit/@code; allowed=('14', '13', '12', '3', '4', '5', '8', '11', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Etniciteit": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/etniciteit/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Etniciteit": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/etniciteit/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.2.4.4.13.28', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Etniciteit": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/etniciteit/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Etniciteit": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/etniciteit; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Anamnese": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811')">Foutieve informatie voor "Anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811" [/kernset_aanleverbericht/vrouw/anamnese/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Anamnese": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/lengte_gemeten: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/lengte_gemeten"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Lengte (gemeten)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/lengte_gemeten/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/lengte_gemeten/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20212')">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20212" [/kernset_aanleverbericht/vrouw/lengte_gemeten/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/lengte_gemeten/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 60)">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 60 zijn [/kernset_aanleverbericht/vrouw/lengte_gemeten/@value; min-inclusive=60]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 270)">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 270 zijn [/kernset_aanleverbericht/vrouw/lengte_gemeten/@value; max-inclusive=270]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Lengte (gemeten)": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/vrouw/lengte_gemeten/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'cm')">Foutieve informatie voor "Lengte (gemeten)": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "cm" [/kernset_aanleverbericht/vrouw/lengte_gemeten/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Lengte (gemeten)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/lengte_gemeten; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vrouwelijke genitale verminking?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouwelijke genitale verminking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80675')">Foutieve informatie voor "Vrouwelijke genitale verminking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80675" [/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Vrouwelijke genitale verminking?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Vrouwelijke genitale verminking?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/vrouwelijke_genitale_verminkingq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type vrouwelijke genitale verminking": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80676')">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80676" [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type vrouwelijke genitale verminking": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type vrouwelijke genitale verminking": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@code]</assert>
         <assert test="empty(@code) or (@code = ('130631000119108', '130621000119105', '130611000119103', '107411000119108', 'UNK', 'NI'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@code; allowed=('130631000119108', '130621000119105', '130611000119103', '107411000119108', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type vrouwelijke genitale verminking": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type vrouwelijke genitale verminking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type vrouwelijke genitale verminking": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type vrouwelijke genitale verminking": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/type_vrouwelijke_genitale_verminking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/vrouw/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/adres"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw/adres: == -->
         <assert test="(count(postcode) ge 0) and (count(postcode) le 1)">Fout aantal voorkomens van "Postcode": <value-of select="count(postcode)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/adres/postcode]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/adres/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw/adres: == -->
      <rule context="/kernset_aanleverbericht/vrouw/adres/*[not(self::postcode)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/vrouw/adres/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/adres/postcode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/adres/postcode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Postcode": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/adres/postcode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/adres/postcode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10304')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10304" [/kernset_aanleverbericht/vrouw/adres/postcode/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/adres/postcode; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/vrouw/adres/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw/anamnese: == -->
         <assert test="(count(onder_behandeling_geweestq) ge 0) and (count(onder_behandeling_geweestq) le 1)">Fout aantal voorkomens van "Onder behandeling (geweest)?": <value-of select="count(onder_behandeling_geweestq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq]</assert>
         <assert test="(count(algemene_anamnese) ge 0) and (count(algemene_anamnese) le 1)">Fout aantal voorkomens van "Algemene anamnese": <value-of select="count(algemene_anamnese)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw/anamnese: == -->
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/*[not(self::onder_behandeling_geweestq)][not(self::algemene_anamnese)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/vrouw/anamnese/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Onder behandeling (geweest)?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Onder behandeling (geweest)?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82020')">Foutieve informatie voor "Onder behandeling (geweest)?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82020" [/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Onder behandeling (geweest)?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Onder behandeling (geweest)?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/onder_behandeling_geweestq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Algemene anamnese": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Algemene anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80904')">Foutieve informatie voor "Algemene anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80904" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Algemene anamnese": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/vrouw/anamnese/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese"><!-- == Check occurrences of children of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese: == -->
         <assert test="(count(autoimmuun_aandoeningq) ge 0) and (count(autoimmuun_aandoeningq) le 1)">Fout aantal voorkomens van "Auto-immuun aandoening?": <value-of select="count(autoimmuun_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq]</assert>
         <assert test="count(autoimmuun_aandoening) ge 0">Fout aantal voorkomens van "Auto-immuun aandoening": <value-of select="count(autoimmuun_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening]</assert>
         <assert test="(count(cardiovasculaire_aandoeningq) ge 0) and (count(cardiovasculaire_aandoeningq) le 1)">Fout aantal voorkomens van "Cardiovasculaire aandoening?": <value-of select="count(cardiovasculaire_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq]</assert>
         <assert test="count(cardiovasculaire_aandoening) ge 0">Fout aantal voorkomens van "Cardiovasculaire aandoening": <value-of select="count(cardiovasculaire_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening]</assert>
         <assert test="(count(urogenitale_aandoeningq) ge 0) and (count(urogenitale_aandoeningq) le 1)">Fout aantal voorkomens van "Urogenitale aandoening?": <value-of select="count(urogenitale_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq]</assert>
         <assert test="count(urogenitale_aandoening) ge 0">Fout aantal voorkomens van "Urogenitale aandoening": <value-of select="count(urogenitale_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening]</assert>
         <assert test="(count(oncologische_aandoeningq) ge 0) and (count(oncologische_aandoeningq) le 1)">Fout aantal voorkomens van "Oncologische aandoening?": <value-of select="count(oncologische_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq]</assert>
         <assert test="count(oncologische_aandoening) ge 0">Fout aantal voorkomens van "Oncologische aandoening": <value-of select="count(oncologische_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening]</assert>
         <assert test="(count(schildklier_aandoeningq) ge 0) and (count(schildklier_aandoeningq) le 1)">Fout aantal voorkomens van "Schildklier aandoening?": <value-of select="count(schildklier_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq]</assert>
         <assert test="(count(schildklier_aandoening) ge 0) and (count(schildklier_aandoening) le 1)">Fout aantal voorkomens van "Schildklier aandoening": <value-of select="count(schildklier_aandoening)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening]</assert>
         <assert test="(count(diabetes_mellitusq) ge 0) and (count(diabetes_mellitusq) le 1)">Fout aantal voorkomens van "Diabetes mellitus?": <value-of select="count(diabetes_mellitusq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq]</assert>
         <assert test="(count(neurologische_aandoeningq) ge 0) and (count(neurologische_aandoeningq) le 1)">Fout aantal voorkomens van "Neurologische aandoening?": <value-of select="count(neurologische_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq]</assert>
         <assert test="count(neurologische_aandoening) ge 0">Fout aantal voorkomens van "Neurologische aandoening": <value-of select="count(neurologische_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening]</assert>
         <assert test="(count(infectieziekteq) ge 0) and (count(infectieziekteq) le 1)">Fout aantal voorkomens van "Infectieziekte?": <value-of select="count(infectieziekteq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq]</assert>
         <assert test="count(infectieziekte) ge 0">Fout aantal voorkomens van "Infectieziekte": <value-of select="count(infectieziekte)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte]</assert>
         <assert test="(count(mdl_aandoeningq) ge 0) and (count(mdl_aandoeningq) le 1)">Fout aantal voorkomens van "MDL aandoening?": <value-of select="count(mdl_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq]</assert>
         <assert test="count(mdl_aandoening) ge 0">Fout aantal voorkomens van "MDL aandoening": <value-of select="count(mdl_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening]</assert>
         <assert test="(count(anemieq) ge 0) and (count(anemieq) le 1)">Fout aantal voorkomens van "Anemie?": <value-of select="count(anemieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq]</assert>
         <assert test="count(anemie) ge 0">Fout aantal voorkomens van "Anemie": <value-of select="count(anemie)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie]</assert>
         <assert test="(count(longaandoeningq) ge 0) and (count(longaandoeningq) le 1)">Fout aantal voorkomens van "Longaandoening?": <value-of select="count(longaandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq]</assert>
         <assert test="count(longaandoening) ge 0">Fout aantal voorkomens van "Longaandoening": <value-of select="count(longaandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening]</assert>
         <assert test="(count(gynaecologische_aandoeningq) ge 0) and (count(gynaecologische_aandoeningq) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening?": <value-of select="count(gynaecologische_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq]</assert>
         <assert test="count(gynaecologische_aandoening) ge 0">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening]</assert>
         <assert test="(count(orthopedische_afwijkingq) ge 0) and (count(orthopedische_afwijkingq) le 1)">Fout aantal voorkomens van "Orthopedische afwijking?": <value-of select="count(orthopedische_afwijkingq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq]</assert>
         <assert test="count(orthopedische_afwijking) ge 0">Fout aantal voorkomens van "Orthopedische afwijking": <value-of select="count(orthopedische_afwijking)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking]</assert>
         <assert test="(count(bloedtransfusieq) ge 0) and (count(bloedtransfusieq) le 1)">Fout aantal voorkomens van "Bloedtransfusie?": <value-of select="count(bloedtransfusieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq]</assert>
         <assert test="(count(transfusiereactieq) ge 0) and (count(transfusiereactieq) le 1)">Fout aantal voorkomens van "Transfusiereactie?": <value-of select="count(transfusiereactieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq]</assert>
         <assert test="(count(operatieq) ge 0) and (count(operatieq) le 1)">Fout aantal voorkomens van "Operatie?": <value-of select="count(operatieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq]</assert>
         <assert test="count(type_operatie) ge 0">Fout aantal voorkomens van "Type operatie": <value-of select="count(type_operatie)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie]</assert>
         <assert test="(count(stollingsprobleemq) ge 0) and (count(stollingsprobleemq) le 1)">Fout aantal voorkomens van "Stollingsprobleem?": <value-of select="count(stollingsprobleemq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq]</assert>
         <assert test="count(type_stollingsprobleem) ge 0">Fout aantal voorkomens van "Type stollingsprobleem": <value-of select="count(type_stollingsprobleem)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem]</assert>
         <assert test="(count(psychiatrieq) ge 0) and (count(psychiatrieq) le 1)">Fout aantal voorkomens van "Psychiatrie?": <value-of select="count(psychiatrieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq]</assert>
         <assert test="(count(overige_aandoeningq) ge 0) and (count(overige_aandoeningq) le 1)">Fout aantal voorkomens van "Overige aandoening?": <value-of select="count(overige_aandoeningq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq]</assert>
         <assert test="count(overige_aandoening) ge 0">Fout aantal voorkomens van "Overige aandoening": <value-of select="count(overige_aandoening)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese: == -->
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/*[not(self::autoimmuun_aandoeningq)][not(self::autoimmuun_aandoening)][not(self::cardiovasculaire_aandoeningq)][not(self::cardiovasculaire_aandoening)][not(self::urogenitale_aandoeningq)][not(self::urogenitale_aandoening)][not(self::oncologische_aandoeningq)][not(self::oncologische_aandoening)][not(self::schildklier_aandoeningq)][not(self::schildklier_aandoening)][not(self::diabetes_mellitusq)][not(self::neurologische_aandoeningq)][not(self::neurologische_aandoening)][not(self::infectieziekteq)][not(self::infectieziekte)][not(self::mdl_aandoeningq)][not(self::mdl_aandoening)][not(self::anemieq)][not(self::anemie)][not(self::longaandoeningq)][not(self::longaandoening)][not(self::gynaecologische_aandoeningq)][not(self::gynaecologische_aandoening)][not(self::orthopedische_afwijkingq)][not(self::orthopedische_afwijking)][not(self::bloedtransfusieq)][not(self::transfusiereactieq)][not(self::operatieq)][not(self::type_operatie)][not(self::stollingsprobleemq)][not(self::type_stollingsprobleem)][not(self::psychiatrieq)][not(self::overige_aandoeningq)][not(self::overige_aandoening)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Auto-immuun aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Auto-immuun aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80905')">Foutieve informatie voor "Auto-immuun aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80905" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Auto-immuun aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Auto-immuun aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Auto-immuun aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82220')">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82220" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Auto-immuun aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Auto-immuun aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('55464009', '396332003', 'OTH'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@code; allowed=('55464009', '396332003', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Auto-immuun aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Auto-immuun aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Auto-immuun aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Auto-immuun aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/autoimmuun_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Cardiovasculaire aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cardiovasculaire aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82216')">Foutieve informatie voor "Cardiovasculaire aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82216" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cardiovasculaire aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Cardiovasculaire aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Cardiovasculaire aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80906')">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80906" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Cardiovasculaire aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Cardiovasculaire aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('38341003', '85898001', '698247007', '128599005', 'OTH'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@code; allowed=('38341003', '85898001', '698247007', '128599005', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Cardiovasculaire aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Cardiovasculaire aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Cardiovasculaire aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Cardiovasculaire aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/cardiovasculaire_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Urogenitale aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urogenitale aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80907')">Foutieve informatie voor "Urogenitale aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80907" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Urogenitale aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Urogenitale aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Urogenitale aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82267')">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82267" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Urogenitale aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Urogenitale aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('45816000', '61373006', '236425005'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@code; allowed=('45816000', '61373006', '236425005')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Urogenitale aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Urogenitale aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Urogenitale aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Urogenitale aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/urogenitale_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Oncologische aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Oncologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80908')">Foutieve informatie voor "Oncologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80908" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Oncologische aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Oncologische aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Oncologische aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82221')">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82221" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Oncologische aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Oncologische aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('93796005', '285432005', '93143009', '93880001', '372244006', 'OTH'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@code; allowed=('93796005', '285432005', '93143009', '93880001', '372244006', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Oncologische aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Oncologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Oncologische aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Oncologische aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/oncologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Schildklier aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Schildklier aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82217')">Foutieve informatie voor "Schildklier aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82217" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Schildklier aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Schildklier aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Schildklier aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80909')">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80909" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Schildklier aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@value; allowed=('1', '2')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Schildklier aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('40930008', '34486009'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@code; allowed=('40930008', '34486009')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Schildklier aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Schildklier aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Schildklier aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Schildklier aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/schildklier_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diabetes mellitus?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes mellitus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80910')">Foutieve informatie voor "Diabetes mellitus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80910" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes mellitus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Diabetes mellitus?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/diabetes_mellitusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Neurologische aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Neurologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82218')">Foutieve informatie voor "Neurologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82218" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Neurologische aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Neurologische aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Neurologische aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80912')">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80912" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Neurologische aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Neurologische aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('84757009', '230690007', '24700007', '37796009', '84857004', '399244003', 'OTH'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@code; allowed=('84757009', '230690007', '24700007', '37796009', '84857004', '399244003', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Neurologische aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Neurologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Neurologische aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Neurologische aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/neurologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Infectieziekte?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectieziekte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80913')">Foutieve informatie voor "Infectieziekte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80913" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Infectieziekte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Infectieziekte?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekteq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Infectieziekte": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82210')">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82210" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Infectieziekte": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '5', '6', '8', '9', '10', '11', '12', '13', '14', '15', '16', '18', '19', '20', '21', '22', '23'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@value; allowed=('2', '3', '4', '5', '6', '8', '9', '10', '11', '12', '13', '14', '15', '16', '18', '19', '20', '21', '22', '23')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Infectieziekte": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@code]</assert>
         <assert test="empty(@code) or (@code = ('240589008', '15628003', '426933007', '266096002', '56717001', '28944009', '23513009', '165806002', '86406008', '66071002', '50711007', '36653000', '309465005', '186748004', '76272004', '187192000', '23502006', '61462000', '56335008', 'OTH'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@code; allowed=('240589008', '15628003', '426933007', '266096002', '56717001', '28944009', '23513009', '165806002', '86406008', '66071002', '50711007', '36653000', '309465005', '186748004', '76272004', '187192000', '23502006', '61462000', '56335008', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Infectieziekte": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectieziekte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Infectieziekte": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Infectieziekte": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/infectieziekte; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "MDL aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "MDL aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80914')">Foutieve informatie voor "MDL aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80914" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "MDL aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "MDL aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "MDL aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82219')">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82219" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "MDL aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "MDL aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('328383001', '64766004', '34000006'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@code; allowed=('328383001', '64766004', '34000006')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "MDL aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "MDL aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "MDL aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "MDL aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/mdl_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Anemie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anemie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80915')">Foutieve informatie voor "Anemie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80915" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Anemie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Anemie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Anemie": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anemie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82222')">Foutieve informatie voor "Anemie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82222" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Anemie": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Anemie": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@code]</assert>
         <assert test="empty(@code) or (@code = ('87522002', '80141007', '127040003', '40108008'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@code; allowed=('87522002', '80141007', '127040003', '40108008')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Anemie": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Anemie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Anemie": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Anemie": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/anemie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Longaandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Longaandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80916')">Foutieve informatie voor "Longaandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80916" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Longaandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Longaandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Longaandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82266')">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82266" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Longaandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Longaandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('195967001', '13645005', '31541009', 'OTH', 'NI'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@code; allowed=('195967001', '13645005', '31541009', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Longaandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Longaandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Longaandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Longaandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/longaandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gynaecologische aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82211')">Foutieve informatie voor "Gynaecologische aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82211" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Gynaecologische aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80917')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80917" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@code; allowed=('129103003', '95315005', '37849005', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/gynaecologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Orthopedische afwijking?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Orthopedische afwijking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82213')">Foutieve informatie voor "Orthopedische afwijking?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82213" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Orthopedische afwijking?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Orthopedische afwijking?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijkingq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Orthopedische afwijking": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80918')">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80918" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Orthopedische afwijking": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Orthopedische afwijking": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@code]</assert>
         <assert test="empty(@code) or (@code = ('48334007', '282771003', 'OTH'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@code; allowed=('48334007', '282771003', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Orthopedische afwijking": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Orthopedische afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Orthopedische afwijking": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Orthopedische afwijking": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/orthopedische_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bloedtransfusie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedtransfusie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10805')">Foutieve informatie voor "Bloedtransfusie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10805" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedtransfusie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Bloedtransfusie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/bloedtransfusieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Transfusiereactie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Transfusiereactie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82231')">Foutieve informatie voor "Transfusiereactie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82231" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Transfusiereactie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Transfusiereactie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/transfusiereactieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Operatie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Operatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80939')">Foutieve informatie voor "Operatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80939" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Operatie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Operatie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/operatieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type operatie": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80818')">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80818" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type operatie": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type operatie": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@code]</assert>
         <assert test="empty(@code) or (@code = ('12658000', '68688001', '11466000', '28233006', '79876008', '42010004', '64887002', '112697007', '12745006', '129152004:260686004=129284003', '21371007', '86481000', '80146002', '177250006', '34853001', '392090004', '118717007:260686004=129284003', '175898006', '15463004', '64915003', '13119002', '16545005', 'UNK', 'OTH'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@code; allowed=('12658000', '68688001', '11466000', '28233006', '79876008', '42010004', '64887002', '112697007', '12745006', '129152004:260686004=129284003', '21371007', '86481000', '80146002', '177250006', '34853001', '392090004', '118717007:260686004=129284003', '175898006', '15463004', '64915003', '13119002', '16545005', 'UNK', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type operatie": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type operatie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type operatie": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type operatie": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_operatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Stollingsprobleem?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Stollingsprobleem?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80940')">Foutieve informatie voor "Stollingsprobleem?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80940" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Stollingsprobleem?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Stollingsprobleem?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/stollingsprobleemq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type stollingsprobleem": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80817')">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80817" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type stollingsprobleem": Attribuut "value" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type stollingsprobleem": Attribuut "code" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@code]</assert>
         <assert test="empty(@code) or (@code = ('128105004', '90935002', '302215000', '67406007', '234467004', '36351005', '76407009', '1563006', '307116001', '307115002', '46981006', '128053003', '59282003', 'OTH'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@code; allowed=('128105004', '90935002', '302215000', '67406007', '234467004', '36351005', '76407009', '1563006', '307116001', '307115002', '46981006', '128053003', '59282003', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type stollingsprobleem": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type stollingsprobleem": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type stollingsprobleem": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type stollingsprobleem": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/type_stollingsprobleem; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Psychiatrie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Psychiatrie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82159')">Foutieve informatie voor "Psychiatrie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82159" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Psychiatrie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Psychiatrie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/psychiatrieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overige aandoening?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82212')">Foutieve informatie voor "Overige aandoening?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82212" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Overige aandoening?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Overige aandoening?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoeningq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overige aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80919')">Foutieve informatie voor "Overige aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80919" [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Overige aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/overige_aandoening; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/vrouw/anamnese/algemene_anamnese/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap: == -->
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap]</assert>
         <assert test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)">Fout aantal voorkomens van "Definitieve à terme datum": <value-of select="count(definitieve_a_terme_datum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum]</assert>
         <assert test="count(diagnose) ge 0">Fout aantal voorkomens van "Diagnose": <value-of select="count(diagnose)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose]</assert>
         <assert test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)">Fout aantal voorkomens van "Irregulaire antistoffen?": <value-of select="count(irregulaire_antistoffenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq]</assert>
         <assert test="(count(eerdere_bevalling) ge 0) and (count(eerdere_bevalling) le 1)">Fout aantal voorkomens van "Eerdere bevalling": <value-of select="count(eerdere_bevalling)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/*[not(self::wijze_einde_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::diagnose)][not(self::irregulaire_antistoffenq)][not(self::eerdere_bevalling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80623')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80623" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Definitieve à terme datum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82337')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82337" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Definitieve à terme datum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/definitieve_a_terme_datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diagnose": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82314')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82314" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82214')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82214" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Irregulaire antistoffen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/irregulaire_antistoffenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Eerdere bevalling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Eerdere bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.18')">Foutieve informatie voor "Eerdere bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.18" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Eerdere bevalling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose: == -->
         <assert test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening]</assert>
         <assert test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)">Fout aantal voorkomens van "Bloedverlies?": <value-of select="count(bloedverliesq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq]</assert>
         <assert test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)">Fout aantal voorkomens van "Cervixinsufficiëntie?": <value-of select="count(cervixinsufficientieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq]</assert>
         <assert test="(count(infectie) ge 0) and (count(infectie) le 1)">Fout aantal voorkomens van "Infectie": <value-of select="count(infectie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie]</assert>
         <assert test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)">Fout aantal voorkomens van "Hyperemesis gravidarum?": <value-of select="count(hyperemesis_gravidarumq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq]</assert>
         <assert test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)">Fout aantal voorkomens van "Hypertensieve aandoening": <value-of select="count(hypertensieve_aandoening)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening]</assert>
         <assert test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)">Fout aantal voorkomens van "Zwangerschapscholestase?": <value-of select="count(zwangerschapscholestaseq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq]</assert>
         <assert test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)">Fout aantal voorkomens van "Diabetes gravidarum met insuline?": <value-of select="count(diabetes_gravidarum_met_insulineq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq]</assert>
         <assert test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)">Fout aantal voorkomens van "Afwijkende groei foetus": <value-of select="count(afwijkende_groei_foetus)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus]</assert>
         <assert test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)">Fout aantal voorkomens van "Dreigende partus immaturus?": <value-of select="count(dreigende_partus_immaturusq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq]</assert>
         <assert test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)">Fout aantal voorkomens van "Dreigende partus prematurus?": <value-of select="count(dreigende_partus_prematurusq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq]</assert>
         <assert test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)">Fout aantal voorkomens van "Abruptio placentae?": <value-of select="count(abruptio_placentaeq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/*[not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82317')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82317" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@code; allowed=('129103003', '95315005', '37849005', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/gynaecologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bloedverlies?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82318')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82318" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Bloedverlies?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/bloedverliesq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82320')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82320" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Cervixinsufficiëntie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/cervixinsufficientieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Infectie": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82321')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82321" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Infectie": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Infectie": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@code]</assert>
         <assert test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@code; allowed=('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Infectie": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Infectie": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Infectie": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/infectie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82322')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82322" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hyperemesis gravidarum?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hyperemesis_gravidarumq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82323')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82323" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@code; allowed=('48194001', '398254007', '95605009', '15938005')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hypertensieve aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/hypertensieve_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82324')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82324" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zwangerschapscholestase?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/zwangerschapscholestaseq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82325')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82325" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Diabetes gravidarum met insuline?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/diabetes_gravidarum_met_insulineq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82326')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82326" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@code]</assert>
         <assert test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@code; allowed=('199616008', '267258002', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Afwijkende groei foetus": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/afwijkende_groei_foetus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82327')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82327" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Dreigende partus immaturus?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_immaturusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82328')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82328" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Dreigende partus prematurus?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/dreigende_partus_prematurusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Abruptio placentae?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82329')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82329" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Abruptio placentae?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/abruptio_placentaeq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/diagnose/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling: == -->
         <assert test="(count(placenta) ge 0) and (count(placenta) le 1)">Fout aantal voorkomens van "Placenta": <value-of select="count(placenta)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta]</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies]</assert>
         <assert test="count(vorige_uitkomst_per_kind) ge 0">Fout aantal voorkomens van "Vorige uitkomst (per kind)": <value-of select="count(vorige_uitkomst_per_kind)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/*[not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::vorige_uitkomst_per_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Placenta": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80718')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80718" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Placenta": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10598')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10598" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vorige uitkomst (per kind)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vorige uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.19')">Foutieve informatie voor "Vorige uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.19" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vorige uitkomst (per kind)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta: == -->
         <assert test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)">Fout aantal voorkomens van "Geboorte placenta": <value-of select="count(geboorte_placenta)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/*[not(self::geboorte_placenta)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboorte placenta": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82336')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82336" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboorte placenta": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Geboorte placenta": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@code]</assert>
         <assert test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@code; allowed=('0', '2', '3', '4', 'OTH', 'NI', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Geboorte placenta": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Geboorte placenta": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geboorte placenta": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/geboorte_placenta; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/placenta/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind: == -->
         <assert test="(count(vorige_baring) ge 0) and (count(vorige_baring) le 1)">Fout aantal voorkomens van "Vorige baring": <value-of select="count(vorige_baring)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/*[not(self::vorige_baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vorige baring": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vorige baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80709')">Foutieve informatie voor "Vorige baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80709" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vorige baring": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring: == -->
         <assert test="count(demografische_gegevens) ge 0">Fout aantal voorkomens van "Demografische gegevens": <value-of select="count(demografische_gegevens)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens]</assert>
         <assert test="(count(kindspecifieke_gegevens_vorige_uitkomsten) ge 0) and (count(kindspecifieke_gegevens_vorige_uitkomsten) le 1)">Fout aantal voorkomens van "Kindspecifieke gegevens vorige uitkomsten": <value-of select="count(kindspecifieke_gegevens_vorige_uitkomsten)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/*[not(self::demografische_gegevens)][not(self::kindspecifieke_gegevens_vorige_uitkomsten)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Demografische gegevens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80696')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80696" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.21')">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.21" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke gegevens vorige uitkomsten": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens: == -->
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/*[not(self::geboortedatum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80702')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80702" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/geboortedatum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/demografische_gegevens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus]</assert>
         <assert test="(count(percentiel_van_het_geboortegewicht) ge 0) and (count(percentiel_van_het_geboortegewicht) le 1)">Fout aantal voorkomens van "Percentiel van het geboortegewicht": <value-of select="count(percentiel_van_het_geboortegewicht)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht]</assert>
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min]</assert>
         <assert test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen?": <value-of select="count(congenitale_afwijkingenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq]</assert>
         <assert test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen (groep)": <value-of select="count(congenitale_afwijkingen_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/*[not(self::type_partus)][not(self::percentiel_van_het_geboortegewicht)][not(self::apgarscore_na_5_min)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type partus": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80624')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80624" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type partus": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type partus": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@code]</assert>
         <assert test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@code; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type partus": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type partus": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10605')">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10605" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "value" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "code" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'NI'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@code; allowed=('1', '2', '3', '4', '5', '6', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Percentiel van het geboortegewicht": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/percentiel_van_het_geboortegewicht; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10606')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10606" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min/@value; max-inclusive=10]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/apgarscore_na_5_min; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80997')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80997" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Congenitale afwijkingen (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80998')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80998" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep: == -->
         <assert test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)">Fout aantal voorkomens van "Chromosomale afwijkingen?": <value-of select="count(chromosomale_afwijkingenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep: == -->
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/*[not(self::chromosomale_afwijkingenq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.81002')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.81002" [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Chromosomale afwijkingen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/chromosomale_afwijkingenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap/eerdere_bevalling/vorige_uitkomst_per_kind/vorige_baring/kindspecifieke_gegevens_vorige_uitkomsten/congenitale_afwijkingen_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap: == -->
         <assert test="(count(dossiernummer) ge 0) and (count(dossiernummer) le 1)">Fout aantal voorkomens van "Dossiernummer": <value-of select="count(dossiernummer)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/dossiernummer]</assert>
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/graviditeit]</assert>
         <assert test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)">Fout aantal voorkomens van "Pariteit (vóór deze zwangerschap)": <value-of select="count(pariteit_voor_deze_zwangerschap)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap]</assert>
         <assert test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)">Fout aantal voorkomens van "Definitieve à terme datum": <value-of select="count(definitieve_a_terme_datum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum]</assert>
         <assert test="(count(voornemens) ge 0) and (count(voornemens) le 1)">Fout aantal voorkomens van "Voornemens": <value-of select="count(voornemens)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/voornemens]</assert>
         <assert test="count(prenatale_controle) ge 0">Fout aantal voorkomens van "Prenatale controle": <value-of select="count(prenatale_controle)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zwangerschap/prenatale_controle]</assert>
         <assert test="count(diagnose) ge 0">Fout aantal voorkomens van "Diagnose": <value-of select="count(diagnose)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zwangerschap/diagnose]</assert>
         <assert test="count(intrauteriene_behandeling) ge 0">Fout aantal voorkomens van "Intra-uteriene behandeling": <value-of select="count(intrauteriene_behandeling)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling]</assert>
         <assert test="(count(maternale_sterfteq) ge 0) and (count(maternale_sterfteq) le 1)">Fout aantal voorkomens van "Maternale sterfte?": <value-of select="count(maternale_sterfteq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/maternale_sterfteq]</assert>
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/*[not(self::dossiernummer)][not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::voornemens)][not(self::prenatale_controle)][not(self::diagnose)][not(self::intrauteriene_behandeling)][not(self::maternale_sterfteq)][not(self::wijze_einde_zwangerschap)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/dossiernummer: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/dossiernummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dossiernummer": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/dossiernummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dossiernummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/dossiernummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.999.60.5.6.3.1')">Foutieve informatie voor "Dossiernummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.999.60.5.6.3.1" [/kernset_aanleverbericht/zwangerschap/dossiernummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Dossiernummer": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/dossiernummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Graviditeit": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/graviditeit/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/graviditeit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/kernset_aanleverbericht/zwangerschap/graviditeit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/graviditeit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/kernset_aanleverbericht/zwangerschap/graviditeit/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn [/kernset_aanleverbericht/zwangerschap/graviditeit/@value; max-inclusive=75]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/graviditeit; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150" [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap/@value; max-inclusive=30]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/pariteit_voor_deze_zwangerschap; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Definitieve à terme datum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160" [/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Definitieve à terme datum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/definitieve_a_terme_datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/voornemens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voornemens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/voornemens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornemens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/voornemens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80671')">Foutieve informatie voor "Voornemens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80671" [/kernset_aanleverbericht/zwangerschap/voornemens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Voornemens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/voornemens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Prenatale controle": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prenatale controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80732')">Foutieve informatie voor "Prenatale controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80732" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Prenatale controle": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diagnose": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268" [/kernset_aanleverbericht/zwangerschap/diagnose/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Intra-uteriene behandeling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82230')">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82230" [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Intra-uteriene behandeling": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Intra-uteriene behandeling": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@code]</assert>
         <assert test="empty(@code) or (@code = ('45460008', '265633004', '386809009', '177112007', '236949002', 'OTH'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@code; allowed=('45460008', '265633004', '386809009', '177112007', '236949002', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Intra-uteriene behandeling": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Intra-uteriene behandeling": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Intra-uteriene behandeling": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Intra-uteriene behandeling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/intrauteriene_behandeling; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/maternale_sterfteq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/maternale_sterfteq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Maternale sterfte?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/maternale_sterfteq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/maternale_sterfteq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20670')">Foutieve informatie voor "Maternale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20670" [/kernset_aanleverbericht/zwangerschap/maternale_sterfteq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Maternale sterfte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/maternale_sterfteq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Maternale sterfte?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/maternale_sterfteq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625" [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zwangerschap/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap/voornemens: == -->
         <assert test="(count(voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie) ge 0) and (count(voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie) le 1)">Fout aantal voorkomens van "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": <value-of select="count(voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/voornemens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap/voornemens: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens/*[not(self::voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zwangerschap/voornemens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20261')">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20261" [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@code]</assert>
         <assert test="empty(@code) or (@code = ('169813005', '23', '22232009', '05', '00', 'UNK', 'NI'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@code; allowed=('169813005', '23', '22232009', '05', '00', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Voorgenomen plaats baring tijdens zwangerschap (type locatie)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/voornemens/voorgenomen_plaats_baring_tijdens_zwangerschap_type_locatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zwangerschap/voornemens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap/prenatale_controle: == -->
         <assert test="count(datum_controle) eq 1">Fout aantal voorkomens van "Datum controle": <value-of select="count(datum_controle)"/> (verwacht: 1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle]</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur]</assert>
         <assert test="(count(leven_voelen) ge 0) and (count(leven_voelen) le 1)">Fout aantal voorkomens van "Leven voelen": <value-of select="count(leven_voelen)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen]</assert>
         <assert test="(count(rookgedrag) ge 0) and (count(rookgedrag) le 1)">Fout aantal voorkomens van "Rookgedrag": <value-of select="count(rookgedrag)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag]</assert>
         <assert test="(count(alcoholgebruik) ge 0) and (count(alcoholgebruik) le 1)">Fout aantal voorkomens van "Alcoholgebruik": <value-of select="count(alcoholgebruik)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik]</assert>
         <assert test="(count(drugsgebruikq) ge 0) and (count(drugsgebruikq) le 1)">Fout aantal voorkomens van "Drugsgebruik?": <value-of select="count(drugsgebruikq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq]</assert>
         <assert test="(count(gewicht_gemeten) ge 0) and (count(gewicht_gemeten) le 1)">Fout aantal voorkomens van "Gewicht (gemeten)": <value-of select="count(gewicht_gemeten)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/prenatale_controle/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap/prenatale_controle: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/*[not(self::datum_controle)][not(self::zwangerschapsduur)][not(self::leven_voelen)][not(self::rookgedrag)][not(self::alcoholgebruik)][not(self::drugsgebruikq)][not(self::gewicht_gemeten)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zwangerschap/prenatale_controle/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum controle": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80737')">Foutieve informatie voor "Datum controle": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80737" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum controle": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum controle": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/datum_controle; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80738')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80738" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Leven voelen": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80746')">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80746" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Leven voelen": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Leven voelen": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@code]</assert>
         <assert test="empty(@code) or (@code = ('289431008', '276372004', '276369006', '289432001'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@code; allowed=('289431008', '276372004', '276369006', '289432001')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Leven voelen": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Leven voelen": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Leven voelen": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Leven voelen": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/leven_voelen; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Rookgedrag": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80810')">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80810" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Rookgedrag": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Rookgedrag": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'UNK'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@code; allowed=('1', '2', '3', '4', '5', '6', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Rookgedrag": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rookgedrag": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.2.4.4.13.58', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Rookgedrag": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Rookgedrag": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/rookgedrag; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Alcoholgebruik": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80747')">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80747" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Alcoholgebruik": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Alcoholgebruik": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@code; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Alcoholgebruik": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.59', '2.16.840.1.113883.2.4.4.13.59', '2.16.840.1.113883.2.4.4.13.59'))">Foutieve informatie voor "Alcoholgebruik": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.59', '2.16.840.1.113883.2.4.4.13.59', '2.16.840.1.113883.2.4.4.13.59')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Alcoholgebruik": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Alcoholgebruik": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/alcoholgebruik; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Drugsgebruik?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Drugsgebruik?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82102')">Foutieve informatie voor "Drugsgebruik?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82102" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Drugsgebruik?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Drugsgebruik?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/drugsgebruikq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gewicht (gemeten)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20211')">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20211" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 25)">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 25 zijn [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@value; min-inclusive=25]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 249.9)">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 249.9 zijn [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@value; max-inclusive=249.9]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Gewicht (gemeten)": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'kg')">Foutieve informatie voor "Gewicht (gemeten)": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "kg" [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Gewicht (gemeten)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/prenatale_controle/gewicht_gemeten; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zwangerschap/prenatale_controle/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose"><!-- == Check occurrences of children of /kernset_aanleverbericht/zwangerschap/diagnose: == -->
         <assert test="(count(datum) ge 0) and (count(datum) le 1)">Fout aantal voorkomens van "Datum": <value-of select="count(datum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/datum]</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur]</assert>
         <assert test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening]</assert>
         <assert test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)">Fout aantal voorkomens van "Bloedverlies?": <value-of select="count(bloedverliesq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq]</assert>
         <assert test="(count(partiele_molaq) ge 0) and (count(partiele_molaq) le 1)">Fout aantal voorkomens van "Partiële mola?": <value-of select="count(partiele_molaq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq]</assert>
         <assert test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)">Fout aantal voorkomens van "Cervixinsufficiëntie?": <value-of select="count(cervixinsufficientieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq]</assert>
         <assert test="(count(infectie) ge 0) and (count(infectie) le 1)">Fout aantal voorkomens van "Infectie": <value-of select="count(infectie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/infectie]</assert>
         <assert test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)">Fout aantal voorkomens van "Hyperemesis gravidarum?": <value-of select="count(hyperemesis_gravidarumq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq]</assert>
         <assert test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)">Fout aantal voorkomens van "Hypertensieve aandoening": <value-of select="count(hypertensieve_aandoening)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening]</assert>
         <assert test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)">Fout aantal voorkomens van "Zwangerschapscholestase?": <value-of select="count(zwangerschapscholestaseq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq]</assert>
         <assert test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)">Fout aantal voorkomens van "Diabetes gravidarum met insuline?": <value-of select="count(diabetes_gravidarum_met_insulineq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq]</assert>
         <assert test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)">Fout aantal voorkomens van "Afwijkende groei foetus": <value-of select="count(afwijkende_groei_foetus)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus]</assert>
         <assert test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)">Fout aantal voorkomens van "Dreigende partus immaturus?": <value-of select="count(dreigende_partus_immaturusq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq]</assert>
         <assert test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)">Fout aantal voorkomens van "Dreigende partus prematurus?": <value-of select="count(dreigende_partus_prematurusq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq]</assert>
         <assert test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)">Fout aantal voorkomens van "Abruptio placentae?": <value-of select="count(abruptio_placentaeq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/zwangerschap/diagnose/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/zwangerschap/diagnose: == -->
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/*[not(self::datum)][not(self::zwangerschapsduur)][not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::partiele_molaq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/zwangerschap/diagnose/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82272')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82272" [/kernset_aanleverbericht/zwangerschap/diagnose/datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/datum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82285')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82285" [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269" [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@code; allowed=('129103003', '95315005', '37849005', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/gynaecologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bloedverlies?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270" [/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Bloedverlies?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/bloedverliesq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Partiële mola?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Partiële mola?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82286')">Foutieve informatie voor "Partiële mola?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82286" [/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Partiële mola?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Partiële mola?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/partiele_molaq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271" [/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Cervixinsufficiëntie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/cervixinsufficientieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/infectie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/infectie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Infectie": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273" [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Infectie": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Infectie": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@code]</assert>
         <assert test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@code; allowed=('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Infectie": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Infectie": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/infectie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Infectie": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/infectie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274" [/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hyperemesis gravidarum?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/hyperemesis_gravidarumq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275" [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@code; allowed=('48194001', '398254007', '95605009', '15938005')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hypertensieve aandoening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/hypertensieve_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276" [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zwangerschapscholestase?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/zwangerschapscholestaseq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277" [/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Diabetes gravidarum met insuline?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278" [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "value" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "code" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@code]</assert>
         <assert test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@code; allowed=('199616008', '267258002', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Afwijkende groei foetus": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/afwijkende_groei_foetus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279" [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Dreigende partus immaturus?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_immaturusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280" [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Dreigende partus prematurus?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/dreigende_partus_prematurusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Abruptio placentae?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289" [/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Abruptio placentae?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/zwangerschap/diagnose/abruptio_placentaeq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/zwangerschap/diagnose/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling: == -->
         <assert test="(count(partusnummer) ge 0) and (count(partusnummer) le 1)">Fout aantal voorkomens van "Partusnummer": <value-of select="count(partusnummer)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/partusnummer]</assert>
         <assert test="(count(diagnose_bevalling) ge 0) and (count(diagnose_bevalling) le 1)">Fout aantal voorkomens van "Diagnose bevalling": <value-of select="count(diagnose_bevalling)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling]</assert>
         <assert test="(count(aantal_geboren_kinderen) ge 0) and (count(aantal_geboren_kinderen) le 1)">Fout aantal voorkomens van "Aantal geboren kinderen": <value-of select="count(aantal_geboren_kinderen)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen]</assert>
         <assert test="(count(risicostatus_voor_baring) ge 0) and (count(risicostatus_voor_baring) le 1)">Fout aantal voorkomens van "Risicostatus vóór baring": <value-of select="count(risicostatus_voor_baring)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring]</assert>
         <assert test="(count(wijze_waarop_de_baring_begon) ge 0) and (count(wijze_waarop_de_baring_begon) le 1)">Fout aantal voorkomens van "Wijze waarop de baring begon": <value-of select="count(wijze_waarop_de_baring_begon)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon]</assert>
         <assert test="count(interventies_begin_baring_groep) ge 0">Fout aantal voorkomens van "Interventies begin baring (groep)": <value-of select="count(interventies_begin_baring_groep)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep]</assert>
         <assert test="(count(tijdstip_begin_actieve_ontsluiting) ge 0) and (count(tijdstip_begin_actieve_ontsluiting) le 1)">Fout aantal voorkomens van "Tijdstip begin actieve ontsluiting": <value-of select="count(tijdstip_begin_actieve_ontsluiting)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting]</assert>
         <assert test="(count(bijstimulatie_toegediendq) ge 0) and (count(bijstimulatie_toegediendq) le 1)">Fout aantal voorkomens van "Bijstimulatie toegediend?": <value-of select="count(bijstimulatie_toegediendq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq]</assert>
         <assert test="(count(medicatie_nageboortetijdperk_groep) ge 0) and (count(medicatie_nageboortetijdperk_groep) le 1)">Fout aantal voorkomens van "Medicatie nageboortetijdperk (groep)": <value-of select="count(medicatie_nageboortetijdperk_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep]</assert>
         <assert test="(count(placenta) ge 0) and (count(placenta) le 1)">Fout aantal voorkomens van "Placenta": <value-of select="count(placenta)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/placenta]</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies]</assert>
         <assert test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)">Fout aantal voorkomens van "Conditie perineum postpartum": <value-of select="count(conditie_perineum_postpartum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling: == -->
      <rule context="/kernset_aanleverbericht/bevalling/*[not(self::partusnummer)][not(self::diagnose_bevalling)][not(self::aantal_geboren_kinderen)][not(self::risicostatus_voor_baring)][not(self::wijze_waarop_de_baring_begon)][not(self::interventies_begin_baring_groep)][not(self::tijdstip_begin_actieve_ontsluiting)][not(self::bijstimulatie_toegediendq)][not(self::medicatie_nageboortetijdperk_groep)][not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/partusnummer: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/partusnummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Partusnummer": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/partusnummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/partusnummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20500')">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20500" [/kernset_aanleverbericht/bevalling/partusnummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 1)">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 1 karakters bevatten [/kernset_aanleverbericht/bevalling/partusnummer/@value; min-length=1]</assert>
         <assert test="empty(@value) or (string-length(@value) le 30)">Foutieve informatie voor "Partusnummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 30 karakters bevatten [/kernset_aanleverbericht/bevalling/partusnummer/@value; max-length=30]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Partusnummer": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/partusnummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diagnose bevalling": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose bevalling": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/aantal_geboren_kinderen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Aantal geboren kinderen": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20505')">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20505" [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 9)">Foutieve informatie voor "Aantal geboren kinderen": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 9 zijn [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen/@value; max-inclusive=9]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Aantal geboren kinderen": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/aantal_geboren_kinderen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/risicostatus_voor_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/risicostatus_voor_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Risicostatus vóór baring": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20530')">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20530" [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Risicostatus vóór baring": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Risicostatus vóór baring": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '3', '4', '5', 'UNK', 'NI'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@code; allowed=('1', '3', '4', '5', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Risicostatus vóór baring": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Risicostatus vóór baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.2.4.3.22.1.2.25', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Risicostatus vóór baring": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Risicostatus vóór baring": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/risicostatus_voor_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550')">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550" [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@code; allowed=('1', '2', '3', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Wijze waarop de baring begon": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/wijze_waarop_de_baring_begon; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Interventies begin baring (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555')">Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555" [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Interventies begin baring (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20590')">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20590" [/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/tijdstip_begin_actieve_ontsluiting; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bijstimulatie toegediend?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bijstimulatie toegediend?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20616')">Foutieve informatie voor "Bijstimulatie toegediend?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20616" [/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bijstimulatie toegediend?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Bijstimulatie toegediend?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/bijstimulatie_toegediendq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20619')">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20619" [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medicatie nageboortetijdperk (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/placenta"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Placenta": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/placenta/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/placenta/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612" [/kernset_aanleverbericht/bevalling/placenta/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Placenta": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/placenta; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640" [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/conditie_perineum_postpartum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673" [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@code]</assert>
         <assert test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@code; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/conditie_perineum_postpartum; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/bevalling/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/diagnose_bevalling: == -->
         <assert test="(count(ppromq) ge 0) and (count(ppromq) le 1)">Fout aantal voorkomens van "PPROM?": <value-of select="count(ppromq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq]</assert>
         <assert test="(count(promq) ge 0) and (count(promq) le 1)">Fout aantal voorkomens van "PROM?": <value-of select="count(promq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq]</assert>
         <assert test="(count(koortsq) ge 0) and (count(koortsq) le 1)">Fout aantal voorkomens van "Koorts?": <value-of select="count(koortsq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq]</assert>
         <assert test="(count(niet_vorderende_ontsluitingq) ge 0) and (count(niet_vorderende_ontsluitingq) le 1)">Fout aantal voorkomens van "Niet vorderende ontsluiting?": <value-of select="count(niet_vorderende_ontsluitingq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq]</assert>
         <assert test="(count(niet_vorderende_uitdrijvingq) ge 0) and (count(niet_vorderende_uitdrijvingq) le 1)">Fout aantal voorkomens van "Niet vorderende uitdrijving?": <value-of select="count(niet_vorderende_uitdrijvingq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq]</assert>
         <assert test="(count(verdenking_foetale_noodq) ge 0) and (count(verdenking_foetale_noodq) le 1)">Fout aantal voorkomens van "Verdenking foetale nood?": <value-of select="count(verdenking_foetale_noodq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq]</assert>
         <assert test="(count(vastzittende_placentaq) ge 0) and (count(vastzittende_placentaq) le 1)">Fout aantal voorkomens van "Vastzittende placenta?": <value-of select="count(vastzittende_placentaq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/diagnose_bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/diagnose_bevalling: == -->
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/*[not(self::ppromq)][not(self::promq)][not(self::koortsq)][not(self::niet_vorderende_ontsluitingq)][not(self::niet_vorderende_uitdrijvingq)][not(self::verdenking_foetale_noodq)][not(self::vastzittende_placentaq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/bevalling/diagnose_bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "PPROM?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PPROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82338')">Foutieve informatie voor "PPROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82338" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "PPROM?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "PPROM?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/ppromq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/promq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "PROM?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82290')">Foutieve informatie voor "PROM?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82290" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "PROM?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "PROM?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/promq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Koorts?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Koorts?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82292')">Foutieve informatie voor "Koorts?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82292" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Koorts?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Koorts?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/koortsq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Niet vorderende ontsluiting?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Niet vorderende ontsluiting?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82293')">Foutieve informatie voor "Niet vorderende ontsluiting?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82293" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Niet vorderende ontsluiting?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Niet vorderende ontsluiting?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_ontsluitingq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Niet vorderende uitdrijving?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Niet vorderende uitdrijving?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82294')">Foutieve informatie voor "Niet vorderende uitdrijving?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82294" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Niet vorderende uitdrijving?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Niet vorderende uitdrijving?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/niet_vorderende_uitdrijvingq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Verdenking foetale nood?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Verdenking foetale nood?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82296')">Foutieve informatie voor "Verdenking foetale nood?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82296" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Verdenking foetale nood?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Verdenking foetale nood?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/verdenking_foetale_noodq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vastzittende placenta?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vastzittende placenta?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82295')">Foutieve informatie voor "Vastzittende placenta?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82295" [/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Vastzittende placenta?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Vastzittende placenta?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/diagnose_bevalling/vastzittende_placentaq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/bevalling/diagnose_bevalling/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep: == -->
         <assert test="(count(interventie_begin_baring) ge 0) and (count(interventie_begin_baring) le 1)">Fout aantal voorkomens van "Interventie begin baring": <value-of select="count(interventie_begin_baring)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring]</assert>
         <assert test="(count(indicatie_interventie_begin_baring) ge 0) and (count(indicatie_interventie_begin_baring) le 1)">Fout aantal voorkomens van "Indicatie interventie begin baring": <value-of select="count(indicatie_interventie_begin_baring)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep: == -->
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/*[not(self::interventie_begin_baring)][not(self::indicatie_interventie_begin_baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Interventie begin baring": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560')">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560" [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Interventie begin baring": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Interventie begin baring": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@code]</assert>
         <assert test="empty(@code) or (@code = ('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@code; allowed=('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Interventie begin baring": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Interventie begin baring": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Interventie begin baring": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/interventie_begin_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570')">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570" [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@value; allowed=('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@code; allowed=('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Indicatie interventie begin baring": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/bevalling/interventies_begin_baring_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep: == -->
         <assert test="(count(medicatie_nageboortetijdperkq) ge 0) and (count(medicatie_nageboortetijdperkq) le 1)">Fout aantal voorkomens van "Medicatie nageboortetijdperk?": <value-of select="count(medicatie_nageboortetijdperkq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq]</assert>
         <assert test="count(soort_medicatie_nageboortetijdperk) ge 0">Fout aantal voorkomens van "Soort medicatie nageboortetijdperk": <value-of select="count(soort_medicatie_nageboortetijdperk)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep: == -->
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/*[not(self::medicatie_nageboortetijdperkq)][not(self::soort_medicatie_nageboortetijdperk)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Medicatie nageboortetijdperk?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medicatie nageboortetijdperk?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20620')">Foutieve informatie voor "Medicatie nageboortetijdperk?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20620" [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Medicatie nageboortetijdperk?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Medicatie nageboortetijdperk?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/medicatie_nageboortetijdperkq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20626')">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20626" [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@code]</assert>
         <assert test="empty(@code) or (@code = ('H01BB02', 'G02AD', 'G02AB', 'OTH', 'UNK'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@code; allowed=('H01BB02', 'G02AD', 'G02AB', 'OTH', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.73', '2.16.840.1.113883.6.73', '2.16.840.1.113883.6.73', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@codeSystem; allowed=('2.16.840.1.113883.6.73', '2.16.840.1.113883.6.73', '2.16.840.1.113883.6.73', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Soort medicatie nageboortetijdperk": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/soort_medicatie_nageboortetijdperk; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/bevalling/medicatie_nageboortetijdperk_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/placenta"><!-- == Check occurrences of children of /kernset_aanleverbericht/bevalling/placenta: == -->
         <assert test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)">Fout aantal voorkomens van "Geboorte placenta": <value-of select="count(geboorte_placenta)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/bevalling/placenta/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/bevalling/placenta: == -->
      <rule context="/kernset_aanleverbericht/bevalling/placenta/*[not(self::geboorte_placenta)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/bevalling/placenta/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/bevalling/placenta/geboorte_placenta: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboorte placenta": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630" [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboorte placenta": Attribuut "value" ontbreekt [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Geboorte placenta": Attribuut "code" ontbreekt [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@code]</assert>
         <assert test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@code; allowed=('0', '2', '3', '4', 'OTH', 'NI', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Geboorte placenta": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Geboorte placenta": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geboorte placenta": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/bevalling/placenta/geboorte_placenta; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/bevalling/placenta/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind: == -->
         <assert test="(count(baring) ge 0) and (count(baring) le 1)">Fout aantal voorkomens van "Baring": <value-of select="count(baring)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Baring": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002" [/kernset_aanleverbericht/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring: == -->
         <assert test="(count(werkelijke_plaats_baring_type_locatie) ge 0) and (count(werkelijke_plaats_baring_type_locatie) le 1)">Fout aantal voorkomens van "Werkelijke plaats baring (type locatie)": <value-of select="count(werkelijke_plaats_baring_type_locatie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie]</assert>
         <assert test="(count(ziekenhuis_baring) ge 0) and (count(ziekenhuis_baring) le 1)">Fout aantal voorkomens van "Ziekenhuis baring": <value-of select="count(ziekenhuis_baring)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring]</assert>
         <assert test="(count(demografische_gegevens) ge 0) and (count(demografische_gegevens) le 1)">Fout aantal voorkomens van "Demografische gegevens": <value-of select="count(demografische_gegevens)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens]</assert>
         <assert test="(count(kindspecifieke_maternale_gegevens) ge 0) and (count(kindspecifieke_maternale_gegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke maternale gegevens": <value-of select="count(kindspecifieke_maternale_gegevens)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens]</assert>
         <assert test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke uitkomstgegevens": <value-of select="count(kindspecifieke_uitkomstgegevens)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/*[not(self::werkelijke_plaats_baring_type_locatie)][not(self::ziekenhuis_baring)][not(self::demografische_gegevens)][not(self::kindspecifieke_maternale_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003')">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003" [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@code]</assert>
         <assert test="empty(@code) or (@code = ('169813005', '23', '22232009', '40', 'UNK', 'NI'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@code; allowed=('169813005', '23', '22232009', '40', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Ziekenhuis baring": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ziekenhuis baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114')">Foutieve informatie voor "Ziekenhuis baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114" [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Ziekenhuis baring": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Demografische gegevens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke maternale gegevens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke maternale gegevens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
         <assert test="(count(ziekenhuisnummer_lvrid) ge 0) and (count(ziekenhuisnummer_lvrid) le 1)">Fout aantal voorkomens van "Ziekenhuisnummer (LVR-id)": <value-of select="count(ziekenhuisnummer_lvrid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/*[not(self::ziekenhuisnummer_lvrid)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005')">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005" [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 4)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 4 karakters bevatten [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value; max-length=4]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/ziekenhuis_baring/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens: == -->
         <assert test="(count(identificaties_kind) ge 0) and (count(identificaties_kind) le 1)">Fout aantal voorkomens van "Identificaties kind": <value-of select="count(identificaties_kind)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind]</assert>
         <assert test="(count(geslacht_medische_observatie) ge 0) and (count(geslacht_medische_observatie) le 1)">Fout aantal voorkomens van "Geslacht (medische observatie)": <value-of select="count(geslacht_medische_observatie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie]</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum]</assert>
         <assert test="(count(rangnummer_kind) ge 0) and (count(rangnummer_kind) le 1)">Fout aantal voorkomens van "Rangnummer kind": <value-of select="count(rangnummer_kind)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind]</assert>
         <assert test="(count(perinatale_sterfte_groep) ge 0) and (count(perinatale_sterfte_groep) le 1)">Fout aantal voorkomens van "Perinatale sterfte (groep)": <value-of select="count(perinatale_sterfte_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/*[not(self::identificaties_kind)][not(self::geslacht_medische_observatie)][not(self::geboortedatum)][not(self::rangnummer_kind)][not(self::perinatale_sterfte_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Identificaties kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Identificaties kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40007')">Foutieve informatie voor "Identificaties kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40007" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Identificaties kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041')">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@code; allowed=('1', '2', '3', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geslacht (medische observatie)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Rangnummer kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40025')">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40025" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 9)">Foutieve informatie voor "Rangnummer kind": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 9 zijn [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind/@value; max-inclusive=9]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Rangnummer kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/rangnummer_kind; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Perinatale sterfte (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279')">Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Perinatale sterfte (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind: == -->
         <assert test="(count(bsn_kind) ge 0) and (count(bsn_kind) le 1)">Fout aantal voorkomens van "BSN kind": <value-of select="count(bsn_kind)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/*[not(self::bsn_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "BSN kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "BSN kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40010')">Foutieve informatie voor "BSN kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40010" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "BSN kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/bsn_kind; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/identificaties_kind/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
         <assert test="(count(perinatale_sterfteq) ge 0) and (count(perinatale_sterfteq) le 1)">Fout aantal voorkomens van "Perinatale sterfte?": <value-of select="count(perinatale_sterfteq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq]</assert>
         <assert test="(count(fase_perinatale_sterfte) ge 0) and (count(fase_perinatale_sterfte) le 1)">Fout aantal voorkomens van "Fase perinatale sterfte": <value-of select="count(fase_perinatale_sterfte)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte]</assert>
         <assert test="(count(datumtijd_vaststelling_perinatale_sterfte) ge 0) and (count(datumtijd_vaststelling_perinatale_sterfte) le 1)">Fout aantal voorkomens van "Datum/tijd vaststelling perinatale sterfte": <value-of select="count(datumtijd_vaststelling_perinatale_sterfte)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/*[not(self::perinatale_sterfteq)][not(self::fase_perinatale_sterfte)][not(self::datumtijd_vaststelling_perinatale_sterfte)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Perinatale sterfte?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280')">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Perinatale sterfte?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290')">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@code]</assert>
         <assert test="empty(@code) or (@code = ('237361005', '237362003', '276506001', 'NI'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@code; allowed=('237361005', '237362003', '276506001', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Fase perinatale sterfte": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40300')">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40300" [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum/tijd vaststelling perinatale sterfte": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/datumtijd_vaststelling_perinatale_sterfte; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
         <assert test="(count(tijdstip_breken_vliezen) ge 0) and (count(tijdstip_breken_vliezen) le 1)">Fout aantal voorkomens van "Tijdstip breken vliezen": <value-of select="count(tijdstip_breken_vliezen)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen]</assert>
         <assert test="(count(kleur_en_consistentie_vruchtwater) ge 0) and (count(kleur_en_consistentie_vruchtwater) le 1)">Fout aantal voorkomens van "Kleur en consistentie vruchtwater": <value-of select="count(kleur_en_consistentie_vruchtwater)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater]</assert>
         <assert test="(count(tijdstip_actief_meepersen) ge 0) and (count(tijdstip_actief_meepersen) le 1)">Fout aantal voorkomens van "Tijdstip actief meepersen": <value-of select="count(tijdstip_actief_meepersen)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen]</assert>
         <assert test="(count(episiotomieq) ge 0) and (count(episiotomieq) le 1)">Fout aantal voorkomens van "Episiotomie?": <value-of select="count(episiotomieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq]</assert>
         <assert test="(count(locatie_episiotomie) ge 0) and (count(locatie_episiotomie) le 1)">Fout aantal voorkomens van "Locatie episiotomie": <value-of select="count(locatie_episiotomie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie]</assert>
         <assert test="(count(ruggeprik_gewenst_niet_gekregenq) ge 0) and (count(ruggeprik_gewenst_niet_gekregenq) le 1)">Fout aantal voorkomens van "Ruggeprik gewenst, niet gekregen?": <value-of select="count(ruggeprik_gewenst_niet_gekregenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq]</assert>
         <assert test="(count(pijnbestrijdingq) ge 0) and (count(pijnbestrijdingq) le 1)">Fout aantal voorkomens van "Pijnbestrijding?": <value-of select="count(pijnbestrijdingq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq]</assert>
         <assert test="count(pijnbestrijding) ge 0">Fout aantal voorkomens van "Pijnbestrijding": <value-of select="count(pijnbestrijding)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding]</assert>
         <assert test="(count(sedatieq) ge 0) and (count(sedatieq) le 1)">Fout aantal voorkomens van "Sedatie?": <value-of select="count(sedatieq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/*[not(self::tijdstip_breken_vliezen)][not(self::kleur_en_consistentie_vruchtwater)][not(self::tijdstip_actief_meepersen)][not(self::episiotomieq)][not(self::locatie_episiotomie)][not(self::ruggeprik_gewenst_niet_gekregenq)][not(self::pijnbestrijdingq)][not(self::pijnbestrijding)][not(self::sedatieq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Tijdstip breken vliezen": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip breken vliezen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80619')">Foutieve informatie voor "Tijdstip breken vliezen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80619" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Tijdstip breken vliezen": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Tijdstip breken vliezen": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_breken_vliezen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kleur en consistentie vruchtwater": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20610')">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20610" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Kleur en consistentie vruchtwater": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Kleur en consistentie vruchtwater": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@code; allowed=('1', '2', '3', 'OTH', 'NI', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Kleur en consistentie vruchtwater": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Kleur en consistentie vruchtwater": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.2.4.4.13.18', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Kleur en consistentie vruchtwater": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Kleur en consistentie vruchtwater": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/kleur_en_consistentie_vruchtwater; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Tijdstip actief meepersen": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30030')">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30030" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Tijdstip actief meepersen": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Episiotomie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Episiotomie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30050')">Foutieve informatie voor "Episiotomie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30050" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Episiotomie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Episiotomie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/episiotomieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Locatie episiotomie": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30055')">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.30055" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Locatie episiotomie": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Locatie episiotomie": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', 'UNK', 'NI'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@code; allowed=('1', '2', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Locatie episiotomie": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.60', '2.16.840.1.113883.2.4.3.22.1.3.60', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Locatie episiotomie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.3.60', '2.16.840.1.113883.2.4.3.22.1.3.60', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Locatie episiotomie": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Locatie episiotomie": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/locatie_episiotomie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82089')">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82089" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Ruggeprik gewenst, niet gekregen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/ruggeprik_gewenst_niet_gekregenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pijnbestrijding?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pijnbestrijding?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82090')">Foutieve informatie voor "Pijnbestrijding?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82090" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Pijnbestrijding?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Pijnbestrijding?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijdingq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pijnbestrijding": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pijnbestrijding": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82091')">Foutieve informatie voor "Pijnbestrijding": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82091" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Pijnbestrijding": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Sedatie?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Sedatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80827')">Foutieve informatie voor "Sedatie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80827" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Sedatie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Sedatie?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/sedatieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding: == -->
         <assert test="count(methode) eq 1">Fout aantal voorkomens van "Methode": <value-of select="count(methode)"/> (verwacht: 1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode]</assert>
         <assert test="(count(periode) ge 0) and (count(periode) le 1)">Fout aantal voorkomens van "Periode": <value-of select="count(periode)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/*[not(self::methode)][not(self::periode)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Methode": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82093')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82093" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Methode": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Periode": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Periode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82097')">Foutieve informatie voor "Periode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82097" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Periode": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Periode": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@code]</assert>
         <assert test="empty(@code) or (@code = ('OntLt3', 'OntMt3', 'Uitdr', 'Sectio', 'Postpartum'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@code; allowed=('OntLt3', 'OntMt3', 'Uitdr', 'Sectio', 'Postpartum')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Periode": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60'))">Foutieve informatie voor "Periode": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60', '2.16.840.1.113883.2.4.4.13.60')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Periode": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Periode": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/periode; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode: == -->
         <assert test="count(methode) eq 1">Fout aantal voorkomens van "Methode": <value-of select="count(methode)"/> (verwacht: 1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode]</assert>
         <assert test="count(overig_middel) ge 0">Fout aantal voorkomens van "Overig middel": <value-of select="count(overig_middel)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/*[not(self::methode)][not(self::overig_middel)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Methode": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82092')">Foutieve informatie voor "Methode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82092" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Methode": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Methode": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@code]</assert>
         <assert test="empty(@code) or (@code = ('231249005', '18946005', '50697003', 'OTH'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@code; allowed=('231249005', '18946005', '50697003', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Methode": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Methode": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Methode": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Methode": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/methode; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overig middel": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overig middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82094')">Foutieve informatie voor "Overig middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82094" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Overig middel": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel: == -->
         <assert test="(count(middel) ge 0) and (count(middel) le 1)">Fout aantal voorkomens van "Middel": <value-of select="count(middel)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel]</assert>
         <assert test="(count(toediening) ge 0) and (count(toediening) le 1)">Fout aantal voorkomens van "Toediening": <value-of select="count(toediening)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/*[not(self::middel)][not(self::toediening)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Middel": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82095')">Foutieve informatie voor "Middel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82095" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Middel": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Middel": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@code]</assert>
         <assert test="empty(@code) or (@code = ('52685006:363701004=404642006', '281706009:363701004=11713004', '229559001', '426060003', 'OTH'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@code; allowed=('52685006:363701004=404642006', '281706009:363701004=11713004', '229559001', '426060003', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Middel": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Middel": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Middel": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Middel": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/middel; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Toediening": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Toediening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82096')">Foutieve informatie voor "Toediening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82096" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Toediening": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Toediening": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@code]</assert>
         <assert test="empty(@code) or (@code = ('434589000', '78746004', '386356001', '431215000', '431784008', '241716000', '241717009', 'OTH'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@code; allowed=('434589000', '78746004', '386356001', '431215000', '431784008', '241716000', '241717009', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Toediening": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Toediening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Toediening": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Toediening": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/toediening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/pijnbestrijding/methode/overig_middel/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus]</assert>
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min]</assert>
         <assert test="(count(ligging_bij_geboorte) ge 0) and (count(ligging_bij_geboorte) le 1)">Fout aantal voorkomens van "Ligging bij geboorte": <value-of select="count(ligging_bij_geboorte)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte]</assert>
         <assert test="(count(aanpakker_kind_groep) ge 0) and (count(aanpakker_kind_groep) le 1)">Fout aantal voorkomens van "Aanpakker kind (groep)": <value-of select="count(aanpakker_kind_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep]</assert>
         <assert test="(count(supervisor_groep) ge 0) and (count(supervisor_groep) le 1)">Fout aantal voorkomens van "Supervisor (groep)": <value-of select="count(supervisor_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep]</assert>
         <assert test="count(vaginale_kunstverlossing_groep) ge 0">Fout aantal voorkomens van "Vaginale kunstverlossing (groep)": <value-of select="count(vaginale_kunstverlossing_groep)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep]</assert>
         <assert test="(count(sectio_caesarea_group) ge 0) and (count(sectio_caesarea_group) le 1)">Fout aantal voorkomens van "Sectio caesarea (group)": <value-of select="count(sectio_caesarea_group)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group]</assert>
         <assert test="count(overige_interventies) ge 0">Fout aantal voorkomens van "Overige interventies": <value-of select="count(overige_interventies)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies]</assert>
         <assert test="count(lichamelijk_onderzoek_kind) ge 0">Fout aantal voorkomens van "Lichamelijk onderzoek kind": <value-of select="count(lichamelijk_onderzoek_kind)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind]</assert>
         <assert test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen?": <value-of select="count(congenitale_afwijkingenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq]</assert>
         <assert test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen (groep)": <value-of select="count(congenitale_afwijkingen_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep]</assert>
         <assert test="(count(problematiek_kindq) ge 0) and (count(problematiek_kindq) le 1)">Fout aantal voorkomens van "Problematiek kind?": <value-of select="count(problematiek_kindq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq]</assert>
         <assert test="count(problematiek_kind) ge 0">Fout aantal voorkomens van "Problematiek kind": <value-of select="count(problematiek_kind)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind]</assert>
         <assert test="(count(kinderarts_betrokkenq) ge 0) and (count(kinderarts_betrokkenq) le 1)">Fout aantal voorkomens van "Kinderarts betrokken?": <value-of select="count(kinderarts_betrokkenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq]</assert>
         <assert test="count(betrokkenheid_kinderarts) ge 0">Fout aantal voorkomens van "Betrokkenheid kinderarts": <value-of select="count(betrokkenheid_kinderarts)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::apgarscore_na_5_min)][not(self::ligging_bij_geboorte)][not(self::aanpakker_kind_groep)][not(self::supervisor_groep)][not(self::vaginale_kunstverlossing_groep)][not(self::sectio_caesarea_group)][not(self::overige_interventies)][not(self::lichamelijk_onderzoek_kind)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)][not(self::problematiek_kindq)][not(self::problematiek_kind)][not(self::kinderarts_betrokkenq)][not(self::betrokkenheid_kinderarts)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type partus": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type partus": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type partus": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code]</assert>
         <assert test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type partus": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type partus": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; max-inclusive=10]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Ligging bij geboorte": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40140')">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40140" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Ligging bij geboorte": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Ligging bij geboorte": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@code]</assert>
         <assert test="empty(@code) or (@code = ('37235006', '70028003', '249079005', '21882006', '8014007', '49168004', '38049006', '18559007', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@code; allowed=('37235006', '70028003', '249079005', '21882006', '8014007', '49168004', '38049006', '18559007', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Ligging bij geboorte": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Ligging bij geboorte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Ligging bij geboorte": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Ligging bij geboorte": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/ligging_bij_geboorte; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Aanpakker kind (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Aanpakker kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40149')">Foutieve informatie voor "Aanpakker kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40149" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Aanpakker kind (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Supervisor (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Supervisor (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40169')">Foutieve informatie voor "Supervisor (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40169" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Supervisor (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Sectio caesarea (group)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Sectio caesarea (group)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219')">Foutieve informatie voor "Sectio caesarea (group)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Sectio caesarea (group)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overige interventies": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240')">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overige interventies": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Overige interventies": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@code]</assert>
         <assert test="empty(@code) or (@code = ('32189006', '237008007', '40792007', 'OTH'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@code; allowed=('32189006', '237008007', '40792007', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Overige interventies": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Overige interventies": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Overige interventies": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Lichamelijk onderzoek kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Congenitale afwijkingen (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Problematiek kind?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Problematiek kind?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82334')">Foutieve informatie voor "Problematiek kind?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82334" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Problematiek kind?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Problematiek kind?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kindq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Problematiek kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80789')">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80789" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Problematiek kind": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Problematiek kind": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@code]</assert>
         <assert test="empty(@code) or (@code = ('56110009', '126941005', '206399009', '206192007', '219', '371129000', '290', '82353009', '35742006', '73893000', '59527008', '1857005', '206376005', '39367000', '1450', '406', '414030009', '414028007', '13404009', '3580', '267574006', '276647007', '206576006', '87476004', '205294008', '415297005', '95827002', '363696006', '206596003', '276519002', '276508000', '5800', '363225006', '46775006', '276533002', '67569000', '6990', '7100', '281610001', '7700', '363221002', '52767006', '276557002', '190268003', '8490', '363224005'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@code; allowed=('56110009', '126941005', '206399009', '206192007', '219', '371129000', '290', '82353009', '35742006', '73893000', '59527008', '1857005', '206376005', '39367000', '1450', '406', '414030009', '414028007', '13404009', '3580', '267574006', '276647007', '206576006', '87476004', '205294008', '415297005', '95827002', '363696006', '206596003', '276519002', '276508000', '5800', '363225006', '46775006', '276533002', '67569000', '6990', '7100', '281610001', '7700', '363221002', '52767006', '276557002', '190268003', '8490', '363224005')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Problematiek kind": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Problematiek kind": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.64', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Problematiek kind": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Problematiek kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/problematiek_kind; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kinderarts betrokken?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kinderarts betrokken?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82119')">Foutieve informatie voor "Kinderarts betrokken?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82119" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Kinderarts betrokken?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Kinderarts betrokken?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/kinderarts_betrokkenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Betrokkenheid kinderarts": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Betrokkenheid kinderarts": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82120')">Foutieve informatie voor "Betrokkenheid kinderarts": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82120" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Betrokkenheid kinderarts": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep: == -->
         <assert test="(count(rol_aanpakker_kind) ge 0) and (count(rol_aanpakker_kind) le 1)">Fout aantal voorkomens van "Rol aanpakker kind": <value-of select="count(rol_aanpakker_kind)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/*[not(self::rol_aanpakker_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Rol aanpakker kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40150')">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40150" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Rol aanpakker kind": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Rol aanpakker kind": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@code]</assert>
         <assert test="empty(@code) or (@code = ('11', '25', '12', '01.046', '22', '24', '13', '01.015', '15', '23', '30.000', '32', '33', 'UNK', 'NI'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@code; allowed=('11', '25', '12', '01.046', '22', '24', '13', '01.015', '15', '23', '30.000', '32', '33', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Rol aanpakker kind": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rol aanpakker kind": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Rol aanpakker kind": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Rol aanpakker kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/rol_aanpakker_kind; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/aanpakker_kind_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep: == -->
         <assert test="(count(rol_supervisor) ge 0) and (count(rol_supervisor) le 1)">Fout aantal voorkomens van "Rol supervisor": <value-of select="count(rol_supervisor)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/*[not(self::rol_supervisor)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Rol supervisor": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40170')">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40170" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Rol supervisor": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Rol supervisor": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@code]</assert>
         <assert test="empty(@code) or (@code = ('11', '25', '01.046', '22', '24', '01.015', 'NI'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@code; allowed=('11', '25', '01.046', '22', '24', '01.015', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Rol supervisor": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rol supervisor": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.3.22.1.2.59', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Rol supervisor": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Rol supervisor": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/rol_supervisor; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/supervisor_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
         <assert test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing": <value-of select="count(vaginale_kunstverlossing)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing]</assert>
         <assert test="(count(succes_vaginale_kunstverlossingq) ge 0) and (count(succes_vaginale_kunstverlossingq) le 1)">Fout aantal voorkomens van "Succes vaginale kunstverlossing?": <value-of select="count(succes_vaginale_kunstverlossingq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::succes_vaginale_kunstverlossingq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code]</assert>
         <assert test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Succes vaginale kunstverlossing?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Succes vaginale kunstverlossing?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40200')">Foutieve informatie voor "Succes vaginale kunstverlossing?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40200" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Succes vaginale kunstverlossing?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Succes vaginale kunstverlossing?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/succes_vaginale_kunstverlossingq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
         <assert test="(count(beslismoment_sectio_caesarea) ge 0) and (count(beslismoment_sectio_caesarea) le 1)">Fout aantal voorkomens van "Beslismoment sectio caesarea": <value-of select="count(beslismoment_sectio_caesarea)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea]</assert>
         <assert test="count(indicatie_sectio_caesarea) ge 1">Fout aantal voorkomens van "Indicatie sectio caesarea": <value-of select="count(indicatie_sectio_caesarea)"/> (verwacht: 1 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/*[not(self::beslismoment_sectio_caesarea)][not(self::indicatie_sectio_caesarea)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225')">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@code]</assert>
         <assert test="empty(@code) or (@code = ('2', '3', 'NI'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@code; allowed=('2', '3', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Beslismoment sectio caesarea": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230')">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@code]</assert>
         <assert test="empty(@code) or (@code = ('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@code; allowed=('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Indicatie sectio caesarea": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
         <assert test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)">Fout aantal voorkomens van "Geboortegewicht": <value-of select="count(geboortegewicht)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortegewicht": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Geboortegewicht": Attribuut "unit" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'gram')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
         <assert test="count(specificatie_congenitale_afwijking_groep) ge 0">Fout aantal voorkomens van "Specificatie congenitale afwijking (groep)": <value-of select="count(specificatie_congenitale_afwijking_groep)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep]</assert>
         <assert test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)">Fout aantal voorkomens van "Chromosomale afwijkingen?": <value-of select="count(chromosomale_afwijkingenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq]</assert>
         <assert test="count(specificatie_chromosomale_afwijking_groep) ge 0">Fout aantal voorkomens van "Specificatie chromosomale afwijking (groep)": <value-of select="count(specificatie_chromosomale_afwijking_groep)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/*[not(self::specificatie_congenitale_afwijking_groep)][not(self::chromosomale_afwijkingenq)][not(self::specificatie_chromosomale_afwijking_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082')">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Chromosomale afwijkingen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111')">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
         <assert test="(count(specificatie_congenitale_afwijking) ge 0) and (count(specificatie_congenitale_afwijking) le 1)">Fout aantal voorkomens van "Specificatie congenitale afwijking": <value-of select="count(specificatie_congenitale_afwijking)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/*[not(self::specificatie_congenitale_afwijking)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090')">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@code]</assert>
         <assert test="empty(@code) or (@code = ('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@code; allowed=('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Specificatie congenitale afwijking": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
         <assert test="count(specificatie_chromosomale_afwijking) eq 1">Fout aantal voorkomens van "Specificatie chromosomale afwijking": <value-of select="count(specificatie_chromosomale_afwijking)"/> (verwacht: 1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/*[not(self::specificatie_chromosomale_afwijking)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120')">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@code]</assert>
         <assert test="empty(@code) or (@code = ('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@code; allowed=('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Specificatie chromosomale afwijking": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts"><!-- == Check occurrences of children of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts: == -->
         <assert test="(count(datum_betrokkenheid) ge 0) and (count(datum_betrokkenheid) le 1)">Fout aantal voorkomens van "Datum betrokkenheid": <value-of select="count(datum_betrokkenheid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid]</assert>
         <assert test="(count(reden_betrokkenheid) ge 0) and (count(reden_betrokkenheid) le 1)">Fout aantal voorkomens van "Reden betrokkenheid": <value-of select="count(reden_betrokkenheid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid]</assert>
         <assert test="(count(type_betrokkenheid) ge 0) and (count(type_betrokkenheid) le 1)">Fout aantal voorkomens van "Type betrokkenheid": <value-of select="count(type_betrokkenheid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid]</assert>
         <assert test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts: == -->
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/*[not(self::datum_betrokkenheid)][not(self::reden_betrokkenheid)][not(self::type_betrokkenheid)][not(self::zorginstelling_lvrid)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum betrokkenheid": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82122')">Foutieve informatie voor "Datum betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82122" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum betrokkenheid": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum betrokkenheid": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/datum_betrokkenheid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Reden betrokkenheid": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82123')">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82123" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Reden betrokkenheid": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Reden betrokkenheid": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@code]</assert>
         <assert test="empty(@code) or (@code = ('276614003', '276609002', '289261003', '8571000146103', '289365005', '12729009', '364737004', '168092006', '387712008', '161838002', '473130003', '394886001', '281667005', '95607001', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@code; allowed=('276614003', '276609002', '289261003', '8571000146103', '289365005', '12729009', '364737004', '168092006', '387712008', '161838002', '473130003', '394886001', '281667005', '95607001', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Reden betrokkenheid": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Reden betrokkenheid": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Reden betrokkenheid": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Reden betrokkenheid": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/reden_betrokkenheid; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type betrokkenheid": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82121')">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82121" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type betrokkenheid": Attribuut "value" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type betrokkenheid": Attribuut "code" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', 'UNK', 'NI'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@code; allowed=('1', '2', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type betrokkenheid": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.17', '2.16.840.1.113883.2.4.4.13.17', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type betrokkenheid": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.17', '2.16.840.1.113883.2.4.4.13.17', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type betrokkenheid": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type betrokkenheid": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/type_betrokkenheid; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82335')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82335" [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid/@value; max-length=5]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/zorginstelling_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/betrokkenheid_kinderarts/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek: == -->
         <assert test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)">Fout aantal voorkomens van "Maternale onderzoeksgegevens": <value-of select="count(maternale_onderzoeksgegevens)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/medisch_onderzoek/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Maternale onderzoeksgegevens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142" [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/medisch_onderzoek/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
         <assert test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)">Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959" [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
         <assert test="(count(psie) ge 0) and (count(psie) le 1)">Fout aantal voorkomens van "PSIE": <value-of select="count(psie)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::psie)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "PSIE": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PSIE": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949')">Foutieve informatie voor "PSIE": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949" [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "PSIE": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"><!-- == Check occurrences of children of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
         <assert test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)">Fout aantal voorkomens van "Irregulaire antistoffen?": <value-of select="count(irregulaire_antistoffenq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq]</assert>
         <assert test="count(welke_irregulaire_antistoffen_vrouw_aanwezig) ge 0">Fout aantal voorkomens van "Welke irregulaire antistoffen vrouw aanwezig.": <value-of select="count(welke_irregulaire_antistoffen_vrouw_aanwezig)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/*[not(self::irregulaire_antistoffenq)][not(self::welke_irregulaire_antistoffen_vrouw_aanwezig)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812" [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Irregulaire antistoffen?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10813')">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10813" [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Attribuut "value" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Attribuut "code" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@code]</assert>
         <assert test="empty(@code) or (@code = ('112162009', '8362009', '62523009', '405844003', '8376005', '25453008', 'OTH', 'UNK'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@code; allowed=('112162009', '8362009', '62523009', '405844003', '8376005', '25453008', 'OTH', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Welke irregulaire antistoffen vrouw aanwezig.": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/welke_irregulaire_antistoffen_vrouw_aanwezig; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase: == -->
         <assert test="count(diagnose_postpartum) ge 0">Fout aantal voorkomens van "Diagnose postpartum": <value-of select="count(diagnose_postpartum)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum]</assert>
         <assert test="count(kindspecifieke_gegevens) ge 0">Fout aantal voorkomens van "Kindspecifieke gegevens": <value-of select="count(kindspecifieke_gegevens)"/> (verwacht: 0 of meer) [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/*[not(self::diagnose_postpartum)][not(self::kindspecifieke_gegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/postnatale_fase/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diagnose postpartum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82297')">Foutieve informatie voor "Diagnose postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82297" [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose postpartum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke gegevens": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.161')">Foutieve informatie voor "Kindspecifieke gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.161" [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke gegevens": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/postnatale_fase/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum: == -->
         <assert test="(count(datum) ge 0) and (count(datum) le 1)">Fout aantal voorkomens van "Datum": <value-of select="count(datum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum]</assert>
         <assert test="(count(pathologie_vrouwq) ge 0) and (count(pathologie_vrouwq) le 1)">Fout aantal voorkomens van "Pathologie vrouw?": <value-of select="count(pathologie_vrouwq)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq]</assert>
         <assert test="(count(pathologie_vrouw) ge 0) and (count(pathologie_vrouw) le 1)">Fout aantal voorkomens van "Pathologie vrouw": <value-of select="count(pathologie_vrouw)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/*[not(self::datum)][not(self::pathologie_vrouwq)][not(self::pathologie_vrouw)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82298')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82298" [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pathologie vrouw?": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pathologie vrouw?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82208')">Foutieve informatie voor "Pathologie vrouw?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82208" [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Pathologie vrouw?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq/@value; type=xs:boolean]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Pathologie vrouw?": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouwq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pathologie vrouw": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82209')">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82209" [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pathologie vrouw": Attribuut "value" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '14', '15', '16', '17', '18', '19'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@value; allowed=('2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '14', '15', '16', '17', '18', '19')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Pathologie vrouw": Attribuut "code" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@code]</assert>
         <assert test="empty(@code) or (@code = ('398254007', '67359005', '303063000', '95605009', '56272000', '58703003', '18260003', '301822002', '414086009', '385494008', '116859006', '78623009', '45198002', '68566005', '300927001', '6150', 'OTH'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@code; allowed=('398254007', '67359005', '303063000', '95605009', '56272000', '58703003', '18260003', '301822002', '414086009', '385494008', '116859006', '78623009', '45198002', '68566005', '300927001', '6150', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Pathologie vrouw": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Pathologie vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.1', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Pathologie vrouw": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Pathologie vrouw": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/pathologie_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/postnatale_fase/diagnose_postpartum/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens: == -->
         <assert test="(count(voeding_kind_groep) ge 0) and (count(voeding_kind_groep) le 1)">Fout aantal voorkomens van "Voeding kind (groep)": <value-of select="count(voeding_kind_groep)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/*[not(self::voeding_kind_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voeding kind (groep)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voeding kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70009')">Foutieve informatie voor "Voeding kind (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70009" [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Voeding kind (groep)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/adaextension == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep"><!-- == Check occurrences of children of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep: == -->
         <assert test="(count(voeding_kind_datum) ge 0) and (count(voeding_kind_datum) le 1)">Fout aantal voorkomens van "Voeding kind (datum)": <value-of select="count(voeding_kind_datum)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum]</assert>
         <assert test="count(substantie_voeding_kind) ge 1">Fout aantal voorkomens van "Substantie voeding kind": <value-of select="count(substantie_voeding_kind)"/> (verwacht: 1 of meer) [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep: == -->
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/*[not(self::voeding_kind_datum)][not(self::substantie_voeding_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voeding kind (datum)": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voeding kind (datum)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70011')">Foutieve informatie voor "Voeding kind (datum)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70011" [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Voeding kind (datum)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Voeding kind (datum)": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/voeding_kind_datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind: == -->
   <pattern>
      <rule context="/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Substantie voeding kind": Attribuut "conceptId" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70030')">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.70030" [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Substantie voeding kind": Attribuut "value" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Substantie voeding kind": Attribuut "code" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', 'UNK', 'NI'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@code; allowed=('1', '2', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Substantie voeding kind": Attribuut "codeSystem" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.4.8', '2.16.840.1.113883.2.4.3.22.1.4.8', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Substantie voeding kind": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.4.8', '2.16.840.1.113883.2.4.3.22.1.4.8', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Substantie voeding kind": Attribuut "displayName" ontbreekt [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Substantie voeding kind": Ongeldige attributen aangetroffen [/kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/substantie_voeding_kind; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /kernset_aanleverbericht/postnatale_fase/kindspecifieke_gegevens/voeding_kind_groep/adaextension == -->
</schema>
