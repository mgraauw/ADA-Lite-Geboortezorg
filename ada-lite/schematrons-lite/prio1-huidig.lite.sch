<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:local="#local"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
<!-- == Generated Schematron file for validating ADA Lite prio1_huidig documents == --><!-- == Source: design/specs-full/prio1-huidig.xml == --><!-- == Generator(s): design/xsl/ada-rtd2ada-schema-simple.xsl; design/xsl/ada-schema-simple2ada-schematron.xsl == -->   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(prio1_huidig) eq 1">Fout aantal voorkomens van "Prio1 huidig": <value-of select="count(prio1_huidig)"/> (verwacht: 1) [/prio1_huidig]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig: == -->
   <pattern>
      <rule context="/prio1_huidig"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Prio1 huidig": Attribuut "transactionRef" ontbreekt [/prio1_huidig/@transactionRef]</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_huidig/@transactionRef; type=t-id]</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2453')">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2453" [/prio1_huidig/@transactionRef]</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_huidig/@transactionEffectiveDate; type=xs:dateTime]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2018-12-17T15:21:25')">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2018-12-17T15:21:25" [/prio1_huidig/@transactionEffectiveDate]</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_huidig/@versionDate; type=xs:dateTime]</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Prio1 huidig": Ongeldige attributen aangetroffen [/prio1_huidig; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig"><!-- == Check occurrences of children of /prio1_huidig: == -->
         <assert test="(count(zorgverlenerzorginstelling) ge 0) and (count(zorgverlenerzorginstelling) le 1)">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling]</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1) [/prio1_huidig/vrouw]</assert>
         <assert test="(count(zwangerschap) ge 0) and (count(zwangerschap) le 1)">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 0..1) [/prio1_huidig/zwangerschap]</assert>
         <assert test="count(medisch_onderzoek) ge 0">Fout aantal voorkomens van "Medisch onderzoek": <value-of select="count(medisch_onderzoek)"/> (verwacht: 0 of meer) [/prio1_huidig/medisch_onderzoek]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig: == -->
      <rule context="/prio1_huidig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::medisch_onderzoek)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/prio1_huidig/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/prio1_huidig/vrouw/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/prio1_huidig/zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14" [/prio1_huidig/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /prio1_huidig/zorgverlenerzorginstelling: == -->
         <assert test="(count(zorgverlener) ge 0) and (count(zorgverlener) le 1)">Fout aantal voorkomens van "Zorgverlener": <value-of select="count(zorgverlener)"/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener]</assert>
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1) [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zorgverlenerzorginstelling: == -->
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/zorgverlenerzorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorgverlener: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001" [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/zorgverlenerzorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"><!-- == Check occurrences of children of /prio1_huidig/zorgverlenerzorginstelling/zorgverlener: == -->
         <assert test="(count(naam_zorgverlener) ge 0) and (count(naam_zorgverlener) le 1)">Fout aantal voorkomens van "Naam zorgverlener": <value-of select="count(naam_zorgverlener)"/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zorgverlenerzorginstelling/zorgverlener: == -->
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006" [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorgverlener": Attribuut "value" ontbreekt [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/zorgverlenerzorginstelling/zorgverlener/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /prio1_huidig/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="count(naam_zorginstelling) eq 1">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 1) [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026" [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/zorgverlenerzorginstelling/zorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw"><!-- == Check occurrences of children of /prio1_huidig/vrouw: == -->
         <assert test="(count(burgerservicenummer) ge 0) and (count(burgerservicenummer) le 1)">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/burgerservicenummer]</assert>
         <assert test="(count(naamgegevens) ge 1) and (count(naamgegevens) le 2)">Fout aantal voorkomens van "Naamgegevens": <value-of select="count(naamgegevens)"/> (verwacht: 1..2) [/prio1_huidig/vrouw/naamgegevens]</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/geboortedatum]</assert>
         <assert test="(count(bloedgroep_vrouw) ge 0) and (count(bloedgroep_vrouw) le 1)">Fout aantal voorkomens van "Bloedgroep vrouw": <value-of select="count(bloedgroep_vrouw)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/bloedgroep_vrouw]</assert>
         <assert test="(count(rhesus_d_factor_vrouw) ge 0) and (count(rhesus_d_factor_vrouw) le 1)">Fout aantal voorkomens van "Rhesus D Factor vrouw": <value-of select="count(rhesus_d_factor_vrouw)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/rhesus_d_factor_vrouw]</assert>
         <assert test="(count(rhesus_c_factor) ge 0) and (count(rhesus_c_factor) le 1)">Fout aantal voorkomens van "Rhesus c Factor": <value-of select="count(rhesus_c_factor)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/rhesus_c_factor]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/vrouw: == -->
      <rule context="/prio1_huidig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::geboortedatum)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/vrouw/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/burgerservicenummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/prio1_huidig/vrouw/burgerservicenummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/burgerservicenummer/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_huidig/vrouw/burgerservicenummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_huidig/vrouw/burgerservicenummer/@value; max-length=9]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035" [/prio1_huidig/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/geboortedatum: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040" [/prio1_huidig/vrouw/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/geboortedatum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/vrouw/geboortedatum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/geboortedatum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/bloedgroep_vrouw: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/bloedgroep_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/bloedgroep_vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810')">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810" [/prio1_huidig/vrouw/bloedgroep_vrouw/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@value; allowed=('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@code; allowed=('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('Blood_group_A_(finding)', 'Blood_group_B_(finding)', 'Blood_group_AB_(finding)', 'Blood_group_O_(finding)', 'Onbekend', 'Geen_informatie'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@enum; allowed=('Blood_group_A_(finding)', 'Blood_group_B_(finding)', 'Blood_group_AB_(finding)', 'Blood_group_O_(finding)', 'Onbekend', 'Geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Bloedgroep vrouw": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/bloedgroep_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/rhesus_d_factor_vrouw: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/rhesus_d_factor_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811')">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811" [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('165747007', '165746003', 'UNK', 'NI'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@value; allowed=('165747007', '165746003', 'UNK', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('165747007', '165746003', 'UNK', 'NI'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@code; allowed=('165747007', '165746003', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('Rh_D_Positief', 'Rh_D_Negatief', 'onbekend', 'geen_informatie'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@enum; allowed=('Rh_D_Positief', 'Rh_D_Negatief', 'onbekend', 'geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Rhesus D Factor vrouw": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/rhesus_d_factor_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/rhesus_c_factor: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/rhesus_c_factor"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/rhesus_c_factor/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816')">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816" [/prio1_huidig/vrouw/rhesus_c_factor/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('733120009', '733119003', 'NI'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@value; allowed=('733120009', '733119003', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('733120009', '733119003', 'NI'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@code; allowed=('733120009', '733119003', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('Rhc_positive_(finding)', 'Rhc_negative_(finding)', 'Geen_informatie'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@enum; allowed=('Rhc_positive_(finding)', 'Rhc_negative_(finding)', 'Geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Rhesus c Factor": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/rhesus_c_factor; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/vrouw/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens"><!-- == Check occurrences of children of /prio1_huidig/vrouw/naamgegevens: == -->
         <assert test="(count(voornamen) ge 0) and (count(voornamen) le 1)">Fout aantal voorkomens van "Voornamen": <value-of select="count(voornamen)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/voornamen]</assert>
         <assert test="(count(initialen) ge 0) and (count(initialen) le 1)">Fout aantal voorkomens van "Initialen": <value-of select="count(initialen)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/initialen]</assert>
         <assert test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">Fout aantal voorkomens van "Roepnaam": <value-of select="count(roepnaam)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/roepnaam]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/vrouw/naamgegevens: == -->
      <rule context="/prio1_huidig/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/vrouw/naamgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/voornamen: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/voornamen"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/voornamen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042" [/prio1_huidig/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voornamen": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/voornamen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/voornamen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/initialen: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/initialen"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/initialen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359" [/prio1_huidig/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Initialen": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/initialen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Initialen": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/initialen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/roepnaam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/roepnaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360" [/prio1_huidig/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/roepnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361" [/prio1_huidig/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/vrouw/naamgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam"><!-- == Check occurrences of children of /prio1_huidig/vrouw/naamgegevens/achternaam: == -->
         <assert test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">Fout aantal voorkomens van "Soort naam": <value-of select="count(soort_naam)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam]</assert>
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/vrouw/naamgegevens/achternaam: == -->
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/vrouw/naamgegevens/achternaam/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362" [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</assert>
         <!-- == Attribute "displayName": == -->
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('Geslachtsnaam', 'Geslachtsnaam_partner'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@enum; allowed=('Geslachtsnaam', 'Geslachtsnaam_partner')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363" [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam/achternaam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043" [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/vrouw/naamgegevens/achternaam/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap"><!-- == Check occurrences of children of /prio1_huidig/zwangerschap: == -->
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/graviditeit]</assert>
         <assert test="(count(pariteit) ge 0) and (count(pariteit) le 1)">Fout aantal voorkomens van "Pariteit": <value-of select="count(pariteit)"/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/pariteit]</assert>
         <assert test="count(a_terme_datum_groep) eq 1">Fout aantal voorkomens van "A terme datum (groep)": <value-of select="count(a_terme_datum_groep)"/> (verwacht: 1) [/prio1_huidig/zwangerschap/a_terme_datum_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zwangerschap: == -->
      <rule context="/prio1_huidig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit)][not(self::a_terme_datum_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/graviditeit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/prio1_huidig/zwangerschap/graviditeit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt [/prio1_huidig/zwangerschap/graviditeit/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/zwangerschap/graviditeit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_huidig/zwangerschap/graviditeit/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_huidig/zwangerschap/graviditeit/@value; max-inclusive=75]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap/graviditeit; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap/pariteit: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/pariteit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/pariteit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153')">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153" [/prio1_huidig/zwangerschap/pariteit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pariteit": Attribuut "value" ontbreekt [/prio1_huidig/zwangerschap/pariteit/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/zwangerschap/pariteit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidig/zwangerschap/pariteit/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_huidig/zwangerschap/pariteit/@value; max-inclusive=30]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pariteit": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap/pariteit; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap/a_terme_datum_groep: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/a_terme_datum_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "A terme datum (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/a_terme_datum_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029')">Foutieve informatie voor "A terme datum (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029" [/prio1_huidig/zwangerschap/a_terme_datum_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "A terme datum (groep)": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap/a_terme_datum_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/zwangerschap/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/a_terme_datum_groep"><!-- == Check occurrences of children of /prio1_huidig/zwangerschap/a_terme_datum_groep: == -->
         <assert test="count(a_terme_datum) eq 1">Fout aantal voorkomens van "A terme datum": <value-of select="count(a_terme_datum)"/> (verwacht: 1) [/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/a_terme_datum_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zwangerschap/a_terme_datum_groep: == -->
      <rule context="/prio1_huidig/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/zwangerschap/a_terme_datum_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030')">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030" [/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "A terme datum": Attribuut "value" ontbreekt [/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "A terme datum": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap/a_terme_datum_groep/a_terme_datum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/zwangerschap/a_terme_datum_groep/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek"><!-- == Check occurrences of children of /prio1_huidig/medisch_onderzoek: == -->
         <assert test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)">Fout aantal voorkomens van "Maternale onderzoeksgegevens": <value-of select="count(maternale_onderzoeksgegevens)"/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/medisch_onderzoek: == -->
      <rule context="/prio1_huidig/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/medisch_onderzoek/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/medisch_onderzoek/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Check occurrences of children of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
         <assert test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)">Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Check occurrences of children of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
         <assert test="(count(hb) ge 0) and (count(hb) le 1)">Fout aantal voorkomens van "Hb": <value-of select="count(hb)"/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hb": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814')">Foutieve informatie voor "Hb": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hb": Attribuut "value" ontbreekt [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hb": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Hb": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'mmol/L')">Foutieve informatie voor "Hb": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "mmol/L" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hb": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension == -->
</schema>
