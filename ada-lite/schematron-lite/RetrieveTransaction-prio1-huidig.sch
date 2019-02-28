<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:local="#local"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        queryBinding="xslt2"
        xml:lang="nl-NL">
   <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
   <ns uri="#local" prefix="local"/>
   <xsl:function name="local:decimal-convert" as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>
   <pattern>
      <rule context="/"><!-- == Check occurrences of children of /: == -->
         <assert test="count(prio1_huidig) eq 1">Fout aantal voorkomens van "Prio1 huidig": <value-of select="count(prio1_huidig)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig: == -->
   <pattern>
      <rule context="/prio1_huidig"><!-- == Attribute "transactionRef": == -->
         <assert test="exists(@transactionRef)">Foutieve informatie voor "Prio1 huidig": Attribuut "transactionRef" ontbreekt</assert>
         <assert test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft een onjuist formaat</assert>
         <assert test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2453')">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionRef"/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2453"</assert>
         <!-- == Attribute "transactionEffectiveDate": == -->
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat</assert>
         <assert test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2018-12-17T15:21:25')">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@transactionEffectiveDate"/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2018-12-17T15:21:25"</assert>
         <!-- == Attribute "versionDate": == -->
         <assert test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">Foutieve informatie voor "Prio1 huidig": De waarde "<value-of select="@versionDate"/>" voor attribuut "versionDate" heeft een onjuist formaat</assert>
         <!-- == Attribute "prefix": == -->
         <assert test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">Foutieve informatie voor "Prio1 huidig": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig"><!-- == Check occurrences of children of /prio1_huidig: == -->
         <assert test="(count(zorgverlenerzorginstelling) ge 0) and (count(zorgverlenerzorginstelling) le 1)">Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <value-of select="count(zorgverlenerzorginstelling)"/> (verwacht: 0..1)</assert>
         <assert test="count(vrouw) eq 1">Fout aantal voorkomens van "Vrouw": <value-of select="count(vrouw)"/> (verwacht: 1)</assert>
         <assert test="(count(zwangerschap) ge 0) and (count(zwangerschap) le 1)">Fout aantal voorkomens van "Zwangerschap": <value-of select="count(zwangerschap)"/> (verwacht: 0..1)</assert>
         <assert test="count(medisch_onderzoek) ge 0">Fout aantal voorkomens van "Medisch onderzoek": <value-of select="count(medisch_onderzoek)"/> (verwacht: 0 of meer)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig: == -->
      <rule context="/prio1_huidig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::medisch_onderzoek)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">Foutieve informatie voor "Vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">Foutieve informatie voor "Zwangerschap": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')">Foutieve informatie voor "Medisch onderzoek": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling"><!-- == Check occurrences of children of /prio1_huidig/zorgverlenerzorginstelling: == -->
         <assert test="(count(zorgverlener) ge 0) and (count(zorgverlener) le 1)">Fout aantal voorkomens van "Zorgverlener": <value-of select="count(zorgverlener)"/> (verwacht: 0..1)</assert>
         <assert test="count(zorginstelling) eq 1">Fout aantal voorkomens van "Zorginstelling": <value-of select="count(zorginstelling)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zorgverlenerzorginstelling: == -->
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorgverlener: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001')">Foutieve informatie voor "Zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">Foutieve informatie voor "Zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"><!-- == Check occurrences of children of /prio1_huidig/zorgverlenerzorginstelling/zorgverlener: == -->
         <assert test="(count(naam_zorgverlener) ge 0) and (count(naam_zorgverlener) le 1)">Fout aantal voorkomens van "Naam zorgverlener": <value-of select="count(naam_zorgverlener)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zorgverlenerzorginstelling/zorgverlener: == -->
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006')">Foutieve informatie voor "Naam zorgverlener": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorgverlener": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"><!-- == Check occurrences of children of /prio1_huidig/zorgverlenerzorginstelling/zorginstelling: == -->
         <assert test="count(naam_zorginstelling) eq 1">Fout aantal voorkomens van "Naam zorginstelling": <value-of select="count(naam_zorginstelling)"/> (verwacht: 1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zorgverlenerzorginstelling/zorginstelling: == -->
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling: == -->
   <pattern>
      <rule context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026')">Foutieve informatie voor "Naam zorginstelling": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/vrouw"><!-- == Check occurrences of children of /prio1_huidig/vrouw: == -->
         <assert test="count(burgerservicenummer) eq 1">Fout aantal voorkomens van "Burgerservicenummer": <value-of select="count(burgerservicenummer)"/> (verwacht: 1)</assert>
         <assert test="(count(naamgegevens) ge 0) and (count(naamgegevens) le 1)">Fout aantal voorkomens van "Naamgegevens": <value-of select="count(naamgegevens)"/> (verwacht: 0..1)</assert>
         <assert test="(count(anamnese) ge 0) and (count(anamnese) le 1)">Fout aantal voorkomens van "Anamnese": <value-of select="count(anamnese)"/> (verwacht: 0..1)</assert>
         <assert test="(count(bloedgroep_vrouw) ge 0) and (count(bloedgroep_vrouw) le 1)">Fout aantal voorkomens van "Bloedgroep vrouw": <value-of select="count(bloedgroep_vrouw)"/> (verwacht: 0..1)</assert>
         <assert test="(count(rhesus_d_factor_vrouw) ge 0) and (count(rhesus_d_factor_vrouw) le 1)">Fout aantal voorkomens van "Rhesus D Factor vrouw": <value-of select="count(rhesus_d_factor_vrouw)"/> (verwacht: 0..1)</assert>
         <assert test="(count(rhesus_c_factor) ge 0) and (count(rhesus_c_factor) le 1)">Fout aantal voorkomens van "Rhesus c Factor": <value-of select="count(rhesus_c_factor)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/vrouw: == -->
      <rule context="/prio1_huidig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::anamnese)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/burgerservicenummer: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/burgerservicenummer"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (string-length(@value) ge 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minstens 9 karakters bevatten</assert>
         <assert test="empty(@value) or (string-length(@value) le 9)">Foutieve informatie voor "Burgerservicenummer": De waarde "<value-of select="@value"/>" voor attribuut "value" mag hoogstens 9 karakters bevatten</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035')">Foutieve informatie voor "Naamgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/anamnese: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/anamnese"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811')">Foutieve informatie voor "Anamnese": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Anamnese": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/bloedgroep_vrouw: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/bloedgroep_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810')">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Blood group A (finding)', 'Blood group B (finding)', 'Blood group AB (finding)', 'Blood group O (finding)', 'Onbekend', 'Geen informatie'))">Foutieve informatie voor "Bloedgroep vrouw": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Bloedgroep vrouw": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/rhesus_d_factor_vrouw: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/rhesus_d_factor_vrouw"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811')">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3', '4'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('165747007', '165746003', 'UNK', 'NI'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Rh D Positief', 'Rh D Negatief', 'onbekend', 'geen informatie'))">Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Rhesus D Factor vrouw": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/rhesus_c_factor: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/rhesus_c_factor"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816')">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2', '3'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('733120009', '733119003', 'NI'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Rhc positive (finding)', 'Rhc negative (finding)', 'Geen informatie'))">Foutieve informatie voor "Rhesus c Factor": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Rhesus c Factor": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens"><!-- == Check occurrences of children of /prio1_huidig/vrouw/naamgegevens: == -->
         <assert test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">Fout aantal voorkomens van "Roepnaam": <value-of select="count(roepnaam)"/> (verwacht: 0..1)</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/vrouw/naamgegevens: == -->
      <rule context="/prio1_huidig/vrouw/naamgegevens/*[not(self::roepnaam)][not(self::achternaam)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/roepnaam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/roepnaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360')">Foutieve informatie voor "Roepnaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam"><!-- == Check occurrences of children of /prio1_huidig/vrouw/naamgegevens/achternaam: == -->
         <assert test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">Fout aantal voorkomens van "Soort naam": <value-of select="count(soort_naam)"/> (verwacht: 0..1)</assert>
         <assert test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">Fout aantal voorkomens van "Voorvoegsel": <value-of select="count(voorvoegsel)"/> (verwacht: 0..1)</assert>
         <assert test="(count(achternaam) ge 0) and (count(achternaam) le 1)">Fout aantal voorkomens van "Achternaam": <value-of select="count(achternaam)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/vrouw/naamgegevens/achternaam: == -->
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362')">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362"</assert>
         <!-- == Attribute "value": == -->
         <assert test="empty(@value) or (@value = ('1', '2'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@value"/>" voor attribuut "value" is onjuist</assert>
         <!-- == Attribute "code": == -->
         <assert test="empty(@code) or (@code = ('BR', 'SP'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@code"/>" voor attribuut "code" is onjuist</assert>
         <!-- == Attribute "codeSystem": == -->
         <assert test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@codeSystem"/>" voor attribuut "codeSystem" is onjuist</assert>
         <!-- == Attribute "displayName": == -->
         <assert test="empty(@displayName) or (@displayName = ('Geslachtsnaam', 'Geslachtsnaam partner'))">Foutieve informatie voor "Soort naam": De waarde "<value-of select="@displayName"/>" voor attribuut "displayName" is onjuist</assert>
         <assert test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @xsi:*))">Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363')">Foutieve informatie voor "Voorvoegsel": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/vrouw/naamgegevens/achternaam/achternaam: == -->
   <pattern>
      <rule context="/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043')">Foutieve informatie voor "Achternaam": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/zwangerschap"><!-- == Check occurrences of children of /prio1_huidig/zwangerschap: == -->
         <assert test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">Fout aantal voorkomens van "Graviditeit": <value-of select="count(graviditeit)"/> (verwacht: 0..1)</assert>
         <assert test="(count(pariteit) ge 0) and (count(pariteit) le 1)">Fout aantal voorkomens van "Pariteit": <value-of select="count(pariteit)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/zwangerschap: == -->
      <rule context="/prio1_huidig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap/graviditeit: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/graviditeit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 1)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 1 zijn</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 75)">Foutieve informatie voor "Graviditeit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 75 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/zwangerschap/pariteit: == -->
   <pattern>
      <rule context="/prio1_huidig/zwangerschap/pariteit"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153')">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Pariteit": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) le 30)">Foutieve informatie voor "Pariteit": De waarde "<value-of select="@value"/>" voor attribuut "value" mag maximaal 30 zijn</assert>
         <assert test="empty(@* except (@conceptId, @value, @xsi:*))">Foutieve informatie voor "Pariteit": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek"><!-- == Check occurrences of children of /prio1_huidig/medisch_onderzoek: == -->
         <assert test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)">Fout aantal voorkomens van "Maternale onderzoeksgegevens": <value-of select="count(maternale_onderzoeksgegevens)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/medisch_onderzoek: == -->
      <rule context="/prio1_huidig/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')">Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"><!-- == Check occurrences of children of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
         <assert test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)">Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens: == -->
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959"</assert>
         <assert test="empty(@* except (@conceptId, @xsi:*))">Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"><!-- == Check occurrences of children of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
         <assert test="(count(hb) ge 0) and (count(hb) le 1)">Fout aantal voorkomens van "Hb": <value-of select="count(hb)"/> (verwacht: 0..1)</assert>
      </rule>
   </pattern>
   <pattern><!-- == Check for any unexpected elements in /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken: == -->
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)]">
         <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/>
         </report>
      </rule>
   </pattern>
   <!-- == Check attributes of /prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb: == -->
   <pattern>
      <rule context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"><!-- == Attribute "conceptId": == -->
         <assert test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">Foutieve informatie voor "Hb": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft een onjuist formaat</assert>
         <assert test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814')">Foutieve informatie voor "Hb": De waarde "<value-of select="@conceptId"/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814"</assert>
         <!-- == Attribute "value": == -->
         <assert test="exists(@value)">Foutieve informatie voor "Hb": Attribuut "value" ontbreekt</assert>
         <assert test="empty(@value) or (@value castable as xs:decimal)">Foutieve informatie voor "Hb": De waarde "<value-of select="@value"/>" voor attribuut "value" heeft een onjuist formaat</assert>
         <assert test="empty(@value) or (local:decimal-convert(@value) ge 0)">Foutieve informatie voor "Hb": De waarde "<value-of select="@value"/>" voor attribuut "value" moet minimaal 0 zijn</assert>
         <!-- == Attribute "unit": == -->
         <assert test="empty(@unit) or (@unit eq 'mmol/L')">Foutieve informatie voor "Hb": De waarde "<value-of select="@unit"/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "mmol/L"</assert>
         <assert test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">Foutieve informatie voor "Hb": Ongeldige attributen aangetroffen</assert>
      </rule>
   </pattern>
</schema>
