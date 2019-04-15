<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:bc-hl7v2c="https://babyconnect.org/ns/hl7v2-conversion" xmlns:local="#local.uf3_5pv_jhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Simple driver stylesheet for the basic conversion of a HL7V2 message to the basic structured format.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:include href="../xslmod/hl7v2-conversion.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-hl7v2" as="xs:string" required="yes"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="hl7v2-structured" as="element(hl7v2-structured)">
    <xsl:call-template name="bc-hl7v2c:hl7v2-to-structured">
      <xsl:with-param name="dref-hl7v2" select="$dref-hl7v2"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- ================================================================== -->

  <xsl:template match="*[exists(hl7v2-value)]">

    <xsl:variable name="values" as="xs:string*">
      <xsl:for-each select="hl7v2-value">
        <xsl:variable name="elm" as="element(subcomponent)?" select="local:get-subcomponent-element(.)"/>
        <xsl:choose>
          <xsl:when test="string($elm) ne ''">
           <xsl:sequence select="string($elm)"/>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="exists($values)">
        <xsl:copy>
          <xsl:attribute name="value" select="string-join($values, ' ')"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <!-- Discard element -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  
  <xsl:template match="comment()"/>
  
  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:function name="local:get-subcomponent-element" as="element(subcomponent)?">
    <xsl:param name="base-elm" as="element()"/>

    <!-- Gather data: -->
    <xsl:variable name="segment-name" as="xs:string" select="$base-elm/@segment-name"/>
    <xsl:variable name="first-field" as="xs:string" select="string($base-elm/@first-field)"/>
    <xsl:variable name="fieldgroup-index" as="xs:integer" select="local:get-int($base-elm/@fieldgroup-index)"/>
    <xsl:variable name="field-index" as="xs:integer" select="local:get-int($base-elm/@field-index)"/>
    <xsl:variable name="component-index" as="xs:integer" select="local:get-int($base-elm/@component-index)"/>
    <xsl:variable name="subcomponent-index" as="xs:integer" select="local:get-int($base-elm/@subcomponent-index)"/>
    <xsl:variable name="required" as="xs:boolean" select="xs:boolean(($base-elm/@required, true())[1])"/>

    <!-- Get and check the element: -->
    <xsl:variable name="elm" as="element(subcomponent)?"
      select="$hl7v2-structured/segment[@name eq $segment-name][string(fieldgroup[1]) eq $first-field]/
        fieldgroup[$fieldgroup-index]/field[$field-index]/component[$component-index]/subcomponent[$subcomponent-index]"/>
    <xsl:if test="$required and (string($elm) eq '')">
      <xsl:sequence select="error((), 'Required HL7V2 value not found: ' || local:atts2str($base-elm/@*))"/>
    </xsl:if>
    <xsl:sequence select="$elm"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-int" as="xs:integer">
    <xsl:param name="att" as="attribute()?"/>
    <xsl:param name="default" as="xs:integer"/>
    <xsl:sequence select="xs:integer(($att, $default)[1])"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-int" as="xs:integer">
    <xsl:param name="att" as="attribute()?"/>
    <xsl:sequence select="local:get-int($att, 1)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:atts2str" as="xs:string">
    <xsl:param name="atts" as="attribute()*"/>

    <xsl:variable name="att-strings" as="xs:string*">
      <xsl:for-each select="$atts">
        <xsl:sequence select="local-name(.) || '=&quot;' || string(.) || '&quot;'"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:sequence select="string-join($att-strings, ' ')"/>
  </xsl:function>

</xsl:stylesheet>
