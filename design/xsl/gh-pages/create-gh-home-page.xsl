<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xtlc="http://www.xtpxlib.nl/ns/common"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.pt1_wxl_dhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Creates the GitHub pages home page
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="no" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="../../../../../xtpxlib/common/xslmod/dref.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-in" as="xs:string" required="yes"/>
  <xsl:param name="difflist" as="xs:string" required="yes"/>
  <xsl:param name="sitegen" as="xs:string" required="yes"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="nl" as="xs:string" select="'&#10;'"/>

  <!-- Create the links: -->
  <xsl:variable name="sitespecs" as="element(filecopy)*" select="doc($sitegen)/sitegen/filecopy[@linkname][@destination]"/>
  <xsl:variable name="link-text-parts" as="xs:string*">
    <xsl:for-each select="$sitespecs">
      <xsl:call-template name="create-link-entry">
        <xsl:with-param name="name" select="@linkname"/>
        <xsl:with-param name="link" select="xtlc:dref-concat((xtlc:dref-path(@destination), xtlc:dref-name-noext(@destination)))"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="link-text" as="xs:string" select="fn:string-join($link-text-parts)"/>

  <!-- Create the diff links: -->
  <xsl:variable name="diffspecs" as="element(diff)*" select="doc($difflist)/difflist/diff[@older][@newer][@output]"/>
  <xsl:variable name="diff-md-text-parts" as="xs:string*">
    <xsl:for-each select="$diffspecs">
      <xsl:call-template name="create-link-entry">
        <xsl:with-param name="name" select="(@description, @output)[1]"/>
        <xsl:with-param name="link" select="'diffs/' || @output || '.html'"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="diff-md-text" as="xs:string" select="fn:string-join($diff-md-text-parts)"/>



  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">

    <xsl:variable name="original" as="xs:string" select="fn:unparsed-text($dref-in)"/>
    <xsl:variable name="new-text" as="xs:string"
      select="
        replace($original, '\[diffs\]', $diff-md-text) =>
        replace('\[links\]', $link-text)
      "/>

    <!-- Remark: We output as text (in the surrounding XProc pipeline), so root element doesn't matter: -->
    <null>
      <xsl:value-of select="$new-text"/>
    </null>

  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="create-link-entry" as="xs:string">
    <xsl:param name="name" as="xs:string" required="yes"/>
    <xsl:param name="link" as="xs:string" required="yes"/>

    <xsl:variable name="parts" as="xs:string*">
      <!-- [Kernset versie 2.2 en 2.3](diffs/diff-kernset-22-23.html) -->
      <xsl:sequence select="'* ['"/>
      <xsl:sequence select="$name"/>
      <xsl:sequence select="']('"/>
      <xsl:sequence select="$link"/>
      <xsl:sequence select="')'"/>
      <xsl:sequence select="$nl"/>
    </xsl:variable>
    <xsl:sequence select="fn:string-join($parts)"/>
  </xsl:template>

</xsl:stylesheet>
