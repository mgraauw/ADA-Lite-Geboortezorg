<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:ada="http://www.art-decor.org/ada" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
  <!-- ================================================================== -->
  <!--
    This stylesheet transforms an ADA Receive Transaction Dataset (shortened to rtd) into an
    empty example file.
  -->
  <!-- ================================================================== -->

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <!-- ================================================================== -->

  <xsl:template match="/dataset">
    <xsl:element name="{@shortName}">
      <xsl:attribute name="transactionRef">
        <xsl:value-of select="@transactionId"/>
      </xsl:attribute>
      <xsl:copy-of select="/ada/project/@versionDate"/>
      <xsl:apply-templates select="concept[@type]"/>
    </xsl:element>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="concept">
    <xsl:apply-templates select="." mode="doConceptContent"/>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="concept[@type = 'group']" mode="doConceptContent">
    <xsl:element name="{implementation/@shortName}">
      <xsl:apply-templates select="concept[@type]"/>
    </xsl:element>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="concept[@type = 'item']" mode="doConceptContent">
    <xsl:element name="{implementation/@shortName}">
      <xsl:attribute name="value"/>
    </xsl:element>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="text() | @*"/>

</xsl:stylesheet>
