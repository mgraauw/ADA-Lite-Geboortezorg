<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="#local.r2k_3c4_jhb"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="no" encoding="UTF-8"/>

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:param name="dref-schema" as="xs:string" required="no" select="'../../../ada-lite/schemas-simple-lite/verloskundig-dossier-23.simple.lite.xsd'"/>


  <!-- ================================================================== -->

  <xsl:template match="/">
    <verloskundig_dossier_23 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="{$dref-schema}"
      transactionRef="2.16.840.1.113883.2.4.3.11.60.90.77.4.2467">
      <xsl:apply-templates select="/adaxml/data[1]/verwijzing_regulier_bericht[1]/*"/>
    </verloskundig_dossier_23>
  </xsl:template>


  <!-- ================================================================== -->
  <!-- CHANGES: -->

  <!-- Remove these attributes. When we convert this ADA-lite version to ADA-full, they will re-appear again and with the right values! -->
  <xsl:template match="@conceptId | @codeSystem | @displayName | @unit"/>


  <!-- Elements not in verloskundig_dossier 23: -->
  <xsl:variable name="elements-to-remove" as="xs:string+"
    select="(
    'zorgverlening',  
    'obstetrische_anamnese_gegroepeerd_per_voorgaande_zwangerschap',  
    'geloofsovertuiging',  
    'autoimmuun_aandoeningq',  
    'cardiovasculaire_aandoeningq',  
    'oncologische_aandoeningq',  
    'urogenitale_aandoeningq',  
    'schildklier_aandoeningq',  
    'neurologische_aandoeningq',  
    'infectieziekteq',  
    'mdl_aandoeningq',  
    'anemieq',  
    'longaandoeningq',  
    'gynaecologische_aandoeningq',  
    'orthopedische_afwijkingq',  
    'operatieq',  
    'stollingsprobleemq',  
    'gewicht_voor_de_zwangerschap',  
    'proteinurie_meting_obv',  
    'interventies_begin_baring_groep',  
    'bijstimulatie_toegediendq',  
    'geslacht_medische_observatie',
    'percentiel_lengte',
    'apgarscore_na_1_min',
    'apgarscore_na_5_min',
    'apgarscore_na_10_min',
    'percentiel_schedelomtrek',
    'placenta_afwijkingq',
    'combinatietest',
    'diagnose_postpartum',
    'eiceldonatie_toegepastq',
    'niet_ingedaalde_testes'
  )"/>
  <xsl:template match="*[local-name() = $elements-to-remove]" priority="100"/>

  <!-- Anything that has no value (and no children) must go away: -->
  <xsl:template match="*[empty(*)][empty(@value)]" priority="110"/>

  <!-- On elements with both a code and a value, use the code as value: -->
  <xsl:template match="*[exists(@code) and exists(@value)]" priority="-10">
    <xsl:copy copy-namespaces="false">
      <xsl:attribute name="value" select="@code"/>
    </xsl:copy>
  </xsl:template>

  <!-- The following elements all use different coding systems, so we fill in something valid (whether this makes sense or not): -->
  <xsl:variable name="fixed-value-elements" as="map(*)"
    select="map{
    'rhesus_c_factor': 733119003,
    'a_terme_datum_obv': 31521000146100,
    'foliumzuur_gebruik': 29761000146100,
    'voorgenomen_voeding': 169642000,
    'hartactie_op_basis_van': 387672006,
    'fundusstand': 21851000146109,
    'regelmaat_hartslag': 289443009,
    'frequentie_hartslag': 278084002,
    'indaling': 163532003,
    'navelstreng_vaten': 29691000146104,
    'reden_antenatale_betrokkenheid_kinderarts': 169222003,
    'compleetheid_vliezen': 249181009,
    'wijze_van_hechten': 29701000146104,
    'overig_trauma': 237090005,
    'type_partus': 10,
    'positie_portio': 289783000,
    'reden_betrokkenheid': 161838002,
    'type_anticonceptie': 10114008,
    'vloeien': 289577001,
    'episiotomieruptuur': 271618001,
    'geassisteerde_conceptie': 236896006,
    'periode': 31761000146102,
    'ketonen': 29781000146108
  }"/>
  <xsl:template match="*[map:contains($fixed-value-elements, local-name(.))][exists(@value)]" priority="10">
    <xsl:copy copy-namespaces="false">
      <xsl:attribute name="value" select="$fixed-value-elements(local-name(.))"/>
    </xsl:copy>
  </xsl:template>

  <!-- Booleans: -->
  <xsl:template match="@value[. eq 'ja']">
    <xsl:attribute name="{name(.)}" select="'true'"/>
  </xsl:template>
  <xsl:template match="@value[. eq 'nee']">
    <xsl:attribute name="{name(.)}" select="'false'"/>
  </xsl:template>

  <xsl:template match="lichamelijk_onderzoek_kind">
    <xsl:copy copy-namespaces="false">
      <xsl:apply-templates select="../(apgarscore_na_1_min | apgarscore_na_5_min | apgarscore_na_10_min)"/>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>


  <!-- Weird changes because of weird mandatory elements... -->
  <xsl:template match="drugsgebruikq">
    <xsl:next-match/>
    <soort_drugs value="NI"/>
  </xsl:template>

  <xsl:template match="voornemens">
    <trisomie_in_de_anamneseq value="false"/>
    <xsl:copy copy-namespaces="false">
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="counseling_prenatale_screening_en_prenatale_diagnostiek">
    <xsl:copy copy-namespaces="false">
      <xsl:apply-templates select="counseling_prenatale_gewenst"/>
      <xsl:if test="empty(reden_verzending)">
        <reden_verzending value="24w"/>
      </xsl:if>
      <xsl:apply-templates select="* except counseling_prenatale_gewenst"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="foetusspecifieke_onderzoeksgegevens">
    <xsl:copy copy-namespaces="false">
      <xsl:if test="empty(foetus_identificatie)">
        <foetus_identificatie value="1"/>
      </xsl:if>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>

  <!-- The definition for medisch_onderzoek is a mess: -->
  <xsl:template match="medisch_onderzoek">
    <xsl:copy copy-namespaces="false">
      <xsl:apply-templates select="onderzoek_identificatie"/>
      <xsl:apply-templates select="datum_onderzoek"/>
      <xsl:apply-templates select="naam_uitvoerder_onderzoek"/>
      <xsl:apply-templates select="zorgverlenertype"/>
      <xsl:apply-templates select="zwangerschapsduur_op_datum_onderzoek"/>
      <xsl:apply-templates select="onderzoektype_jonge_zwangerschapsecho"/>
      <onderzoektype_ntmeting value="?"/>
      <onderzoektype_seo value="?"/>
      <onderzoektype_guo value="?"/>
      <onderzoektype_kansbepaling_combinatietest value="?"/>
      <seotype value="1"/>
      <conclusie_seo value="1"/>
      <advies_seo value="1"/>
      <xsl:apply-templates select="conclusie_a_terme_datum"/>
      <xsl:apply-templates select="uitslag_screening"/>
      <xsl:apply-templates select="foetusspecifieke_onderzoeksgegevens"/>
      <xsl:apply-templates select="maternale_onderzoeksgegevens"/>
      <xsl:apply-templates select="adaextension"/>
    </xsl:copy>
  </xsl:template>

  <!-- Renames: -->
  <xsl:template match="actuele_aantal_foetus">
    <hoeveelling>
      <xsl:copy-of select="@value"/>
    </hoeveelling>
  </xsl:template>

  <xsl:template match="hbsag">
    <hbs_ag value="165806002"/>
  </xsl:template>

  <xsl:template match="*[ends-with(local-name(), '_igg')]">
    <xsl:element name="{substring-before(local-name(), '_igg')}_ig_g">
      <xsl:apply-templates select="@* | *"/>
    </xsl:element>
  </xsl:template>
  
  
  <xsl:template match="*[ends-with(local-name(), '_igm')]">
    <xsl:element name="{substring-before(local-name(), '_igm')}_ig_m">
      <xsl:apply-templates select="@* | *"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="rubella_igg">
    <rubella_ig_g>
      <xsl:copy-of select="@value"/>
    </rubella_ig_g>
  </xsl:template>

  <xsl:template match="prenatale_controle/oedeem">
    <ernst_oedeem value="6736007"/>
  </xsl:template>

  <xsl:template match="manlijk">
    <mannelijk>
      <xsl:apply-templates select="*"/>
    </mannelijk>
  </xsl:template>




</xsl:stylesheet>
