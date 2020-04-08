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
<!-- == Generated Schematron file for validating ADA Full prio1_huidige_zwangerschap documents == --><!-- == Source: design/specs-full/prio1-huidig.xml == --><!-- == Generator(s): design/xsl/ada-rtd2ada-schema-simple.xsl; design/xsl/ada-schema-simple2ada-schematron.xsl == -->   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(prio1_huidige_zwangerschap) eq 1">Fout aantal voorkomens van "Prio1 huidige zwangerschap": <value-of select="count(prio1_huidige_zwangerschap)"/> (verwacht: 1) [/prio1_huidige_zwangerschap]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "transactionRef" ontbreekt [/prio1_huidige_zwangerschap/@transactionRef]</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_huidige_zwangerschap/@transactionRef; type=t-id]</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2493')">Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2493" [/prio1_huidige_zwangerschap/@transactionRef]</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="exists(@transactionEffectiveDate)">Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "transactionEffectiveDate" ontbreekt [/prio1_huidige_zwangerschap/@transactionEffectiveDate]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_huidige_zwangerschap/@transactionEffectiveDate; type=xs:dateTime]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2020-01-08T13:13:15')">Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2020-01-08T13:13:15" [/prio1_huidige_zwangerschap/@transactionEffectiveDate]</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="exists(@versionDate)">Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "versionDate" ontbreekt [/prio1_huidige_zwangerschap/@versionDate]</assert>
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_huidige_zwangerschap/@versionDate; type=xs:dateTime]</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="exists(@prefix)">Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "prefix" ontbreekt [/prio1_huidige_zwangerschap/@prefix]</assert>
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Prio1 huidige zwangerschap": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidige_zwangerschap"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap: == -->
         <assert test="count(zorgverlenerzorginstelling) eq 1">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling]</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw]</assert>
         <assert test="count(zwangerschap) eq 1">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap]</assert>
         <assert test="count(medisch_onderzoek) ge 0">Fout aantal voorkomens van "Medisch onderzoek": <value-of select="count(medisch_onderzoek)"/> (verwacht: 0 of meer) [/prio1_huidige_zwangerschap/medisch_onderzoek]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap: == -->
      <rule context="/prio1_huidige_zwangerschap/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::medisch_onderzoek)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener/Zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vrouw": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2" [/prio1_huidige_zwangerschap/vrouw/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zwangerschap: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschap": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3" [/prio1_huidige_zwangerschap/zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/medisch_onderzoek: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Medisch onderzoek": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.14')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.14" [/prio1_huidige_zwangerschap/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling: == -->
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/zorgverlenerzorginstelling: == -->
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/*[not(self::zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="(count(zorginstelling_oid) ge 0) and (count(zorginstelling_oid) le 1)">Fout aantal voorkomens van "Zorginstelling OID": <value-of select="count(zorginstelling_oid)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid]</assert>
         <assert test="(count(zorginstelling_agbid) ge 0) and (count(zorginstelling_agbid) le 1)">Fout aantal voorkomens van "Zorginstelling AGB-ID": <value-of select="count(zorginstelling_agbid)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid]</assert>
         <assert test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid]</assert>
         <assert test="(count(zorginstelling_ura) ge 0) and (count(zorginstelling_ura) le 1)">Fout aantal voorkomens van "Zorginstelling URA": <value-of select="count(zorginstelling_ura)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura]</assert>
         <assert test="(count(naam_zorginstelling) ge 0) and (count(naam_zorginstelling) le 1)">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</assert>
         <assert test="(count(adres_zorginstelling) ge 0) and (count(adres_zorginstelling) le 1)">Fout aantal voorkomens van "Adres zorginstelling": <value-of select="count(adres_zorginstelling)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling]</assert>
         <assert test="(count(type_zorginstelling) ge 0) and (count(type_zorginstelling) le 1)">Fout aantal voorkomens van "Type zorginstelling": <value-of select="count(type_zorginstelling)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling]</assert>
         <assert test="(count(type_zorginstelling_bij_verwijzing) ge 0) and (count(type_zorginstelling_bij_verwijzing) le 1)">Fout aantal voorkomens van "Type zorginstelling (bij verwijzing)": <value-of select="count(type_zorginstelling_bij_verwijzing)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::type_zorginstelling)][not(self::type_zorginstelling_bij_verwijzing)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling OID": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling OID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021')">Foutieve informatie voor "Zorginstelling OID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zorginstelling OID": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; max-length=8]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; max-length=5]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling URA": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024')">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; max-length=8]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Zorginstelling URA": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Adres zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adres zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027')">Foutieve informatie voor "Adres zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Adres zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029')">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type zorginstelling": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type zorginstelling": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@code]</assert>
         <assert test="empty(@code) or (@code = ('Z3', 'G3', 'V4', 'B2', 'L1'))">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@code; allowed=('Z3', 'G3', 'V4', 'B2', 'L1')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type zorginstelling": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060'))">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@codeSystem; allowed=('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type zorginstelling": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019')">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@value]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@code]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@codeSystem]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
         <assert test="(count(straatnaam) ge 0) and (count(straatnaam) le 1)">Fout aantal voorkomens van "Straatnaam": <value-of select="count(straatnaam)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam]</assert>
         <assert test="(count(huisnummer) ge 0) and (count(huisnummer) le 1)">Fout aantal voorkomens van "Huisnummer": <value-of select="count(huisnummer)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer]</assert>
         <assert test="(count(huisletterhuisnummertoevoeging) ge 0) and (count(huisletterhuisnummertoevoeging) le 1)">Fout aantal voorkomens van "Huisletter/huisnummertoevoeging": <value-of select="count(huisletterhuisnummertoevoeging)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging]</assert>
         <assert test="(count(postcode) ge 0) and (count(postcode) le 1)">Fout aantal voorkomens van "Postcode": <value-of select="count(postcode)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode]</assert>
         <assert test="(count(plaatsnaam) ge 0) and (count(plaatsnaam) le 1)">Fout aantal voorkomens van "Plaatsnaam": <value-of select="count(plaatsnaam)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam]</assert>
         <assert test="(count(gemeentenaam) ge 0) and (count(gemeentenaam) le 1)">Fout aantal voorkomens van "Gemeentenaam": <value-of select="count(gemeentenaam)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam]</assert>
         <assert test="(count(land) ge 0) and (count(land) le 1)">Fout aantal voorkomens van "Land": <value-of select="count(land)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land]</assert>
         <assert test="(count(adrestype) ge 0) and (count(adrestype) le 1)">Fout aantal voorkomens van "Adrestype": <value-of select="count(adrestype)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::gemeentenaam)][not(self::land)][not(self::adrestype)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Straatnaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Straatnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032')">Foutieve informatie voor "Straatnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Straatnaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Huisnummer": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Huisnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033')">Foutieve informatie voor "Huisnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Huisnummer": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034')">Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Postcode": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Plaatsnaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Plaatsnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036')">Foutieve informatie voor "Plaatsnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Plaatsnaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gemeentenaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gemeentenaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037')">Foutieve informatie voor "Gemeentenaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Gemeentenaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Land": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Land": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038')">Foutieve informatie voor "Land": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Land": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Adrestype": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adrestype": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039')">Foutieve informatie voor "Adrestype": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Adrestype": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@value]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Adrestype": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@code]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Adrestype": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@codeSystem]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Adrestype": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Adrestype": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/vrouw: == -->
         <assert test="count(burgerservicenummer) eq 1">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer]</assert>
         <assert test="(count(naamgegevens) ge 0) and (count(naamgegevens) le 1)">Fout aantal voorkomens van "Naamgegevens": <value-of select="count(naamgegevens)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens]</assert>
         <assert test="(count(bloedgroep_vrouw) ge 0) and (count(bloedgroep_vrouw) le 1)">Fout aantal voorkomens van "Bloedgroep vrouw": <value-of select="count(bloedgroep_vrouw)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw]</assert>
         <assert test="(count(rhesus_d_factor_vrouw) ge 0) and (count(rhesus_d_factor_vrouw) le 1)">Fout aantal voorkomens van "Rhesus D Factor vrouw": <value-of select="count(rhesus_d_factor_vrouw)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw]</assert>
         <assert test="(count(rhesus_c_factor) ge 0) and (count(rhesus_c_factor) le 1)">Fout aantal voorkomens van "Rhesus c Factor": <value-of select="count(rhesus_c_factor)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/vrouw: == -->
      <rule context="/prio1_huidige_zwangerschap/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/vrouw/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Burgerservicenummer": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030" [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@value; max-length=9]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naamgegevens": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bloedgroep vrouw": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10810')">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10810" [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bloedgroep vrouw": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Bloedgroep vrouw": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@code]</assert>
         <assert test="empty(@code) or (@code = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@code; allowed=('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Bloedgroep vrouw": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Bloedgroep vrouw": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Bloedgroep vrouw": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10811')">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10811" [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@code]</assert>
         <assert test="empty(@code) or (@code = ('165747007', '165746003', 'UNK', 'NI'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@code; allowed=('165747007', '165746003', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Rhesus D Factor vrouw": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/rhesus_c_factor: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Rhesus c Factor": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10816')">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10816" [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Rhesus c Factor": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Rhesus c Factor": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@code]</assert>
         <assert test="empty(@code) or (@code = ('733120009', '733119003', 'NI'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@code; allowed=('733120009', '733119003', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Rhesus c Factor": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Rhesus c Factor": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Rhesus c Factor": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/vrouw/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/vrouw/naamgegevens: == -->
         <assert test="(count(voornamen) ge 0) and (count(voornamen) le 1)">Fout aantal voorkomens van "Voornamen": <value-of select="count(voornamen)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen]</assert>
         <assert test="(count(initialen) ge 0) and (count(initialen) le 1)">Fout aantal voorkomens van "Initialen": <value-of select="count(initialen)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen]</assert>
         <assert test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">Fout aantal voorkomens van "Roepnaam": <value-of select="count(roepnaam)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam]</assert>
         <assert test="count(achternaam) eq 1">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/vrouw/naamgegevens: == -->
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/vrouw/naamgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Initialen": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Initialen": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Roepnaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/vrouw/naamgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam: == -->
         <assert test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">Fout aantal voorkomens van "Soort naam": <value-of select="count(soort_naam)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam]</assert>
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel]</assert>
         <assert test="count(achternaam) eq 1">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam: == -->
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Soort naam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Soort naam": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('1', '2')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Soort naam": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@code]</assert>
         <assert test="empty(@code) or (@code = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Soort naam": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Soort naam": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@displayName]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/zwangerschap: == -->
         <assert test="count(graviditeit) eq 1">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/graviditeit]</assert>
         <assert test="count(pariteit) eq 1">Fout aantal voorkomens van "Pariteit": <value-of select="count(pariteit)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/pariteit]</assert>
         <assert test="count(a_terme_datum_groep) eq 1">Fout aantal voorkomens van "A terme datum (groep)": <value-of select="count(a_terme_datum_groep)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/zwangerschap: == -->
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/*[not(self::graviditeit)][not(self::pariteit)][not(self::a_terme_datum_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Graviditeit": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010" [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@value; max-inclusive=75]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/graviditeit; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zwangerschap/pariteit: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/pariteit"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pariteit": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20153')">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20153" [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@value; max-inclusive=30]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Pariteit": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/pariteit; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "A terme datum (groep)": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "A terme datum (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20029')">Foutieve informatie voor "A terme datum (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20029" [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "A terme datum (groep)": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/zwangerschap/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep: == -->
         <assert test="count(a_terme_datum) eq 1">Fout aantal voorkomens van "A terme datum": <value-of select="count(a_terme_datum)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep: == -->
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "A terme datum": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20030')">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20030" [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "A terme datum": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/medisch_onderzoek: == -->
         <assert test="count(datum_onderzoek) eq 1">Fout aantal voorkomens van "Datum onderzoek": <value-of select="count(datum_onderzoek)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek]</assert>
         <assert test="count(maternale_onderzoeksgegevens) eq 1">Fout aantal voorkomens van "Maternale onderzoeksgegevens": <value-of select="count(maternale_onderzoeksgegevens)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/medisch_onderzoek/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/medisch_onderzoek: == -->
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/*[not(self::datum_onderzoek)][not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/medisch_onderzoek/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum onderzoek": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.50020')">Foutieve informatie voor "Datum onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.50020" [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum onderzoek": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@value; type=t-datetime]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Datum onderzoek": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Maternale onderzoeksgegevens": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.142')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.142" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/medisch_onderzoek/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
         <assert test="count(urine_bloed_en_aanvullende_onderzoeken) eq 1">Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80959')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80959" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Check occurrences of children of /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
         <assert test="count(hb) eq 1">Fout aantal voorkomens van "Hb": <value-of select="count(hb)"/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb: == -->
   <pattern>
      <rule context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hb": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hb": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10814')">Foutieve informatie voor "Hb": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10814" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hb": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Hb": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Hb": Attribuut "unit" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'mmol/L')">Foutieve informatie voor "Hb": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "mmol/L" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@unit]</assert>
         <!-- == Attribute "nullFlavor": == -->
         <!-- == Attribute "root": == -->
         <assert test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">Foutieve informatie voor "Hb": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension == -->
</schema>
