<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:ada="http://www.art-decor.org/ada" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" version="2.0">
  <!-- ================================================================== -->
  <!--
    This stylesheet transforms an ADA Receive Transaction Dataset (shortened to rtd) into an
    empty document example file.
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

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:include href="lib/xsl-common.xsl"/>

  <!-- ================================================================== -->

  <xsl:template match="/dataset">
    <xsl:element name="{@shortName}">
      <xsl:attribute name="transactionRef">
        <xsl:value-of select="@transactionId"/>
      </xsl:attribute>
      <xsl:copy-of select="/ada/project/@versionDate"/>
      
      <xsl:comment> == Generated empty ADA Lite document for <xsl:value-of select="/*/@shortName"/> == </xsl:comment>
      <xsl:comment> == Source: <xsl:value-of select="bc-alg:dref-alg-path(base-uri(/))"/> == </xsl:comment>
      <xsl:comment> == Generator: <xsl:value-of select="bc-alg:dref-alg-path(static-base-uri())"/> == </xsl:comment>
      <xsl:comment> == IMPORTANT REMARK: When elements in have both a value and an enum attribute, use only one of them, not both! == </xsl:comment>
      
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
      <xsl:if test="valueDomain/@type eq 'code'">
        <xsl:attribute name="enum"/>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="text() | @*"/>

</xsl:stylesheet>
