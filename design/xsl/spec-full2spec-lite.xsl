<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- 
    Converts a full blown ADA Retrieve Transaction Dataset file into its light version
  
    Author: Marc de Graauw 2013
    Copyright: to be decided, until then all rights reserved 
  -->

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="name desc"/>

  <!-- ================================================================== -->

  <xsl:template match="implementation | community | inherit | terminologyAssociation"/>

  <xsl:template match="@iddisplay | @versionLabel"/>

  <xsl:template match="valueDomain">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="(* except conceptList)"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="valueSet">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="name | desc"/>
      <xsl:variable name="uniqueCodes" select="count(distinct-values(.//@code)) = count(.//@code)"/>
      <conceptList>
        <xsl:if test="not($uniqueCodes)">
          <xsl:comment> *** Values are not equal to code in this valueset! *** </xsl:comment>
        </xsl:if>
        <xsl:for-each select="conceptList/*">
          <xsl:copy>
            <xsl:attribute name="localId">
              <xsl:choose>
                <xsl:when test="$uniqueCodes">
                  <xsl:value-of select="@code"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@localId"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="value">
              <xsl:choose>
                <xsl:when test="$uniqueCodes">
                  <xsl:value-of select="@code"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@localId"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:copy-of select="@code | @codeSystem | @displayName"/>
          </xsl:copy>
        </xsl:for-each>
      </conceptList>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
