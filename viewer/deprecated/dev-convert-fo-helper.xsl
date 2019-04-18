<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:local="#local.zxw_n15_lhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
      Converts Marc's XSL-FO sheet into something easier 
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:mode name="mode-in-cell" on-no-match="shallow-copy"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->



  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->



  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <dev-convert-fo-helper in="{base-uri(/)}">
      <xsl:apply-templates select="*"/>
    </dev-convert-fo-helper>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="fo:table[@font-size eq 'small'][empty(@color)]">
    <h1 style="color: {.//fo:block/@background-color};">
      <xsl:value-of select="normalize-space(.)"/>
    </h1>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="fo:table[@font-size eq 'x-small']">

    <xsl:variable name="widths" as="xs:integer*">
      <xsl:for-each select="fo:table-column">
        <xsl:sequence select="xs:integer(substring-before(@column-width, 'mm'))"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="total-width" as="xs:integer" select="sum($widths)"/>
    <xsl:comment> == {string-join($widths, ';')} == </xsl:comment>

    <table>
      <!-- Header: -->
      <tr>
        <xsl:for-each select="fo:table-header/fo:table-row/fo:table-cell">
          <xsl:variable name="index" as="xs:integer" select="position()"/>
          <xsl:variable name="width" as="xs:integer?" select="$widths[$index]"/>
          <th>
            <xsl:if test="exists($widths) and (position() ne last())">
              <xsl:attribute name="width" select="floor(($width div $total-width)*100) || '%'"/>
            </xsl:if>
            <xsl:value-of select="fo:block"/>
          </th>
        </xsl:for-each>
      </tr>
      <!-- Rest -->

      <xsl:for-each select=".//fo:table-body//fo:table-row">
        <tr>
          <xsl:for-each select=".//fo:table-cell">
            <td>
              <xsl:apply-templates select="*" mode="mode-in-cell"/>
            </td>
          </xsl:for-each>

        </tr>
      </xsl:for-each>


    </table>

  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template match="xsl:for-each" mode="mode-in-cell">
    <parent id-suffix="{local:get-id-suffix(@select)}">
      <xsl:apply-templates select="*" mode="#current"/>
    </parent>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="xsl:value-of" mode="mode-in-cell" >
    <xsl:variable name="id-suffix" as="xs:string" select="local:get-id-suffix(@select)"/>
    <child id-suffix="{$id-suffix}">
      {{local:get-value-by-id('{$id-suffix}')}}
    </child>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-id-suffix" as="xs:string">
    <xsl:param name="in" as="xs:string"/>

    <xsl:variable name="id" as="xs:string" select="replace($in, '^.+?''([0-9]+(\.[0-9]+)+)''.+?$', '$1')"/>
    <xsl:variable name="ids" as="xs:string*" select="tokenize($id, '\.')"/>
    <xsl:sequence select="'.6.' || $ids[last()]"/>
  </xsl:function>

  <!-- ================================================================== -->

  <xsl:template match="*" priority="-1000" mode="#all">
    <xsl:apply-templates select="*" mode="#current"/>
  </xsl:template>


  <!-- ================================================================== -->
  <!-- SUPPORT: -->



</xsl:stylesheet>
