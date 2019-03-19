<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.pt1_wxl_dhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Creates the GitHub pages home page
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="no" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-in" as="xs:string" required="yes"/>
  <xsl:param name="difflist" as="xs:string" required="yes"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="original" as="xs:string" select="fn:unparsed-text($dref-in)"/>

  <xsl:variable name="diffspecs" as="element(diff)*" select="doc($difflist)/difflist/diff[@older][@newer][@output]"/>
  <xsl:variable name="nl" as="xs:string" select="'&#10;'"/>
  <xsl:variable name="diff-md-text-parts" as="xs:string*">
    <!-- [Kernset versie 2.2 en 2.3](diffs/diff-kernset-22-23.html) -->
    <xsl:for-each select="$diffspecs">
      <xsl:sequence select="'* ['"/>
      <xsl:sequence select="(@description, @output)[1]"/>
      <xsl:sequence select="']('"/>
      <xsl:sequence select="'diffs/' || @output || '.html'"/>
      <xsl:sequence select="')'"/>
      <xsl:sequence select="$nl"/>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="diff-md-text" as="xs:string" select="fn:string-join($diff-md-text-parts)"/>
  
  <xsl:variable name="new-text" as="xs:string" select="replace($original, '\[diffs\]', $diff-md-text)"/>
  
  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <null>
      <xsl:value-of select="$new-text"/>
    </null>
  </xsl:template>

</xsl:stylesheet>
