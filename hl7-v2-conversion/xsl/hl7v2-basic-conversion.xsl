<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:bc-hl7v2c="https://babyconnect.org/ns/hl7v2-conversion" xmlns:local="#local.uf3_5pv_jhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Simple driver stylesheet for the basic conversion of a HL&V2 message to the basic structured format.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="../xslmod/hl7v2-conversion.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-hl7v2" as="xs:string" required="yes"/>

  <!-- ================================================================== -->

  <xsl:template match="/">
    <xsl:call-template name="bc-hl7v2c:hl7v2-to-structured">
      <xsl:with-param name="dref-hl7v2" select="$dref-hl7v2"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
