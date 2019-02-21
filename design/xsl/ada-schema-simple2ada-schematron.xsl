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
    <xsl:for-each select="$element-definitions">
      <pattern>

        <xsl:variable name="xpath-to-element" as="xs:string" select="$xpath-base || (if ($xpath-base eq '/') then () else '/') || @name"/>
        <xsl:variable name="min-occurs" as="xs:integer" select="xs:integer((@minOccurs, 1)[1])"/>
        <xsl:variable name="max-occurs" as="xs:integer"
          select="if (@maxOccurs eq 'unbounded') then $max-occurs-unbounded else xs:integer((@maxOccurs, if ($min-occurs eq 0) then 1 else $min-occurs)[1])"/>
        <xsl:variable name="expected-count-string" as="xs:string">
          <xsl:choose>
            <xsl:when test="$min-occurs eq $max-occurs">
              <xsl:sequence select="string($min-occurs)"/>
            </xsl:when>
            <xsl:when test="string($min-occurs) || ' of meer'">
              <xsl:sequence select="'count(.) ge ' || $min-occurs"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="string($min-occurs) || '..' || string($max-occurs)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="assert-expression" as="xs:string">
          <xsl:choose>
            <xsl:when test="$min-occurs eq $max-occurs">
              <xsl:sequence select="'count(.) eq ' || $min-occurs"/>
            </xsl:when>
            <xsl:when test="$max-occurs eq $max-occurs-unbounded">
              <xsl:sequence select="'count(.) ge ' || $min-occurs"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="'(count(.) ge ' || $min-occurs || ') and (count(.) le ' || $max-occurs || ')'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="name" as="xs:string" select="local:get-name(., $xpath-base)"/>

        <xsl:comment> == Check occurrences of {$name} (must be {$expected-count-string}): == </xsl:comment>
        <rule context="{$xpath-to-element}">
          <assert test="{$assert-expression}">Fout aantal voorkomens van {local:get-name(., $xpath-base)}: <value-of select="count(.)"/> (verwacht:
            {$expected-count-string})</assert>
        </rule>

      </pattern>
    </xsl:for-each>

    <!-- Create a pattern to check that all mandatory elements are there: -->
    <xsl:variable name="mandatory-elements" as="element(xs:element)*"
      select="$element-definitions[empty(@minOccurs) or (xs:integer(@minOccurs) ne 0)]"/>
    <xsl:if test="exists($mandatory-elements)">
      <pattern>
        <xsl:comment> == Check for missing mandatory elements in {$xpath-base}: == </xsl:comment>
        <rule context="{$xpath-base}">
          <xsl:for-each select="$mandatory-elements">
            <assert test="exists({@name})">Missende informatie: {local:get-name(., $xpath-base)}</assert>
          </xsl:for-each>
        </rule>
      </pattern>
    </xsl:if>

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
        <xsl:sequence select="$name || ' (element ' || $xpath-base || (if ($xpath-base eq '/') then () else '/') || $elm/@name || ')'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:apos" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="'''' || $in || ''''"/>
  </xsl:function>

</xsl:stylesheet>
