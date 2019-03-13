<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg">
  <!-- 
    Converts a full blown ADA Retrieve Transaction Dataset file into its light version
  
    Author: Marc de Graauw, 2013. 
    Adapted by: Erik Siegel, 2019
    Copyright: to be decided, until then all rights reserved 
  -->

  <xsl:output method="xml" indent="yes"/>

  <xsl:include href="lib/xsl-common.xsl"/>

  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="name desc"/>

  <!-- ================================================================== -->

  <xsl:template match="/*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>

      <xsl:comment> == Generated lite version of specification from full version for <xsl:value-of select="/*/@shortName"/> == </xsl:comment>
      <xsl:comment> == Source: <xsl:value-of select="bc-alg:dref-alg-path(base-uri(/))"/> == </xsl:comment>
      <xsl:comment> == Generator: <xsl:value-of select="bc-alg:dref-alg-path(static-base-uri())"/> == </xsl:comment>

      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="implementation | community | inherit | terminologyAssociation"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="@iddisplay | @versionLabel"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="valueDomain">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="* except conceptList"/>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="valueSet">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="name | desc"/>
      <conceptList>
        <xsl:for-each select="conceptList/*">
          <xsl:copy>
            <xsl:copy-of select="(@localId, @code, @codeSystem, @displayName)"/>
            <xsl:attribute name="value" select="@code"/>
          </xsl:copy>
        </xsl:for-each>
      </conceptList>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
