<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.tcl_gls_bhb"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!--	
       Module with code that is shared between some of the stylesheets for ADA-lite-Geboortezorg. 
       
       Everything here is in the xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" namespace.
	-->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:include href="../art-decor/shortName.xsl"/>


  <!-- ================================================================== -->
  <!-- GLOBAL VARIABLES: -->

  <xsl:variable name="bc-alg:repo-name" as="xs:string" select="'ADA-Lite-Geboortezorg'"/>

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

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="bc-alg:dref-alg-path" as="xs:string">
    <!-- Returns the path of a document inside the ADA-Lite-Geboortezorg repo. -->
    <xsl:param name="dref" as="xs:string"/>

    <xsl:variable name="repo-path-part" as="xs:string" select="'/' || $bc-alg:repo-name || '/'"/>
    <xsl:choose>
      <xsl:when test="contains($dref, $repo-path-part)">
        <xsl:sequence select="fn:substring-after($dref, $repo-path-part)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="bc-alg:dref-name($dref)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="bc-alg:add-copyright-comment">
    <xsl:variable name="nl" as="xs:string" select="'&#10;'"/>
    <xsl:variable name="dref-copyright-text" as="xs:string" select="string(resolve-uri('copyright.txt', fn:static-base-uri()))"/>
    <xsl:value-of select="$nl"/>
    <xsl:comment>
      <xsl:value-of select="$nl"/>
      <xsl:value-of select="fn:unparsed-text($dref-copyright-text)"/>
            <xsl:value-of select="$nl"/>
    </xsl:comment>
    <xsl:value-of select="$nl"/>
  </xsl:template>

</xsl:stylesheet>
