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
<!-- == Generated Schematron file for validating ADA Full voorgaande_zwangerschap_samenvatting_22 documents == --><!-- == Source: design/specs-full/samenvatting-voorgaande-zwangerschap-22.xml == --><!-- == Generator(s): design/xsl/ada-rtd2ada-schema-simple.xsl; design/xsl/ada-schema-simple2ada-schematron.xsl == -->   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(voorgaande_zwangerschap_samenvatting_22) eq 1">Fout aantal voorkomens van "Voorgaande zwangerschap samenvatting (2.2)": <value-of select="count(voorgaande_zwangerschap_samenvatting_22)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "transactionRef" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@transactionRef]</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/@transactionRef; type=t-id]</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2465')">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2465" [/voorgaande_zwangerschap_samenvatting_22/@transactionRef]</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="exists(@transactionEffectiveDate)">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "transactionEffectiveDate" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@transactionEffectiveDate]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/@transactionEffectiveDate; type=xs:dateTime]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2019-03-07T15:23:44')">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2019-03-07T15:23:44" [/voorgaande_zwangerschap_samenvatting_22/@transactionEffectiveDate]</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="exists(@versionDate)">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "versionDate" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@versionDate]</assert>
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/@versionDate; type=xs:dateTime]</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="exists(@prefix)">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "prefix" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@prefix]</assert>
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22: == -->
         <assert test="count(zorgverlenerzorginstelling) eq 1">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling]</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/vrouw]</assert>
         <assert test="count(zwangerschap) eq 1">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap]</assert>
         <assert test="(count(bevalling) ge 0) and (count(bevalling) le 1)">Fout aantal voorkomens van "Bevalling": <value-of select="count(bevalling)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling]</assert>
         <assert test="count(uitkomst_per_kind) ge 0">Fout aantal voorkomens van "Uitkomst (per kind)": <value-of select="count(uitkomst_per_kind)"/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind]</assert>
         <assert test="(count(medisch_onderzoek) ge 0) and (count(medisch_onderzoek) le 1)">Fout aantal voorkomens van "Medisch onderzoek": <value-of select="count(medisch_onderzoek)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::medisch_onderzoek)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener/Zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vrouw": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/voorgaande_zwangerschap_samenvatting_22/vrouw/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bevalling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6" [/voorgaande_zwangerschap_samenvatting_22/bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Uitkomst (per kind)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Medisch onderzoek": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling: == -->
         <assert test="count(zorgverlener) eq 1">Fout aantal voorkomens van "Zorgverlener": <value-of select="count(zorgverlener)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener]</assert>
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener: == -->
         <assert test="(count(zorgverlener_uzinummer) ge 0) and (count(zorgverlener_uzinummer) le 1)">Fout aantal voorkomens van "Zorgverlener UZI-nummer": <value-of select="count(zorgverlener_uzinummer)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer]</assert>
         <assert test="(count(zorgverlener_agbid) ge 0) and (count(zorgverlener_agbid) le 1)">Fout aantal voorkomens van "Zorgverlener AGB-ID": <value-of select="count(zorgverlener_agbid)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid]</assert>
         <assert test="(count(zorgverlener_lvr1id) ge 0) and (count(zorgverlener_lvr1id) le 1)">Fout aantal voorkomens van "Zorgverlener LVR1-ID": <value-of select="count(zorgverlener_lvr1id)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id]</assert>
         <assert test="(count(naam_zorgverlener) ge 0) and (count(naam_zorgverlener) le 1)">Fout aantal voorkomens van "Naam zorgverlener": <value-of select="count(naam_zorgverlener)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener]</assert>
         <assert test="(count(zorgverlenertype) ge 0) and (count(zorgverlenertype) le 1)">Fout aantal voorkomens van "Zorgverlenertype": <value-of select="count(zorgverlenertype)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/*[not(self::zorgverlener_uzinummer)][not(self::zorgverlener_agbid)][not(self::zorgverlener_lvr1id)][not(self::naam_zorgverlener)][not(self::zorgverlenertype)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener UZI-nummer": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10002')">Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10002" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorgverlener UZI-nummer": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@value; max-length=9]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorgverlener UZI-nummer": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener AGB-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10003')">Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10003" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorgverlener AGB-ID": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@value; max-length=8]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorgverlener AGB-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlener LVR1-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10004')">Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10004" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorgverlener LVR1-ID": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 4)">Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@value; max-length=4]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorgverlener LVR1-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naam zorgverlener": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorgverlener": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorgverlenertype": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlenertype": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10010')">Foutieve informatie voor "Zorgverlenertype": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10010" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorgverlenertype": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Zorgverlenertype": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Zorgverlenertype": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@code]</assert>
         <assert test="empty(@code) or (@code = ('01.000', '01.015', '01.019', '01.020', '01.046', '03.000', 'AA.001', 'AA.002'))">Foutieve informatie voor "Zorgverlenertype": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@code; allowed=('01.000', '01.015', '01.019', '01.020', '01.046', '03.000', 'AA.001', 'AA.002')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Zorgverlenertype": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.98.111', '2.16.840.1.113883.2.4.98.111'))">Foutieve informatie voor "Zorgverlenertype": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@codeSystem; allowed=('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.98.111', '2.16.840.1.113883.2.4.98.111')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Zorgverlenertype": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Zorgverlenertype": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="(count(zorginstelling_oid) ge 0) and (count(zorginstelling_oid) le 1)">Fout aantal voorkomens van "Zorginstelling OID": <value-of select="count(zorginstelling_oid)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid]</assert>
         <assert test="(count(zorginstelling_agbid) ge 0) and (count(zorginstelling_agbid) le 1)">Fout aantal voorkomens van "Zorginstelling AGB-ID": <value-of select="count(zorginstelling_agbid)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid]</assert>
         <assert test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)">Fout aantal voorkomens van "Zorginstelling LVR-ID": <value-of select="count(zorginstelling_lvrid)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid]</assert>
         <assert test="(count(zorginstelling_ura) ge 0) and (count(zorginstelling_ura) le 1)">Fout aantal voorkomens van "Zorginstelling URA": <value-of select="count(zorginstelling_ura)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura]</assert>
         <assert test="(count(naam_zorginstelling) ge 0) and (count(naam_zorginstelling) le 1)">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</assert>
         <assert test="(count(adres_zorginstelling) ge 0) and (count(adres_zorginstelling) le 1)">Fout aantal voorkomens van "Adres zorginstelling": <value-of select="count(adres_zorginstelling)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling OID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling OID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10021')">Foutieve informatie voor "Zorginstelling OID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10021" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling OID": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling OID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10022')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10022" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; max-length=8]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023')">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 5)">Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; max-length=5]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling URA": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10024')">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10024" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling URA": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling URA": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; max-length=8]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling URA": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Adres zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Adres zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10027')">Foutieve informatie voor "Adres zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10027" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Adres zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
         <assert test="count(straatnaam) eq 1">Fout aantal voorkomens van "Straatnaam": <value-of select="count(straatnaam)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam]</assert>
         <assert test="count(huisnummer) eq 1">Fout aantal voorkomens van "Huisnummer": <value-of select="count(huisnummer)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer]</assert>
         <assert test="(count(huisletterhuisnummertoevoeging) ge 0) and (count(huisletterhuisnummertoevoeging) le 1)">Fout aantal voorkomens van "Huisletter/huisnummertoevoeging": <value-of select="count(huisletterhuisnummertoevoeging)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging]</assert>
         <assert test="count(postcode) eq 1">Fout aantal voorkomens van "Postcode": <value-of select="count(postcode)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode]</assert>
         <assert test="count(plaatsnaam) eq 1">Fout aantal voorkomens van "Plaatsnaam": <value-of select="count(plaatsnaam)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam]</assert>
         <assert test="(count(land) ge 0) and (count(land) le 1)">Fout aantal voorkomens van "Land": <value-of select="count(land)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::land)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Straatnaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Straatnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10032')">Foutieve informatie voor "Straatnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10032" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Straatnaam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Straatnaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Huisnummer": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Huisnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10033')">Foutieve informatie voor "Huisnummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10033" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Huisnummer": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Huisnummer": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10034')">Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10034" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Huisletter/huisnummertoevoeging": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Postcode": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10041')">Foutieve informatie voor "Postcode": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10041" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Postcode": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Plaatsnaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Plaatsnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10036')">Foutieve informatie voor "Plaatsnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10036" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Plaatsnaam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Plaatsnaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Land": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Land": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10038')">Foutieve informatie voor "Land": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10038" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Land": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Land": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/vrouw: == -->
         <assert test="(count(burgerservicenummer) ge 0) and (count(burgerservicenummer) le 1)">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer]</assert>
         <assert test="(count(naamgegevens) ge 1) and (count(naamgegevens) le 2)">Fout aantal voorkomens van "Naamgegevens": <value-of select="count(naamgegevens)"/> (verwacht: 1..2) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens]</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/vrouw: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::geboortedatum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/vrouw/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Burgerservicenummer": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@value; max-length=9]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naamgegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040" [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/vrouw/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens: == -->
         <assert test="(count(voornamen) ge 0) and (count(voornamen) le 1)">Fout aantal voorkomens van "Voornamen": <value-of select="count(voornamen)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen]</assert>
         <assert test="(count(initialen) ge 0) and (count(initialen) le 1)">Fout aantal voorkomens van "Initialen": <value-of select="count(initialen)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen]</assert>
         <assert test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">Fout aantal voorkomens van "Roepnaam": <value-of select="count(roepnaam)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voornamen": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Initialen": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359')">Foutieve informatie voor "Initialen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Initialen": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Initialen": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Roepnaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam: == -->
         <assert test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">Fout aantal voorkomens van "Soort naam": <value-of select="count(soort_naam)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam]</assert>
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Soort naam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Soort naam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('1', '2')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Soort naam": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@code]</assert>
         <assert test="empty(@code) or (@code = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Soort naam": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Soort naam": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/zwangerschap: == -->
         <assert test="(count(identificatie_van_de_zwangerschap) ge 0) and (count(identificatie_van_de_zwangerschap) le 1)">Fout aantal voorkomens van "Identificatie van de zwangerschap": <value-of select="count(identificatie_van_de_zwangerschap)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap]</assert>
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit]</assert>
         <assert test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)">Fout aantal voorkomens van "Pariteit (vóór deze zwangerschap)": <value-of select="count(pariteit_voor_deze_zwangerschap)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap]</assert>
         <assert test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)">Fout aantal voorkomens van "Definitieve à terme datum": <value-of select="count(definitieve_a_terme_datum)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum]</assert>
         <assert test="count(diagnose) ge 0">Fout aantal voorkomens van "Diagnose": <value-of select="count(diagnose)"/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose]</assert>
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap]</assert>
         <assert test="(count(datum_einde_zwangerschap) ge 0) and (count(datum_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Datum einde zwangerschap": <value-of select="count(datum_einde_zwangerschap)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/zwangerschap: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/*[not(self::identificatie_van_de_zwangerschap)][not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::diagnose)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Identificatie van de zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Identificatie van de zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80627')">Foutieve informatie voor "Identificatie van de zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80627" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Identificatie van de zwangerschap": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Identificatie van de zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Graviditeit": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value; max-inclusive=75]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value; max-inclusive=30]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Definitieve à terme datum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160')">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Definitieve à terme datum": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Definitieve à terme datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Definitieve à terme datum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diagnose": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268')">Foutieve informatie voor "Diagnose": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum einde zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540')">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum einde zwangerschap": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum einde zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/zwangerschap/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose: == -->
         <assert test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)">Fout aantal voorkomens van "Gynaecologische aandoening": <value-of select="count(gynaecologische_aandoening)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening]</assert>
         <assert test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)">Fout aantal voorkomens van "Bloedverlies?": <value-of select="count(bloedverliesq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq]</assert>
         <assert test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)">Fout aantal voorkomens van "Cervixinsufficiëntie?": <value-of select="count(cervixinsufficientieq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq]</assert>
         <assert test="(count(infectie) ge 0) and (count(infectie) le 1)">Fout aantal voorkomens van "Infectie": <value-of select="count(infectie)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie]</assert>
         <assert test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)">Fout aantal voorkomens van "Hyperemesis gravidarum?": <value-of select="count(hyperemesis_gravidarumq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq]</assert>
         <assert test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)">Fout aantal voorkomens van "Hypertensieve aandoening": <value-of select="count(hypertensieve_aandoening)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening]</assert>
         <assert test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)">Fout aantal voorkomens van "Zwangerschapscholestase?": <value-of select="count(zwangerschapscholestaseq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq]</assert>
         <assert test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)">Fout aantal voorkomens van "Diabetes gravidarum met insuline?": <value-of select="count(diabetes_gravidarum_met_insulineq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq]</assert>
         <assert test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)">Fout aantal voorkomens van "Afwijkende groei foetus": <value-of select="count(afwijkende_groei_foetus)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus]</assert>
         <assert test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)">Fout aantal voorkomens van "Dreigende partus immaturus?": <value-of select="count(dreigende_partus_immaturusq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq]</assert>
         <assert test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)">Fout aantal voorkomens van "Dreigende partus prematurus?": <value-of select="count(dreigende_partus_prematurusq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq]</assert>
         <assert test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)">Fout aantal voorkomens van "Abruptio placentae?": <value-of select="count(abruptio_placentaeq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/*[not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269')">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@code; allowed=('129103003', '95315005', '37849005', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Gynaecologische aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Gynaecologische aandoening": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bloedverlies?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270')">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bloedverlies?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Bloedverlies?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Bloedverlies?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271')">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Cervixinsufficiëntie?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Infectie": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273')">Foutieve informatie voor "Infectie": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Infectie": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Infectie": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@code]</assert>
         <assert test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@code; allowed=('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Infectie": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Infectie": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Infectie": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Infectie": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274')">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Hyperemesis gravidarum?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275')">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@code]</assert>
         <assert test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@code; allowed=('48194001', '398254007', '95605009', '15938005')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">Foutieve informatie voor "Hypertensieve aandoening": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Hypertensieve aandoening": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Hypertensieve aandoening": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276')">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zwangerschapscholestase?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277')">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Diabetes gravidarum met insuline?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278')">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@code]</assert>
         <assert test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@code; allowed=('199616008', '267258002', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Afwijkende groei foetus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Afwijkende groei foetus": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Afwijkende groei foetus": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279')">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Dreigende partus immaturus?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280')">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Dreigende partus prematurus?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Abruptio placentae?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289')">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Abruptio placentae?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Abruptio placentae?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Abruptio placentae?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/bevalling: == -->
         <assert test="(count(diagnose_bevalling) ge 0) and (count(diagnose_bevalling) le 1)">Fout aantal voorkomens van "Diagnose bevalling": <value-of select="count(diagnose_bevalling)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling]</assert>
         <assert test="(count(wijze_waarop_de_baring_begon) ge 0) and (count(wijze_waarop_de_baring_begon) le 1)">Fout aantal voorkomens van "Wijze waarop de baring begon": <value-of select="count(wijze_waarop_de_baring_begon)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon]</assert>
         <assert test="count(interventies_begin_baring_groep) ge 0">Fout aantal voorkomens van "Interventies begin baring (groep)": <value-of select="count(interventies_begin_baring_groep)"/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep]</assert>
         <assert test="(count(placenta) ge 0) and (count(placenta) le 1)">Fout aantal voorkomens van "Placenta": <value-of select="count(placenta)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta]</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies]</assert>
         <assert test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)">Fout aantal voorkomens van "Conditie perineum postpartum": <value-of select="count(conditie_perineum_postpartum)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/bevalling: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/*[not(self::diagnose_bevalling)][not(self::wijze_waarop_de_baring_begon)][not(self::interventies_begin_baring_groep)][not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Diagnose bevalling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose bevalling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550')">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550" [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@code; allowed=('1', '2', '3', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Wijze waarop de baring begon": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Interventies begin baring (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555')">Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555" [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Interventies begin baring (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/placenta: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Placenta": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612')">Foutieve informatie voor "Placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612" [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Placenta": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640" [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673" [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@code]</assert>
         <assert test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@code; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Conditie perineum postpartum": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/bevalling/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling: == -->
         <assert test="(count(datum) ge 0) and (count(datum) le 1)">Fout aantal voorkomens van "Datum": <value-of select="count(datum)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum]</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur]</assert>
         <assert test="(count(fluxus_postpartumq) ge 0) and (count(fluxus_postpartumq) le 1)">Fout aantal voorkomens van "Fluxus postpartum?": <value-of select="count(fluxus_postpartumq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/*[not(self::datum)][not(self::zwangerschapsduur)][not(self::fluxus_postpartumq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Datum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82381')">Foutieve informatie voor "Datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82381" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Datum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Fluxus postpartum?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Fluxus postpartum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82398')">Foutieve informatie voor "Fluxus postpartum?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82398" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Fluxus postpartum?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Fluxus postpartum?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Fluxus postpartum?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep: == -->
         <assert test="count(interventie_begin_baring) eq 1">Fout aantal voorkomens van "Interventie begin baring": <value-of select="count(interventie_begin_baring)"/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring]</assert>
         <assert test="(count(indicatie_interventie_begin_baring) ge 0) and (count(indicatie_interventie_begin_baring) le 1)">Fout aantal voorkomens van "Indicatie interventie begin baring": <value-of select="count(indicatie_interventie_begin_baring)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/*[not(self::interventie_begin_baring)][not(self::indicatie_interventie_begin_baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Interventie begin baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560')">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560" [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Interventie begin baring": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Interventie begin baring": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@code]</assert>
         <assert test="empty(@code) or (@code = ('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@code; allowed=('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Interventie begin baring": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Interventie begin baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Interventie begin baring": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Interventie begin baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570')">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570" [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@value]</assert>
         <assert test="empty(@value) or (@value = ('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@value; allowed=('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@code; allowed=('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Indicatie interventie begin baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/bevalling/placenta: == -->
         <assert test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)">Fout aantal voorkomens van "Geboorte placenta": <value-of select="count(geboorte_placenta)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/bevalling/placenta: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/*[not(self::geboorte_placenta)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboorte placenta": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630')">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630" [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboorte placenta": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Geboorte placenta": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@code]</assert>
         <assert test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@code; allowed=('0', '2', '3', '4', 'OTH', 'NI', 'UNK')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Geboorte placenta": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geboorte placenta": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Geboorte placenta": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Geboorte placenta": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind: == -->
         <assert test="(count(baring) ge 0) and (count(baring) le 1)">Fout aantal voorkomens van "Baring": <value-of select="count(baring)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring: == -->
         <assert test="(count(werkelijke_plaats_baring_type_locatie) ge 0) and (count(werkelijke_plaats_baring_type_locatie) le 1)">Fout aantal voorkomens van "Werkelijke plaats baring (type locatie)": <value-of select="count(werkelijke_plaats_baring_type_locatie)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie]</assert>
         <assert test="(count(ziekenhuis_baring) ge 0) and (count(ziekenhuis_baring) le 1)">Fout aantal voorkomens van "Ziekenhuis baring": <value-of select="count(ziekenhuis_baring)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring]</assert>
         <assert test="(count(demografische_gegevens) ge 0) and (count(demografische_gegevens) le 1)">Fout aantal voorkomens van "Demografische gegevens": <value-of select="count(demografische_gegevens)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens]</assert>
         <assert test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke uitkomstgegevens": <value-of select="count(kindspecifieke_uitkomstgegevens)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/*[not(self::werkelijke_plaats_baring_type_locatie)][not(self::ziekenhuis_baring)][not(self::demografische_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003')">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@value; allowed=('1', '2', '3', '4', '5', '6')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@code]</assert>
         <assert test="empty(@code) or (@code = ('169813005', '23', '22232009', '40', 'UNK', 'NI'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@code; allowed=('169813005', '23', '22232009', '40', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Ziekenhuis baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ziekenhuis baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114')">Foutieve informatie voor "Ziekenhuis baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Ziekenhuis baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Demografische gegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006')">Foutieve informatie voor "Demografische gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
         <assert test="(count(ziekenhuisnummer_lvrid) ge 0) and (count(ziekenhuisnummer_lvrid) le 1)">Fout aantal voorkomens van "Ziekenhuisnummer (LVR-id)": <value-of select="count(ziekenhuisnummer_lvrid)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid]</assert>
         <assert test="(count(zorginstelling_agbid) ge 0) and (count(zorginstelling_agbid) le 1)">Fout aantal voorkomens van "Zorginstelling AGB-ID": <value-of select="count(zorginstelling_agbid)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid]</assert>
         <assert test="(count(naam_zorginstelling) ge 0) and (count(naam_zorginstelling) le 1)">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/*[not(self::ziekenhuisnummer_lvrid)][not(self::zorginstelling_agbid)][not(self::naam_zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005')">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 4)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value; min-length=4]</assert>
         <assert test="empty(@value) or (string-length(@value) le 4)">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value; max-length=4]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82116')">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82116" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@value; min-length=8]</assert>
         <assert test="empty(@value) or (string-length(@value) le 8)">Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@value; max-length=8]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82117')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82117" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens: == -->
         <assert test="(count(naamgegevens_kind) ge 0) and (count(naamgegevens_kind) le 1)">Fout aantal voorkomens van "Naamgegevens kind": <value-of select="count(naamgegevens_kind)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind]</assert>
         <assert test="(count(geslacht_medische_observatie) ge 0) and (count(geslacht_medische_observatie) le 1)">Fout aantal voorkomens van "Geslacht (medische observatie)": <value-of select="count(geslacht_medische_observatie)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie]</assert>
         <assert test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">Fout aantal voorkomens van "Geboortedatum": <value-of select="count(geboortedatum)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum]</assert>
         <assert test="(count(perinatale_sterfte_groep) ge 0) and (count(perinatale_sterfte_groep) le 1)">Fout aantal voorkomens van "Perinatale sterfte (groep)": <value-of select="count(perinatale_sterfte_groep)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/*[not(self::naamgegevens_kind)][not(self::geslacht_medische_observatie)][not(self::geboortedatum)][not(self::perinatale_sterfte_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Naamgegevens kind": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82051')">Foutieve informatie voor "Naamgegevens kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82051" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens kind": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041')">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@value; allowed=('1', '2', '3', '4', '5')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@code; allowed=('1', '2', '3', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Geslacht (medische observatie)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050')">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortedatum": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@value]</assert>
         <assert test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">Foutieve informatie voor "Geboortedatum": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@value; type=t-datetime]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Perinatale sterfte (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279')">Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Perinatale sterfte (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind: == -->
         <assert test="count(voornamen) ge 0">Fout aantal voorkomens van "Voornamen": <value-of select="count(voornamen)"/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/*[not(self::voornamen)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82353')">Foutieve informatie voor "Voornamen": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82353" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voornamen": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82053')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82053" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam: == -->
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/*[not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82054')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82054" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82055')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82055" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
         <assert test="(count(perinatale_sterfteq) ge 0) and (count(perinatale_sterfteq) le 1)">Fout aantal voorkomens van "Perinatale sterfte?": <value-of select="count(perinatale_sterfteq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq]</assert>
         <assert test="(count(fase_perinatale_sterfte) ge 0) and (count(fase_perinatale_sterfte) le 1)">Fout aantal voorkomens van "Fase perinatale sterfte": <value-of select="count(fase_perinatale_sterfte)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/*[not(self::perinatale_sterfteq)][not(self::fase_perinatale_sterfte)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Perinatale sterfte?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280')">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Perinatale sterfte?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Perinatale sterfte?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Perinatale sterfte?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290')">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@code]</assert>
         <assert test="empty(@code) or (@code = ('237361005', '237362003', '276506001', 'NI'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@code; allowed=('237361005', '237362003', '276506001', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Fase perinatale sterfte": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Fase perinatale sterfte": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Fase perinatale sterfte": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus]</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur]</assert>
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min]</assert>
         <assert test="(count(vaginale_kunstverlossing_groep) ge 0) and (count(vaginale_kunstverlossing_groep) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing (groep)": <value-of select="count(vaginale_kunstverlossing_groep)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep]</assert>
         <assert test="(count(sectio_caesarea_group) ge 0) and (count(sectio_caesarea_group) le 1)">Fout aantal voorkomens van "Sectio caesarea (group)": <value-of select="count(sectio_caesarea_group)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group]</assert>
         <assert test="count(overige_interventies) ge 0">Fout aantal voorkomens van "Overige interventies": <value-of select="count(overige_interventies)"/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies]</assert>
         <assert test="(count(lichamelijk_onderzoek_kind) ge 0) and (count(lichamelijk_onderzoek_kind) le 1)">Fout aantal voorkomens van "Lichamelijk onderzoek kind": <value-of select="count(lichamelijk_onderzoek_kind)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind]</assert>
         <assert test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen?": <value-of select="count(congenitale_afwijkingenq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq]</assert>
         <assert test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)">Fout aantal voorkomens van "Congenitale afwijkingen (groep)": <value-of select="count(congenitale_afwijkingen_groep)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep]</assert>
         <assert test="(count(bijzonderheden_kind) ge 0) and (count(bijzonderheden_kind) le 1)">Fout aantal voorkomens van "Bijzonderheden kind": <value-of select="count(bijzonderheden_kind)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::apgarscore_na_5_min)][not(self::vaginale_kunstverlossing_groep)][not(self::sectio_caesarea_group)][not(self::overige_interventies)][not(self::lichamelijk_onderzoek_kind)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)][not(self::bijzonderheden_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Type partus": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Type partus": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Type partus": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code]</assert>
         <assert test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Type partus": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Type partus": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; max-inclusive=10]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Sectio caesarea (group)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Sectio caesarea (group)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219')">Foutieve informatie voor "Sectio caesarea (group)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Sectio caesarea (group)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Overige interventies": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240')">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Overige interventies": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@value; allowed=('1', '2', '3', '4')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Overige interventies": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@code]</assert>
         <assert test="empty(@code) or (@code = ('32189006', '237008007', '40792007', 'OTH'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@code; allowed=('32189006', '237008007', '40792007', 'OTH')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Overige interventies": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Overige interventies": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Overige interventies": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Overige interventies": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Lichamelijk onderzoek kind": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080')">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Congenitale afwijkingen (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081')">Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Congenitale afwijkingen (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Bijzonderheden kind": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bijzonderheden kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80790')">Foutieve informatie voor "Bijzonderheden kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80790" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Bijzonderheden kind": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Bijzonderheden kind": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
         <assert test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing": <value-of select="count(vaginale_kunstverlossing)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code]</assert>
         <assert test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
         <assert test="(count(beslismoment_sectio_caesarea) ge 0) and (count(beslismoment_sectio_caesarea) le 1)">Fout aantal voorkomens van "Beslismoment sectio caesarea": <value-of select="count(beslismoment_sectio_caesarea)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea]</assert>
         <assert test="(count(indicatie_sectio_caesarea) ge 0) and (count(indicatie_sectio_caesarea) le 1)">Fout aantal voorkomens van "Indicatie sectio caesarea": <value-of select="count(indicatie_sectio_caesarea)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/*[not(self::beslismoment_sectio_caesarea)][not(self::indicatie_sectio_caesarea)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225')">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@value; allowed=('1', '2', '3')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@code]</assert>
         <assert test="empty(@code) or (@code = ('2', '3', 'NI'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@code; allowed=('2', '3', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Beslismoment sectio caesarea": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230')">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@code]</assert>
         <assert test="empty(@code) or (@code = ('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@code; allowed=('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Indicatie sectio caesarea": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
         <assert test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)">Fout aantal voorkomens van "Geboortegewicht": <value-of select="count(geboortegewicht)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht]</assert>
         <assert test="(count(percentiel_van_het_geboortegewicht) ge 0) and (count(percentiel_van_het_geboortegewicht) le 1)">Fout aantal voorkomens van "Percentiel van het geboortegewicht": <value-of select="count(percentiel_van_het_geboortegewicht)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::percentiel_van_het_geboortegewicht)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Geboortegewicht": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortegewicht": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="exists(@unit)">Foutieve informatie voor "Geboortegewicht": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <assert test="empty(@unit) or (@unit eq 'gram')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80670')">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80670" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@code]</assert>
         <assert test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'NI'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@code; allowed=('1', '2', '3', '4', '5', '6', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Percentiel van het geboortegewicht": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
         <assert test="(count(specificatie_congenitale_afwijking_groep) ge 0) and (count(specificatie_congenitale_afwijking_groep) le 1)">Fout aantal voorkomens van "Specificatie congenitale afwijking (groep)": <value-of select="count(specificatie_congenitale_afwijking_groep)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep]</assert>
         <assert test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)">Fout aantal voorkomens van "Chromosomale afwijkingen?": <value-of select="count(chromosomale_afwijkingenq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq]</assert>
         <assert test="(count(specificatie_chromosomale_afwijking_groep) ge 0) and (count(specificatie_chromosomale_afwijking_groep) le 1)">Fout aantal voorkomens van "Specificatie chromosomale afwijking (groep)": <value-of select="count(specificatie_chromosomale_afwijking_groep)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/*[not(self::specificatie_congenitale_afwijking_groep)][not(self::chromosomale_afwijkingenq)][not(self::specificatie_chromosomale_afwijking_groep)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082')">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110')">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Chromosomale afwijkingen?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111')">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
         <assert test="(count(specificatie_congenitale_afwijking) ge 0) and (count(specificatie_congenitale_afwijking) le 1)">Fout aantal voorkomens van "Specificatie congenitale afwijking": <value-of select="count(specificatie_congenitale_afwijking)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/*[not(self::specificatie_congenitale_afwijking)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090')">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@code]</assert>
         <assert test="empty(@code) or (@code = ('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@code; allowed=('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Specificatie congenitale afwijking": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
         <assert test="(count(specificatie_chromosomale_afwijking) ge 0) and (count(specificatie_chromosomale_afwijking) le 1)">Fout aantal voorkomens van "Specificatie chromosomale afwijking": <value-of select="count(specificatie_chromosomale_afwijking)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/*[not(self::specificatie_chromosomale_afwijking)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120')">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@value]</assert>
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="exists(@code)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@code]</assert>
         <assert test="empty(@code) or (@code = ('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@code; allowed=('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="exists(@codeSystem)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@codeSystem]</assert>
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="exists(@displayName)">Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@displayName]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Specificatie chromosomale afwijking": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek: == -->
         <assert test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)">Fout aantal voorkomens van "Maternale onderzoeksgegevens": <value-of select="count(maternale_onderzoeksgegevens)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Maternale onderzoeksgegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
         <assert test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)">Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
         <assert test="(count(psie) ge 0) and (count(psie) le 1)">Fout aantal voorkomens van "PSIE": <value-of select="count(psie)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::psie)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "PSIE": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "PSIE": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949')">Foutieve informatie voor "PSIE": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "PSIE": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"><!-- == Check occurrences of children of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
         <assert test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)">Fout aantal voorkomens van "Irregulaire antistoffen?": <value-of select="count(irregulaire_antistoffenq)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie: == -->
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/*[not(self::irregulaire_antistoffenq)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq: == -->
   <pattern>
      <rule context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq"><!-- == Attribute "conceptId": == -->
         <assert test="exists(@conceptId)">Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId]</assert>
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812')">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:boolean)">Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@value; type=xs:boolean]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Irregulaire antistoffen?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/adaextension == -->
</schema>
