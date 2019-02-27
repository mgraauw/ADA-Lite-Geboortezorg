<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.cvh_lb3_vgb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       This stylesheet converts an XML document from the ADAD Lite format into full ADA XML.
       For this it uses the definitions from a Retrieve Transaction Dataset (shortened to rtd here). 
       
       The input is assumed to be validated already. Therefore, when an error condition occurs, only a comment is output, no 
       error is raised.
       
       It is part of the conversion stylesheets in the Babyconnect project/program.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-rtd" as="xs:string" required="yes"/>
  <!-- Document reference to the Retrieve Transaction Dataset document (with root element <dataset>). -->

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="rtd-root" as="element(dataset)" select="doc($dref-rtd)/*"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="/*" priority="10">
    <xsl:element name="{$rtd-root/@shortName}">
      <xsl:copy select="@transactionRef"/>
      <xsl:copy select="$rtd-root/@transactionEffectiveDate"/>
      <xsl:copy select="/*/@versionDate"/>
      <!-- TODO: The prefix should come from the retrieve transaction dataset also, now fixed: -->
      <xsl:attribute name="prefix" select="'peri20-'"/>

      <xsl:comment> == ADA full format generated from lite format {current-dateTime()} == </xsl:comment>

      <xsl:apply-templates select="*">
        <xsl:with-param name="concept-root" as="element()" select="$rtd-root" tunnel="true"/>
        <xsl:with-param name="parent-name-set" as="xs:string*" select="local-name(.)" tunnel="true"/>
      </xsl:apply-templates>

    </xsl:element>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="*">
    <xsl:param name="concept-root" as="element()" required="true" tunnel="true"/>
    <xsl:param name="parent-name-set" as="xs:string*" required="true" tunnel="true"/>

    <xsl:variable name="elm-name" as="xs:string" select="local-name(.)"/>
    <xsl:variable name="full-elm-path" as="xs:string" select="string-join(($parent-name-set, $elm-name), '/')"/>
    
    <!-- Find the right concept child and pre-flight check it:: -->
    <xsl:variable name="concept" as="element(concept)?" select="($concept-root/concept[@shortName eq $elm-name])[1]"/>

    <xsl:choose>
      <xsl:when test="exists($concept)">
        <xsl:element name="{$elm-name}">
          <xsl:attribute name="conceptId" select="$concept/@id"/>

          <!-- Get the value for this concept:  -->
          <xsl:variable name="concept-type" as="xs:string" select="$concept/@type"/>
          <xsl:choose>
            <xsl:when test="($concept-type eq 'item') and exists(@value)">
              <xsl:call-template name="handle-concept-value">
                <xsl:with-param name="concept" select="$concept"/>
                <xsl:with-param name="value" select="@value"/>
                <xsl:with-param name="full-elm-path" select="$full-elm-path"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="$concept-type eq 'group'">
              <!-- Just dive deeper -->
            </xsl:when>
            <xsl:otherwise>
              <!-- Since we assume the input is already validated this should not happen. Just output the value and a comment for now: -->
              <xsl:copy select="@value"/>
              <xsl:comment> == *** Unrecognized concept type/value combination for {$full-elm-path} == </xsl:comment>
            </xsl:otherwise>
          </xsl:choose>

          <!-- Now dive into the child elements: -->
          <xsl:apply-templates select="*" mode="#current">
            <xsl:with-param name="concept-root" as="element()" select="$concept" tunnel="true"/>
            <xsl:with-param name="parent-name-set" as="xs:string*" select="($parent-name-set, $elm-name)" tunnel="true"/>
          </xsl:apply-templates>

        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment> == *** No concept found for element {$full-elm-path} in {$dref-rtd} == </xsl:comment>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:template name="handle-concept-value">
    <xsl:param name="concept" as="element(concept)" required="yes"/>
    <xsl:param name="value" as="xs:string" required="yes"/>
    <xsl:param name="full-elm-path" as="xs:string" required="yes"/>

    <xsl:variable name="value-domain" as="element(valueDomain)" select="$concept/valueDomain"/>
    <xsl:variable name="value-domain-type" as="xs:string" select="$value-domain/@type"/>
    
    <xsl:choose>
      
      <!-- Code: Lookup the value in the code list of the concept. The actual value is the @localId. -->
      <xsl:when test="$value-domain-type eq 'code'">
        <xsl:variable name="code-element" as="element()?" select="($concept/valueSet/conceptList/*[@code eq $value])[1]"/>
        <xsl:if test="empty($code-element)">
          <xsl:attribute name="value" select="$value"/>
          <xsl:comment> == Code {$value} not found for {$full-elm-path} == </xsl:comment>
        </xsl:if>
        <xsl:attribute name="value" select="$code-element/@localId"/>
        <xsl:copy-of select="($code-element/@code, $code-element/@codeSystem, $code-element/@displayName)"/>
      </xsl:when>

      <!-- Quantity: Just output the value and a unit (if any): -->
      <xsl:when test="$value-domain-type eq 'quantity'">
        <xsl:attribute name="value" select="$value"/>
        <xsl:copy select="$value-domain/property/@unit"/>
      </xsl:when>
      
      <!-- Anything else, just output the value as-si: -->
      <xsl:otherwise>
        <xsl:attribute name="value" select="$value"/>
      </xsl:otherwise>
      
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
