<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.xqg_kfw_xgb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Input to this stylesheet is a full directory listing of the files in the ADA-Lite-Gebeoortezorg repo (as generated
       by the XProc step xtlc:recursive-directory-list).
       
       Output is a list of actions. The encompassing XProc then performs these actions.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="no" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="ada-lite-directory" as="element(c:directory)" select="/c:directory/c:directory[@name eq 'ada-lite']"/>
  <xsl:variable name="design-directory" as="element(c:directory)" select="/c:directory/c:directory[@name eq 'design']"/>

  <!-- Gather information about all the rtd file. We need them more than once... -->
  <xsl:variable name="specs-full-subdir-name" as="xs:string" select="'specs-full'"/>
  <xsl:variable name="specs-full-directory" as="element(c:directory)" select="$design-directory/c:directory[@name eq $specs-full-subdir-name]"/>
  <xsl:variable name="specs-full-directory-name" as="xs:string" select="$specs-full-directory/@xml:base"/>
  <xsl:variable name="specs-full-files" as="element(c:file)+" select="$specs-full-directory/c:file"/>

  <!-- Create a map that maps the transaction ids onto the right rtd file: -->
  <xsl:variable name="transactionid2rtd" as="map(xs:string, xs:string)">
    <xsl:map>
      <xsl:for-each select="$specs-full-files">
        <xsl:variable name="fullname" as="xs:string" select="$specs-full-directory-name || '/' || @name"/>
        <xsl:variable name="transaction-id" as="xs:string" select="doc($fullname)/*/@transactionId"/>
        <xsl:map-entry key="$transaction-id" select="$fullname"/>
      </xsl:for-each>
    </xsl:map>
  </xsl:variable>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <actions timestamp="{fn:current-dateTime()}" root="{/*/@xml:base}">
      <xsl:call-template name="generate-actions-specs-full2specs-lite"/>
      <xsl:call-template name="generate-actions-examples-lite2examples-full"/>
      <!-- TBD: Generate the examples-empty -->
      <!-- TBD: Generate the schematrons lite -->
      <!-- TBD: Generate the schematrons full -->
      <!-- TBD: Generate the schemas (lite/full)? -->
      <!-- TBD: generate the validations we can do! -->
    </actions>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- ACTION GENERATION: -->

  <xsl:template name="generate-actions-specs-full2specs-lite">

    <xsl:variable name="specs-lite-subdir-name" as="xs:string" select="'specs-lite'"/>

    <xsl:comment> == specs-full2specs-lite == </xsl:comment>
    <xsl:call-template name="generate-action-remove-dir">
      <xsl:with-param name="dir" select="$ada-lite-directory/c:directory[@name eq $specs-lite-subdir-name]/@xml:base"/>
    </xsl:call-template>

    <xsl:for-each select="$specs-full-files">
      <xsl:variable name="filename" as="xs:string" select="@name"/>
      <specs-full2specs-lite in="{$specs-full-directory-name}/{$filename}" out="{$ada-lite-directory/@xml:base}{$specs-lite-subdir-name}/{$filename}"
      />
    </xsl:for-each>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="generate-actions-examples-lite2examples-full">

    <xsl:variable name="examples-lite-subdir-name" as="xs:string" select="'examples-lite'"/>
    <xsl:variable name="examples-full-subdir-name" as="xs:string" select="'examples-full'"/>

    <xsl:comment> == examples-full2examples-lite == </xsl:comment>
    <xsl:call-template name="generate-action-remove-dir">
      <xsl:with-param name="dir" select="$ada-lite-directory/c:directory[@name eq $examples-full-subdir-name]/@xml:base"/>
    </xsl:call-template>

    <xsl:variable name="examples-lite-directory" as="element(c:directory)"
      select="$ada-lite-directory/c:directory[@name eq $examples-lite-subdir-name]"/>
    <xsl:variable name="examples-lite-files" as="element(c:file)+" select="$examples-lite-directory/c:file"/>

    <xsl:for-each select="$examples-lite-files">
      <xsl:variable name="filename" as="xs:string" select="@name"/>
      <xsl:variable name="full-input-filename" as="xs:string" select="$ada-lite-directory/@xml:base || $examples-lite-subdir-name || '/' || $filename"/>
      <xsl:variable name="transaction-ref" as="xs:string" select="doc($full-input-filename)/*/@transactionRef"/>
      <xsl:variable name="rtd" as="xs:string?" select="$transactionid2rtd($transaction-ref)"/>
      <xsl:if test="empty($rtd)">
        <xsl:sequence select="error((), 'No full specs rtd found for transaction id ' || $transaction-ref)"/>
      </xsl:if>
      <examples-lite2examples-full in="{$full-input-filename}"
        out="{$ada-lite-directory/@xml:base}{$examples-full-subdir-name}/{$filename}" rtd="{$rtd}"/>
    </xsl:for-each>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="generate-action-remove-dir">
    <xsl:param name="dir" as="xs:string?" required="yes"/>

    <xsl:if test="exists($dir)">
      <remove-dir path="{$dir}"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
