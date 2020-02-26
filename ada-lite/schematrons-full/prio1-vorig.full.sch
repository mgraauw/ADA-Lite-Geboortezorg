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
<!-- == Generated Schematron file for validating ADA Full prio1_vorige_zwangerschap documents == --><!-- == Source: design/specs-full/prio1-vorig.xml == --><!-- == Generator(s): design/xsl/ada-rtd2ada-schema-simple.xsl; design/xsl/ada-schema-simple2ada-schematron.xsl == -->   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(prio1_vorige_zwangerschap) eq 1">Fout aantal voorkomens van "Prio1 vorige zwangerschap": <value-of select="count(prio1_vorige_zwangerschap)"/> (verwacht: 1) [/prio1_vorige_zwangerschap]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Prio1 vorige zwangerschap": Attribuut "transactionRef" ontbreekt [/prio1_vorige_zwangerschap/@transactionRef]</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prio1 vorige zwangerschap": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_vorige_zwangerschap/@transactionRef; type=t-id]</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2499')">Foutieve informatie voor "Prio1 vorige zwangerschap": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2499" [/prio1_vorige_zwangerschap/@transactionRef]</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="exists(@transactionEffectiveDate)">Foutieve informatie voor "Prio1 vorige zwangerschap": Attribuut "transactionEffectiveDate" ontbreekt [/prio1_vorige_zwangerschap/@transactionEffectiveDate]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 vorige zwangerschap": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_vorige_zwangerschap/@transactionEffectiveDate; type=xs:dateTime]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2020-01-08T13:47:27')">Foutieve informatie voor "Prio1 vorige zwangerschap": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2020-01-08T13:47:27" [/prio1_vorige_zwangerschap/@transactionEffectiveDate]</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="exists(@versionDate)">Foutieve informatie voor "Prio1 vorige zwangerschap": Attribuut "versionDate" ontbreekt [/prio1_vorige_zwangerschap/@versionDate]</assert>
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 vorige zwangerschap": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_vorige_zwangerschap/@versionDate; type=xs:dateTime]</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="exists(@prefix)">Foutieve informatie voor "Prio1 vorige zwangerschap": Attribuut "prefix" ontbreekt [/prio1_vorige_zwangerschap/@prefix]</assert>
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Prio1 vorige zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_vorige_zwangerschap"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap: == -->
         <assert test="count(zorgverlenerzorginstelling) eq 1">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling]</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/vrouw]</assert>
         <assert test="(count(zwangerschap) ge 0) and (count(zwangerschap) le 1)">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zwangerschap]</assert>
         <assert test="(count(bevalling) ge 0) and (count(bevalling) le 1)">Fout aantal voorkomens van "Bevalling": <value-of select="count(bevalling)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/bevalling]</assert>
         <assert test="count(uitkomst_per_kind) ge 0">Fout aantal voorkomens van "Uitkomst (per kind)": <value-of select="count(uitkomst_per_kind)"/> (verwacht: 0 of meer) [/prio1_vorige_zwangerschap/uitkomst_per_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap: == -->
      <rule context="/prio1_vorige_zwangerschap/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener/Zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vrouw": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2" [/prio1_vorige_zwangerschap/vrouw/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschap": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3" [/prio1_vorige_zwangerschap/zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/bevalling: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bevalling": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/bevalling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.6')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.6" [/prio1_vorige_zwangerschap/bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Uitkomst (per kind)": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.7')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.7" [/prio1_vorige_zwangerschap/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling: == -->
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/zorgverlenerzorginstelling: == -->
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/*[not(self::zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="(count(zorginstelling_oid) ge 0) and (count(zorginstelling_oid) le 1)">Fout aantal voorkomens van "Zorginstelling OID": <value-of select="count(zorginstelling_oid)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid]</assert>
         <assert test="(count(zorginstelling_agbid) ge 0) and (count(zorginstelling_agbid) le 1)">Fout aantal voorkomens van "Zorginstelling AGB-ID": <value-of select="count(zorginstelling_agbid)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid]</assert>
         <assert test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid]</assert>
         <assert test="(count(zorginstelling_ura) ge 0) and (count(zorginstelling_ura) le 1)">Fout aantal voorkomens van "Zorginstelling URA": <value-of select="count(zorginstelling_ura)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura]</assert>
         <assert test="(count(naam_zorginstelling) ge 0) and (count(naam_zorginstelling) le 1)">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</assert>
         <assert test="(count(adres_zorginstelling) ge 0) and (count(adres_zorginstelling) le 1)">Fout aantal voorkomens van "Adres zorginstelling": <value-of select="count(adres_zorginstelling)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling]</assert>
         <assert test="(count(type_zorginstelling) ge 0) and (count(type_zorginstelling) le 1)">Fout aantal voorkomens van "Type zorginstelling": <value-of select="count(type_zorginstelling)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling]</assert>
         <assert test="(count(type_zorginstelling_bij_verwijzing) ge 0) and (count(type_zorginstelling_bij_verwijzing) le 1)">Fout aantal voorkomens van "Type zorginstelling (bij verwijzing)": <value-of select="count(type_zorginstelling_bij_verwijzing)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::type_zorginstelling)][not(self::type_zorginstelling_bij_verwijzing)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling OID": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling OID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021')">Foutieve informatie voor "Zorginstelling OID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling OID": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling OID": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; max-length=8]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; max-length=5]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling URA": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024')">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling URA": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; max-length=8]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling URA": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Adres zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adres zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027')">Foutieve informatie voor "Adres zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Adres zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029')">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type zorginstelling": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type zorginstelling": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@code]</assert>
         <assert test="empty(@code) or (@code = ('Z3', 'G3', 'V4', 'B2', 'L1'))">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@code; allowed=('Z3', 'G3', 'V4', 'B2', 'L1')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type zorginstelling": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060'))">Foutieve informatie voor "Type zorginstelling": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@codeSystem; allowed=('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type zorginstelling": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019')">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@value]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@code]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@codeSystem]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
         <assert test="(count(straatnaam) ge 0) and (count(straatnaam) le 1)">Fout aantal voorkomens van "Straatnaam": <value-of select="count(straatnaam)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam]</assert>
         <assert test="(count(huisnummer) ge 0) and (count(huisnummer) le 1)">Fout aantal voorkomens van "Huisnummer": <value-of select="count(huisnummer)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer]</assert>
         <assert test="(count(huisletterhuisnummertoevoeging) ge 0) and (count(huisletterhuisnummertoevoeging) le 1)">Fout aantal voorkomens van "Huisletter/huisnummertoevoeging": <value-of select="count(huisletterhuisnummertoevoeging)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging]</assert>
         <assert test="(count(postcode) ge 0) and (count(postcode) le 1)">Fout aantal voorkomens van "Postcode": <value-of select="count(postcode)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode]</assert>
         <assert test="(count(plaatsnaam) ge 0) and (count(plaatsnaam) le 1)">Fout aantal voorkomens van "Plaatsnaam": <value-of select="count(plaatsnaam)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam]</assert>
         <assert test="(count(gemeentenaam) ge 0) and (count(gemeentenaam) le 1)">Fout aantal voorkomens van "Gemeentenaam": <value-of select="count(gemeentenaam)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam]</assert>
         <assert test="(count(land) ge 0) and (count(land) le 1)">Fout aantal voorkomens van "Land": <value-of select="count(land)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land]</assert>
         <assert test="(count(adrestype) ge 0) and (count(adrestype) le 1)">Fout aantal voorkomens van "Adrestype": <value-of select="count(adrestype)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::gemeentenaam)][not(self::land)][not(self::adrestype)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Straatnaam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Straatnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032')">Foutieve informatie voor "Straatnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Straatnaam": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Straatnaam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Huisnummer": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Huisnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033')">Foutieve informatie voor "Huisnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Huisnummer": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Huisnummer": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034')">Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Postcode": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Postcode": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Plaatsnaam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Plaatsnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036')">Foutieve informatie voor "Plaatsnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Plaatsnaam": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Plaatsnaam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gemeentenaam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gemeentenaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037')">Foutieve informatie voor "Gemeentenaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gemeentenaam": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Gemeentenaam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Land": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Land": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038')">Foutieve informatie voor "Land": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Land": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Land": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Adrestype": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adrestype": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039')">Foutieve informatie voor "Adrestype": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039" [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Adrestype": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@value]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Adrestype": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@code]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Adrestype": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@codeSystem]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Adrestype": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Adrestype": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/vrouw: == -->
         <assert test="count(burgerservicenummer) eq 1">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer]</assert>
         <assert test="(count(naamgegevens) ge 0) and (count(naamgegevens) le 1)">Fout aantal voorkomens van "Naamgegevens": <value-of select="count(naamgegevens)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/vrouw: == -->
      <rule context="/prio1_vorige_zwangerschap/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/vrouw/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Burgerservicenummer": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030" [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer/@value; max-length=9]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naamgegevens": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/vrouw/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/vrouw/naamgegevens: == -->
         <assert test="(count(voornamen) ge 0) and (count(voornamen) le 1)">Fout aantal voorkomens van "Voornamen": <value-of select="count(voornamen)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen]</assert>
         <assert test="(count(initialen) ge 0) and (count(initialen) le 1)">Fout aantal voorkomens van "Initialen": <value-of select="count(initialen)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen]</assert>
         <assert test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">Fout aantal voorkomens van "Roepnaam": <value-of select="count(roepnaam)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam]</assert>
         <assert test="count(achternaam) eq 1">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/vrouw/naamgegevens: == -->
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/vrouw/naamgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voornamen": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/voornamen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Initialen": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Initialen": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Initialen": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/initialen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Roepnaam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/vrouw/naamgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam: == -->
         <assert test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">Fout aantal voorkomens van "Soort naam": <value-of select="count(soort_naam)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam]</assert>
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel]</assert>
         <assert test="count(achternaam) eq 1">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam: == -->
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Soort naam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Soort naam": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('1', '2')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Soort naam": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@code]</assert>
         <assert test="empty(@code) or (@code = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Soort naam": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Soort naam": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043" [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/vrouw/naamgegevens/achternaam/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zwangerschap"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/zwangerschap: == -->
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zwangerschap/graviditeit]</assert>
         <assert test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)">Fout aantal voorkomens van "Pariteit (vóór deze zwangerschap)": <value-of select="count(pariteit_voor_deze_zwangerschap)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap]</assert>
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap]</assert>
         <assert test="(count(datum_einde_zwangerschap) ge 0) and (count(datum_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Datum einde zwangerschap": <value-of select="count(datum_einde_zwangerschap)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/zwangerschap: == -->
      <rule context="/prio1_vorige_zwangerschap/zwangerschap/*[not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Graviditeit": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010" [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_vorige_zwangerschap/zwangerschap/graviditeit/@value; max-inclusive=75]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zwangerschap/graviditeit; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20150')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20150" [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap/@value; max-inclusive=30]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zwangerschap/pariteit_voor_deze_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80625')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80625" [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum einde zwangerschap": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20540')">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20540" [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum einde zwangerschap": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum einde zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/zwangerschap/datum_einde_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/zwangerschap/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/bevalling"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/bevalling: == -->
         <assert test="(count(tijdstip_begin_actieve_ontsluiting) ge 0) and (count(tijdstip_begin_actieve_ontsluiting) le 1)">Fout aantal voorkomens van "Tijdstip begin actieve ontsluiting": <value-of select="count(tijdstip_begin_actieve_ontsluiting)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting]</assert>
         <assert test="(count(duur_actieve_ontsluitingsfase_ontsluitingsduur) ge 0) and (count(duur_actieve_ontsluitingsfase_ontsluitingsduur) le 1)">Fout aantal voorkomens van "Duur actieve ontsluitingsfase (Ontsluitingsduur)": <value-of select="count(duur_actieve_ontsluitingsfase_ontsluitingsduur)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur]</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies]</assert>
         <assert test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)">Fout aantal voorkomens van "Conditie perineum postpartum": <value-of select="count(conditie_perineum_postpartum)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/bevalling: == -->
      <rule context="/prio1_vorige_zwangerschap/bevalling/*[not(self::tijdstip_begin_actieve_ontsluiting)][not(self::duur_actieve_ontsluitingsfase_ontsluitingsduur)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20590')">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20590" [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Tijdstip begin actieve ontsluiting": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/bevalling/tijdstip_begin_actieve_ontsluiting; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82869')">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82869" [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": Attribuut "unit" ontbreekt [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'h')">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "h" [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Duur actieve ontsluitingsfase (Ontsluitingsduur)": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/bevalling/duur_actieve_ontsluitingsfase_ontsluitingsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20640')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20640" [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "unit" ontbreekt [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80673')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80673" [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@code]</assert>
         <assert test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@code; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/bevalling/conditie_perineum_postpartum; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/bevalling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind: == -->
         <assert test="count(baring) eq 1">Fout aantal voorkomens van "Baring": <value-of select="count(baring)"/> (verwacht: 1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Baring": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40002')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40002" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring: == -->
         <assert test="(count(demografische_gegevens) ge 0) and (count(demografische_gegevens) le 1)">Fout aantal voorkomens van "Demografische gegevens": <value-of select="count(demografische_gegevens)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens]</assert>
         <assert test="(count(kindspecifieke_maternale_gegevens) ge 0) and (count(kindspecifieke_maternale_gegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke maternale gegevens": <value-of select="count(kindspecifieke_maternale_gegevens)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens]</assert>
         <assert test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke uitkomstgegevens": <value-of select="count(kindspecifieke_uitkomstgegevens)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind/baring: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/*[not(self::demografische_gegevens)][not(self::kindspecifieke_maternale_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Demografische gegevens": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40006')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40006" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke maternale gegevens": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.71')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.71" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke maternale gegevens": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.72')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.72" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens: == -->
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/*[not(self::geboortedatum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40050')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40050" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/demografische_gegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
         <assert test="(count(tijdstip_actief_meepersen) ge 0) and (count(tijdstip_actief_meepersen) le 1)">Fout aantal voorkomens van "Tijdstip actief meepersen": <value-of select="count(tijdstip_actief_meepersen)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen]</assert>
         <assert test="(count(duur_uitdrijving_vanaf_actief_meepersen) ge 0) and (count(duur_uitdrijving_vanaf_actief_meepersen) le 1)">Fout aantal voorkomens van "Duur uitdrijving vanaf actief meepersen": <value-of select="count(duur_uitdrijving_vanaf_actief_meepersen)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/*[not(self::tijdstip_actief_meepersen)][not(self::duur_uitdrijving_vanaf_actief_meepersen)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Tijdstip actief meepersen": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.30030')">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.30030" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Tijdstip actief meepersen": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Tijdstip actief meepersen": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Tijdstip actief meepersen": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/tijdstip_actief_meepersen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82870')">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82870" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": Attribuut "unit" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'min')">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "min" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Duur uitdrijving vanaf actief meepersen": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/duur_uitdrijving_vanaf_actief_meepersen; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus]</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur]</assert>
         <assert test="(count(vaginale_kunstverlossing_groep) ge 0) and (count(vaginale_kunstverlossing_groep) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing (groep)": <value-of select="count(vaginale_kunstverlossing_groep)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep]</assert>
         <assert test="(count(lichamelijk_onderzoek_kind) ge 0) and (count(lichamelijk_onderzoek_kind) le 1)">Fout aantal voorkomens van "Lichamelijk onderzoek kind": <value-of select="count(lichamelijk_onderzoek_kind)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::vaginale_kunstverlossing_groep)][not(self::lichamelijk_onderzoek_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type partus": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80626')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80626" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type partus": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type partus": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code]</assert>
         <assert test="empty(@code) or (@code = ('177184002', '3311000146109', '11466000', '177141003', '274130007', '10', '447972007', '236990004', '9', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code; allowed=('177184002', '3311000146109', '11466000', '177141003', '274130007', '10', '447972007', '236990004', '9', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type partus": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.14', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.14.10', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.14', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.14.10', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type partus": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20062')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20062" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40189')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40189" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Lichamelijk onderzoek kind": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80766')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80766" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
         <assert test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing": <value-of select="count(vaginale_kunstverlossing)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40190')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40190" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "code" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code]</assert>
         <assert test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "codeSystem" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "displayName" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Check occurrences of children of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min]</assert>
         <assert test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)">Fout aantal voorkomens van "Geboortegewicht": <value-of select="count(geboortegewicht)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::apgarscore_na_5_min)][not(self::geboortegewicht)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40071')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40071" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min/@value; max-inclusive=10]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/apgarscore_na_5_min; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht: == -->
   <pattern>
      <rule context="/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortegewicht": Attribuut "conceptId" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40060')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.40060" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortegewicht": Attribuut "value" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Geboortegewicht": Attribuut "unit" ontbreekt [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'gram')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram" [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen [/prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorige_zwangerschap/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension == -->
</schema>
