<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://purl.oclc.org/dsdl/schematron"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.mfj_4hd_wgb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Transforms the output of ada-rtd2ada-schema-simple.xsl into a Schematron file.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->



  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <!-- Value used to signify a @maxOccurs="unbounded" situation: -->
  <xsl:variable name="max-occurs-unbounded" as="xs:integer" select="-1"/>

  <!-- Diagnostic message identifiers: -->
  <xsl:variable name="diagnostic-element-count-invalid" as="xs:string" select="'diagnostic-element-count-invalid'"/>

  <!-- Schematron variable names used to pass information to the diagnostic messages: -->
  <xsl:variable name="schematron-variable-expected-count" as="xs:string" select="'expected-count'"/>
  <xsl:variable name="schematron-variable-element-name" as="xs:string" select="'element-name'"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">

    <!-- Setup the Schematron: -->
    <schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2" xml:lang="nl-NL">
      <xsl:comment> == Schematron generated {current-dateTime()} == </xsl:comment>

      <xsl:call-template name="handle-element-definitions">
        <xsl:with-param name="element-definitions" select="/*/xs:element[1]"/>
      </xsl:call-template>
    </schema>

  </xsl:template>

  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:template name="handle-element-definitions">
    <xsl:param name="element-definitions" as="element(xs:element)+" required="true"/>
    <xsl:param name="xpath-base" as="xs:string" required="false" select="'/'"/>

    <!-- Create a pattern for each element definition that tests its occurrences: -->
    <pattern>
      <rule context="{$xpath-base}">
        <xsl:comment> == Check occurrences of children of {$xpath-base}: == </xsl:comment>
        <xsl:for-each select="$element-definitions">
          <xsl:variable name="element-name" as="xs:string" select="string(@name)"/>
          <xsl:variable name="min-occurs" as="xs:integer" select="xs:integer((@minOccurs, 1)[1])"/>
          <xsl:variable name="max-occurs" as="xs:integer"
            select="if (@maxOccurs eq 'unbounded') then $max-occurs-unbounded else xs:integer((@maxOccurs, if ($min-occurs eq 0) then 1 else $min-occurs)[1])"/>
          <xsl:variable name="expected-count-string" as="xs:string">
            <xsl:choose>
              <xsl:when test="$min-occurs eq $max-occurs">
                <xsl:sequence select="string($min-occurs)"/>
              </xsl:when>
              <xsl:when test="$max-occurs eq $max-occurs-unbounded">
                <xsl:sequence select="$min-occurs || ' of meer'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="string($min-occurs) || '..' || string($max-occurs)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="assert-expression" as="xs:string">
            <xsl:choose>
              <xsl:when test="$min-occurs eq $max-occurs">
                <xsl:sequence select="'count(' || $element-name || ') eq ' || $min-occurs"/>
              </xsl:when>
              <xsl:when test="$max-occurs eq $max-occurs-unbounded">
                <xsl:sequence select="'count(' || $element-name || ') ge ' || $min-occurs"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence
                  select="'(count(' || $element-name || ') ge ' || $min-occurs || ') and (count(' || $element-name || ') le ' || $max-occurs || ')'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="name" as="xs:string" select="local:get-name(., $xpath-base)"/>
          <assert test="{$assert-expression}">Fout aantal voorkomens van {local:get-name(., $xpath-base)}: <value-of select="count({$element-name})"/>
            (verwacht: {$expected-count-string})</assert>
        </xsl:for-each>
      </rule>
    </pattern>

    <!-- Create a pattern that tests for unexpected elements: -->
    <pattern>
      <xsl:comment> == Check for any unexpected elements in {$xpath-base}: == </xsl:comment>
      <xsl:variable name="context-expression-components" as="xs:string+">
        <xsl:for-each select="$element-definitions">
          <xsl:sequence select="'[not(self::' || @name || ')]'"/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:variable name="context-expression" as="xs:string"
        select="local:xpath-concat($xpath-base, '*') || string-join($context-expression-components)"/>
      <rule context="{$context-expression}">
        <report test="true()">Ongeldige informatie aangetroffen: <value-of select="local-name(.)"/> (element {$xpath-base}{if
          (ends-with($xpath-base, '/')) then () else '/'}<value-of select="name(.)"/>)</report>
      </rule>
    </pattern>


    <!-- Do all the sub-element definitions:  -->
    <xsl:for-each select="$element-definitions">
      <xsl:variable name="new-xpath-base" as="xs:string" select="$xpath-base || (if ($xpath-base eq '/') then () else '/') || @name"/>
      <xsl:variable name="sub-element-definitions" as="element(xs:element)*" select="xs:complexType/xs:sequence/xs:element"/>
      <xsl:if test="exists($sub-element-definitions)">
        <xsl:call-template name="handle-element-definitions">
          <xsl:with-param name="element-definitions" select="$sub-element-definitions"/>
          <xsl:with-param name="xpath-base" select="$new-xpath-base"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-name" as="xs:string">
    <xsl:param name="elm" as="element()"/>
    <xsl:param name="xpath-base" as="xs:string?"/>

    <xsl:variable name="name" as="xs:string" select="string(($elm/xs:annotation/xs:documentation[@source eq 'name'])[1])"/>

    <xsl:choose>
      <xsl:when test="$name eq ''">
        <xsl:sequence select="($elm/@name, $elm/@value)[1]"/>
      </xsl:when>
      <xsl:when test="$elm/self::xs:element">
        <xsl:sequence select="$name || ' (element ' || local:xpath-concat($xpath-base, $elm/@name)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:xpath-concat" as="xs:string">
    <xsl:param name="base" as="xs:string"/>
    <xsl:param name="remainder" as="xs:string"/>
    <xsl:sequence select="if (ends-with($base, '/')) then $base || $remainder else $base || '/' || $remainder"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:apos" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="'''' || $in || ''''"/>
  </xsl:function>

</xsl:stylesheet>
