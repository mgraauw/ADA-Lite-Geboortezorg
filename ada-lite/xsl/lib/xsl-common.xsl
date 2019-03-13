<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.tcl_gls_bhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!--	
       Module with code that is shared between some of the stylesheets for ADA-lite-Geboortezorg. 
       
       Everything here is in the xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" namespace.
	-->
  <!-- ================================================================== -->
  <!-- SETUP: -->
  
  <xsl:include href="../art-decor/shortName.xsl"/>
  
  <!-- ================================================================== -->
  
  <xsl:function name="bc-alg:value-to-enum" as="xs:string">
    <!-- Determines the enum value for a value in a valueset/conceptList. -->
    <xsl:param name="valueset-concept-or-exeception" as="element()">
      <!-- This must be a concept or exception element in a valueset/conceptList of an rtd concept with valueDomain[@type eq 'code'] -->
    </xsl:param>
    
    <!-- There is a very simple and an ART-DECOR shortName way of generating the enums. Since we don't know yet what we're going to use,
      this is the switch: -->
    <xsl:variable name="use-simple-enum-generation" as="xs:boolean" select="false()"/>
    
    <xsl:variable name="base-value" as="xs:string" select="($valueset-concept-or-exeception/@displayName, $valueset-concept-or-exeception/@code)[1]"/>
    <xsl:choose>
      <xsl:when test="$use-simple-enum-generation">
        <xsl:sequence select="fn:normalize-space($base-value) => translate(' ', '_')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="result" as="xs:string">
          <xsl:call-template name="shortName">
            <xsl:with-param name="name" select="$base-value"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:sequence select="$result"/>
      </xsl:otherwise>  
    </xsl:choose>
    
  </xsl:function>
  
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  
  <xsl:function name="bc-alg:dref-name" as="xs:string">
    <!-- Returns the (file)name part of a complete path. --> 
    <xsl:param name="dref" as="xs:string"/>
    <xsl:sequence select="replace($dref, '.*[/\\]([^/\\]+)$', '$1')"/>
  </xsl:function>
  
</xsl:stylesheet>
