<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="#local.wf4_wr1_chb"
  xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       This stylesheets checks an ADA Receive Transaction Dataset specification for:
       - Double code entries for concepts with type="code"
       - Double enum entries for concepts with type="code". Enum entries are derived from the @displayName of a code.
  -->
  <!-- 
    MIT License
  
    Copyright (c) 2019 Marc de Graauw and Erik Siegel
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="lib/xsl-common.xsl"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <check-specification source="{bc-alg:dref-alg-path(base-uri(/))}" timestamp="{current-dateTime()}">

      <!-- Check all the concepts with type="code": -->
      <xsl:for-each select="//concept[exists(valueDomain[@type eq 'code'])]">
        <xsl:variable name="code-entries" as="element()*" select="valueSet/conceptList/(concept | exception)"/>

        <!-- Find out if there are any double codes: -->
        <xsl:variable name="double-code-error-elements" as="element(code-error)*">
          <xsl:variable name="code-values" as="xs:string*" select="$code-entries/@code/string()"/>
          <xsl:variable name="distinct-code-values" as="xs:string*" select="distinct-values($code-values)"/>
          <xsl:if test="count($code-entries) ne count($distinct-code-values)">
            <xsl:for-each select="$distinct-code-values">
              <xsl:variable name="value" as="xs:string" select="."/>
              <xsl:variable name="value-count" as="xs:integer" select="count($code-values[. eq $value])"/>
              <xsl:if test="$value-count gt 1">
                <code-error value="{$value}" occurrences="{$value-count}"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:if>
        </xsl:variable>

        <!-- Find out if there are any double enums: -->
        <xsl:variable name="double-enum-error-elements" as="element(enum-error)*">
          <xsl:variable name="enum-values" as="xs:string*" select="for $code in $code-entries return bc-alg:value-to-enum($code)"/>
          <xsl:variable name="distinct-enum-values" as="xs:string*" select="distinct-values($enum-values)"/>
          <xsl:if test="count($enum-values) ne count($distinct-enum-values)">
            <xsl:for-each select="$distinct-enum-values">
              <xsl:variable name="enum" as="xs:string" select="."/>
              <xsl:variable name="enum-count" as="xs:integer" select="count($enum-values[. eq $enum])"/>
              <xsl:if test="$enum-count gt 1">
                <enum-error value="{$enum}" occurrences="{$enum-count}"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:if>
        </xsl:variable>

        <!-- Report any errors: -->
        <xsl:where-populated>
          <check-concept path="{local:get-doc-xpath(.)}">
            <xsl:sequence select="$double-code-error-elements"/>
            <xsl:sequence select="$double-enum-error-elements"/>
          </check-concept>
        </xsl:where-populated>
        
      </xsl:for-each>
    </check-specification>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:function name="local:get-doc-xpath" as="xs:string?">
    <xsl:param name="elm" as="element()?"/>

    <xsl:choose>
      <xsl:when test="empty($elm)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="shortname" as="xs:string" select="if (exists($elm/@shortName)) then string($elm/@shortName) else '?'"/>
        <xsl:sequence select="local:get-doc-xpath(($elm/ancestor::*[exists(@shortName)])[last()]) || '/' || $shortname"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:function>

</xsl:stylesheet>
