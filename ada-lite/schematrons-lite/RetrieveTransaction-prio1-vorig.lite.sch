<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:local="#local"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        queryBinding="xslt2"
        xml:lang="nl-NL">
<!--
This program is free software; you can redistribute it and/or modify it under the terms 
of the GNU Affero General Public License as published by the Free Software Foundation; 
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU Affero General Public Licensefor more details.

See http://www.gnu.org/licenses/
-->
<!-- == Generated Schematron file for validating ADA Lite prio1_vorig documents == --><!-- == Source: design/specs-full/RetrieveTransaction-prio1-vorig.xml == --><!-- == Generator(s): design/xsl/ada-rtd2ada-schema-simple.xsl; design/xsl/ada-schema-simple2ada-schematron.xsl == -->   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(prio1_vorig) eq 1">Fout aantal voorkomens van "Prio1 vorig": <value-of select="count(prio1_vorig)"/> (verwacht: 1) [/prio1_vorig]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig: == -->
   <pattern>
      <rule context="/prio1_vorig"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Prio1 vorig": Attribuut "transactionRef" ontbreekt [/prio1_vorig/@transactionRef]</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prio1 vorig": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_vorig/@transactionRef; type=t-id]</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2456')">Foutieve informatie voor "Prio1 vorig": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2456" [/prio1_vorig/@transactionRef]</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 vorig": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_vorig/@transactionEffectiveDate; type=xs:dateTime]</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2019-02-20T11:05:00')">Foutieve informatie voor "Prio1 vorig": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2019-02-20T11:05:00" [/prio1_vorig/@transactionEffectiveDate]</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 vorig": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_vorig/@versionDate; type=xs:dateTime]</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Prio1 vorig": Ongeldige attributen aangetroffen [/prio1_vorig; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_vorig"><!-- == Check occurrences of children of /prio1_vorig: == -->
         <assert test="(count(zorgverlenerzorginstelling) ge 0) and (count(zorgverlenerzorginstelling) le 1)">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling]</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1) [/prio1_vorig/vrouw]</assert>
         <assert test="(count(zwangerschap) ge 0) and (count(zwangerschap) le 1)">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap]</assert>
         <assert test="(count(bevalling) ge 0) and (count(bevalling) le 1)">Fout aantal voorkomens van "Bevalling": <value-of select="count(bevalling)"/> (verwacht: 0..1) [/prio1_vorig/bevalling]</assert>
         <assert test="(count(uitkomst_per_kind) ge 0) and (count(uitkomst_per_kind) le 1)">Fout aantal voorkomens van "Uitkomst (per kind)": <value-of select="count(uitkomst_per_kind)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig: == -->
      <rule context="/prio1_vorig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/prio1_vorig/zorgverlenerzorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/prio1_vorig/vrouw/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/prio1_vorig/zwangerschap/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/bevalling: == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6')">Foutieve informatie voor "Bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6" [/prio1_vorig/bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7')">Foutieve informatie voor "Uitkomst (per kind)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7" [/prio1_vorig/uitkomst_per_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /prio1_vorig/zorgverlenerzorginstelling: == -->
         <assert test="(count(zorgverlener) ge 0) and (count(zorgverlener) le 1)">Fout aantal voorkomens van "Zorgverlener": <value-of select="count(zorgverlener)"/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener]</assert>
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1) [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/zorgverlenerzorginstelling: == -->
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/zorgverlenerzorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zorgverlenerzorginstelling/zorgverlener: == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001" [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/zorgverlenerzorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener"><!-- == Check occurrences of children of /prio1_vorig/zorgverlenerzorginstelling/zorgverlener: == -->
         <assert test="(count(naam_zorgverlener) ge 0) and (count(naam_zorgverlener) le 1)">Fout aantal voorkomens van "Naam zorgverlener": <value-of select="count(naam_zorgverlener)"/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/zorgverlenerzorginstelling/zorgverlener: == -->
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener: == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006" [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorgverlener": Attribuut "value" ontbreekt [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/zorgverlenerzorginstelling/zorgverlener/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /prio1_vorig/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="count(naam_zorginstelling) eq 1">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 1) [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026" [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/zorgverlenerzorginstelling/zorginstelling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw"><!-- == Check occurrences of children of /prio1_vorig/vrouw: == -->
         <assert test="count(burgerservicenummer) eq 1">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 1) [/prio1_vorig/vrouw/burgerservicenummer]</assert>
         <assert test="(count(naamgegevens) ge 0) and (count(naamgegevens) le 1)">Fout aantal voorkomens van "Naamgegevens": <value-of select="count(naamgegevens)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/vrouw: == -->
      <rule context="/prio1_vorig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/vrouw/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/burgerservicenummer/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/prio1_vorig/vrouw/burgerservicenummer/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/burgerservicenummer/@value]</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_vorig/vrouw/burgerservicenummer/@value; min-length=9]</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_vorig/vrouw/burgerservicenummer/@value; max-length=9]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/naamgegevens: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035" [/prio1_vorig/vrouw/naamgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/vrouw/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens"><!-- == Check occurrences of children of /prio1_vorig/vrouw/naamgegevens: == -->
         <assert test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">Fout aantal voorkomens van "Roepnaam": <value-of select="count(roepnaam)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/roepnaam]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/vrouw/naamgegevens: == -->
      <rule context="/prio1_vorig/vrouw/naamgegevens/*[not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/vrouw/naamgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/naamgegevens/roepnaam: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens/roepnaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360" [/prio1_vorig/vrouw/naamgegevens/roepnaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/naamgegevens/roepnaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/naamgegevens/achternaam: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361" [/prio1_vorig/vrouw/naamgegevens/achternaam/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/vrouw/naamgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens/achternaam"><!-- == Check occurrences of children of /prio1_vorig/vrouw/naamgegevens/achternaam: == -->
         <assert test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">Fout aantal voorkomens van "Soort naam": <value-of select="count(soort_naam)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam]</assert>
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel]</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/vrouw/naamgegevens/achternaam: == -->
      <rule context="/prio1_vorig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/vrouw/naamgegevens/achternaam/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362" [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Geslachtsnaam', 'Geslachtsnaam partner'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@displayName; allowed=('Geslachtsnaam', 'Geslachtsnaam partner')]</assert>
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('geslachtsnaam', 'geslachtsnaam_partner'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@enum; allowed=('geslachtsnaam', 'geslachtsnaam_partner')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363" [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/vrouw/naamgegevens/achternaam/achternaam: == -->
   <pattern>
      <rule context="/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043" [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/vrouw/naamgegevens/achternaam/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap"><!-- == Check occurrences of children of /prio1_vorig/zwangerschap: == -->
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/graviditeit]</assert>
         <assert test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)">Fout aantal voorkomens van "Pariteit (vóór deze zwangerschap)": <value-of select="count(pariteit_voor_deze_zwangerschap)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap]</assert>
         <assert test="count(a_terme_datum_groep) eq 1">Fout aantal voorkomens van "A terme datum (groep)": <value-of select="count(a_terme_datum_groep)"/> (verwacht: 1) [/prio1_vorig/zwangerschap/a_terme_datum_groep]</assert>
         <assert test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Wijze einde zwangerschap": <value-of select="count(wijze_einde_zwangerschap)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap]</assert>
         <assert test="(count(datum_einde_zwangerschap) ge 0) and (count(datum_einde_zwangerschap) le 1)">Fout aantal voorkomens van "Datum einde zwangerschap": <value-of select="count(datum_einde_zwangerschap)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/datum_einde_zwangerschap]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/zwangerschap: == -->
      <rule context="/prio1_vorig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::a_terme_datum_groep)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/zwangerschap/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/graviditeit/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/prio1_vorig/zwangerschap/graviditeit/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/graviditeit/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/zwangerschap/graviditeit/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_vorig/zwangerschap/graviditeit/@value; min-inclusive=1]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_vorig/zwangerschap/graviditeit/@value; max-inclusive=75]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/graviditeit; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150')">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150" [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value; max-inclusive=30]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap/a_terme_datum_groep: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/a_terme_datum_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "A terme datum (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/a_terme_datum_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029')">Foutieve informatie voor "A terme datum (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029" [/prio1_vorig/zwangerschap/a_terme_datum_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "A terme datum (groep)": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/a_terme_datum_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap/wijze_einde_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/wijze_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625')">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625" [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@displayName; allowed=('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie')]</assert>
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('partus', 'miskraam', 'spontaan', 'medicamenteus', 'instrumenteel', 'apla', 'medicamenteus', 'instrumenteel', 'eug__behandeld', 'partiele_mola__behandeld', 'geen_informatie'))">Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@enum; allowed=('partus', 'miskraam', 'spontaan', 'medicamenteus', 'instrumenteel', 'apla', 'medicamenteus', 'instrumenteel', 'eug__behandeld', 'partiele_mola__behandeld', 'geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap/datum_einde_zwangerschap: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/datum_einde_zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/datum_einde_zwangerschap/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540')">Foutieve informatie voor "Datum einde zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540" [/prio1_vorig/zwangerschap/datum_einde_zwangerschap/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Datum einde zwangerschap": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/datum_einde_zwangerschap/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Datum einde zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/datum_einde_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/zwangerschap/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/a_terme_datum_groep"><!-- == Check occurrences of children of /prio1_vorig/zwangerschap/a_terme_datum_groep: == -->
         <assert test="(count(a_terme_datum) ge 0) and (count(a_terme_datum) le 1)">Fout aantal voorkomens van "A terme datum": <value-of select="count(a_terme_datum)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/a_terme_datum_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/zwangerschap/a_terme_datum_groep: == -->
      <rule context="/prio1_vorig/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/zwangerschap/a_terme_datum_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum: == -->
   <pattern>
      <rule context="/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030')">Foutieve informatie voor "A terme datum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030" [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "A terme datum": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum/@value]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "A terme datum": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/zwangerschap/a_terme_datum_groep/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling"><!-- == Check occurrences of children of /prio1_vorig/bevalling: == -->
         <assert test="(count(diagnose_bevalling) ge 0) and (count(diagnose_bevalling) le 1)">Fout aantal voorkomens van "Diagnose bevalling": <value-of select="count(diagnose_bevalling)"/> (verwacht: 0..1) [/prio1_vorig/bevalling/diagnose_bevalling]</assert>
         <assert test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">Fout aantal voorkomens van "Hoeveelheid bloedverlies": <value-of select="count(hoeveelheid_bloedverlies)"/> (verwacht: 0..1) [/prio1_vorig/bevalling/hoeveelheid_bloedverlies]</assert>
         <assert test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)">Fout aantal voorkomens van "Conditie perineum postpartum": <value-of select="count(conditie_perineum_postpartum)"/> (verwacht: 0..1) [/prio1_vorig/bevalling/conditie_perineum_postpartum]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/bevalling: == -->
      <rule context="/prio1_vorig/bevalling/*[not(self::diagnose_bevalling)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/bevalling/diagnose_bevalling: == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling/diagnose_bevalling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/diagnose_bevalling/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291')">Foutieve informatie voor "Diagnose bevalling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291" [/prio1_vorig/bevalling/diagnose_bevalling/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Diagnose bevalling": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/diagnose_bevalling; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/bevalling/hoeveelheid_bloedverlies: == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling/hoeveelheid_bloedverlies"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640" [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "value" ontbreekt [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'ml')">Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/bevalling/conditie_perineum_postpartum: == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling/conditie_perineum_postpartum"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/conditie_perineum_postpartum/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673')">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673" [/prio1_vorig/bevalling/conditie_perineum_postpartum/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@value; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@code; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Perineum intact  (finding)', 'First degree perineal tear during delivery - delivered (disorder)', 'Second degree perineal tear during delivery - delivered  (disorder)', 'Third degree perineal tear during delivery - delivered  (disorder)', 'Type 3a third degree laceration of perineum  (disorder)', 'Type 3b third degree laceration of perineum (disorder)', 'Type 3c third degree laceration of perineum (disorder)', 'Fourth degree perineal tear during delivery - delivered  (disorder)', 'Episiotomy wound  (morphologic abnormality)', 'Anders', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@displayName; allowed=('Perineum intact  (finding)', 'First degree perineal tear during delivery - delivered (disorder)', 'Second degree perineal tear during delivery - delivered  (disorder)', 'Third degree perineal tear during delivery - delivered  (disorder)', 'Type 3a third degree laceration of perineum  (disorder)', 'Type 3b third degree laceration of perineum (disorder)', 'Type 3c third degree laceration of perineum (disorder)', 'Fourth degree perineal tear during delivery - delivered  (disorder)', 'Episiotomy wound  (morphologic abnormality)', 'Anders', 'Onbekend', 'Geen informatie')]</assert>
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('perineum_intact_finding', 'first_degree_perineal_tear_during_delivery__delivered_disorder', 'second_degree_perineal_tear_during_delivery__delivered_disorder', 'third_degree_perineal_tear_during_delivery__delivered_disorder', 'type_3a_third_degree_laceration_of_perineum_disorder', 'type_3b_third_degree_laceration_of_perineum_disorder', 'type_3c_third_degree_laceration_of_perineum_disorder', 'fourth_degree_perineal_tear_during_delivery__delivered_disorder', 'episiotomy_wound_morphologic_abnormality', 'anders', 'onbekend', 'geen_informatie'))">Foutieve informatie voor "Conditie perineum postpartum": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@enum; allowed=('perineum_intact_finding', 'first_degree_perineal_tear_during_delivery__delivered_disorder', 'second_degree_perineal_tear_during_delivery__delivered_disorder', 'third_degree_perineal_tear_during_delivery__delivered_disorder', 'type_3a_third_degree_laceration_of_perineum_disorder', 'type_3b_third_degree_laceration_of_perineum_disorder', 'type_3c_third_degree_laceration_of_perineum_disorder', 'fourth_degree_perineal_tear_during_delivery__delivered_disorder', 'episiotomy_wound_morphologic_abnormality', 'anders', 'onbekend', 'geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/conditie_perineum_postpartum; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/bevalling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling/diagnose_bevalling"><!-- == Check occurrences of children of /prio1_vorig/bevalling/diagnose_bevalling: == -->
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/bevalling/diagnose_bevalling/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/bevalling/diagnose_bevalling: == -->
      <rule context="/prio1_vorig/bevalling/diagnose_bevalling/*[not(self::zwangerschapsduur)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/bevalling/diagnose_bevalling/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur: == -->
   <pattern>
      <rule context="/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382" [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/bevalling/diagnose_bevalling/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind"><!-- == Check occurrences of children of /prio1_vorig/uitkomst_per_kind: == -->
         <assert test="(count(baring) ge 0) and (count(baring) le 1)">Fout aantal voorkomens van "Baring": <value-of select="count(baring)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/uitkomst_per_kind: == -->
      <rule context="/prio1_vorig/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/uitkomst_per_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002')">Foutieve informatie voor "Baring": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002" [/prio1_vorig/uitkomst_per_kind/baring/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/uitkomst_per_kind/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring"><!-- == Check occurrences of children of /prio1_vorig/uitkomst_per_kind/baring: == -->
         <assert test="(count(kindspecifieke_maternale_gegevens) ge 0) and (count(kindspecifieke_maternale_gegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke maternale gegevens": <value-of select="count(kindspecifieke_maternale_gegevens)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens]</assert>
         <assert test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)">Fout aantal voorkomens van "Kindspecifieke uitkomstgegevens": <value-of select="count(kindspecifieke_uitkomstgegevens)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/uitkomst_per_kind/baring: == -->
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/*[not(self::kindspecifieke_maternale_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/uitkomst_per_kind/baring/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71')">Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke maternale gegevens": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72')">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/uitkomst_per_kind/baring/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"><!-- == Check occurrences of children of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens: == -->
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/*[not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"><!-- == Check occurrences of children of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
         <assert test="(count(type_partus) ge 0) and (count(type_partus) le 1)">Fout aantal voorkomens van "Type partus": <value-of select="count(type_partus)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus]</assert>
         <assert test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">Fout aantal voorkomens van "Zwangerschapsduur": <value-of select="count(zwangerschapsduur)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur]</assert>
         <assert test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">Fout aantal voorkomens van "Apgarscore na 5 min.": <value-of select="count(apgarscore_na_5_min)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min]</assert>
         <assert test="(count(vaginale_kunstverlossing_groep) ge 0) and (count(vaginale_kunstverlossing_groep) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing (groep)": <value-of select="count(vaginale_kunstverlossing_groep)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep]</assert>
         <assert test="(count(lichamelijk_onderzoek_kind) ge 0) and (count(lichamelijk_onderzoek_kind) le 1)">Fout aantal voorkomens van "Lichamelijk onderzoek kind": <value-of select="count(lichamelijk_onderzoek_kind)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens: == -->
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::apgarscore_na_5_min)][not(self::vaginale_kunstverlossing_groep)][not(self::lichamelijk_onderzoek_kind)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626')">Foutieve informatie voor "Type partus": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@displayName; allowed=('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie')]</assert>
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('delivery_normal_finding', 'assisted_delivery_of_fetus_finding', 'cesarean_delivery__delivered_finding', 'delivery_by_elective_cesarean_section_finding', 'delivery_by_emergency_cesarean_section_finding', 'legally_induced_abortion_disorder', 'onbekend', 'geen_informatie'))">Foutieve informatie voor "Type partus": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@enum; allowed=('delivery_normal_finding', 'assisted_delivery_of_fetus_finding', 'cesarean_delivery__delivered_finding', 'delivery_by_elective_cesarean_section_finding', 'delivery_by_emergency_cesarean_section_finding', 'legally_induced_abortion_disorder', 'onbekend', 'geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'd')">Foutieve informatie voor "Zwangerschapsduur": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071')">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "value" ontbreekt [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; min-inclusive=0]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 10)">Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 10 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; max-inclusive=10]</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min; allowed=(@conceptId, @value, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189')">Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766')">Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind; allowed=(@conceptId, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"><!-- == Check occurrences of children of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
         <assert test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)">Fout aantal voorkomens van "Vaginale kunstverlossing": <value-of select="count(vaginale_kunstverlossing)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep: == -->
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190')">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Forceps delivery (procedure)', 'Delivery by vacuum extraction (procedure)', 'Obstetrical version with extraction (procedure)', 'Partial breech extraction (procedure)', 'Total breech extraction (procedure)', 'anders', 'geen informatie'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@displayName; allowed=('Forceps delivery (procedure)', 'Delivery by vacuum extraction (procedure)', 'Obstetrical version with extraction (procedure)', 'Partial breech extraction (procedure)', 'Total breech extraction (procedure)', 'anders', 'geen informatie')]</assert>
         <!-- == Attribute "enum": == -->
         <assert test="empty(@enum) or (@enum = ('forceps_delivery_procedure', 'delivery_by_vacuum_extraction_procedure', 'obstetrical_version_with_extraction_procedure', 'partial_breech_extraction_procedure', 'total_breech_extraction_procedure', 'anders', 'geen_informatie'))">Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<value-of select="@enum"/>" voor attribuut "enum" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@enum; allowed=('forceps_delivery_procedure', 'delivery_by_vacuum_extraction_procedure', 'obstetrical_version_with_extraction_procedure', 'partial_breech_extraction_procedure', 'total_breech_extraction_procedure', 'anders', 'geen_informatie')]</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"><!-- == Check occurrences of children of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
         <assert test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)">Fout aantal voorkomens van "Geboortegewicht": <value-of select="count(geboortegewicht)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht]</assert>
         <assert test="(count(adaextension) ge 0) and (count(adaextension) le 1)">Fout aantal voorkomens van "adaextension": <value-of select="count(adaextension)"/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension]</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind: == -->
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::adaextension)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/<value-of select="name(.)"/>]</report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht: == -->
   <pattern>
      <rule context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId; type=t-id]</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Geboortegewicht": Attribuut "value" ontbreekt [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value]</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; type=xs:decimal]</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; min-inclusive=0]</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'gram')">Foutieve informatie voor "Geboortegewicht": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht; allowed=(@conceptId, @value, @unit, @xsi:*)]</assert>
      </rule>
   </pattern>
   <!-- == Any attributes allowed on /prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension == -->
</schema>
