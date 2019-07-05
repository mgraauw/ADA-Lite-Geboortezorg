<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg">
  <!-- ================================================================== -->
  <!-- 
    Converts a full blown ADA Retrieve Transaction Dataset file into its light version
  
    Author: Marc de Graauw, 2013. 
    Adapted by: Erik Siegel, 2019
    Copyright: to be decided, until then all rights reserved 
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
  
  <xsl:output method="xml" indent="yes"/>

  <xsl:include href="lib/xsl-common.xsl"/>

  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="name desc"/>

  <!-- ================================================================== -->

  <xsl:template match="/*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>

      <xsl:comment> == Generated lite version of specification from full version for <xsl:value-of select="/*/@shortName"/> == </xsl:comment>
      <xsl:comment> == Source: <xsl:value-of select="bc-alg:dref-alg-path(base-uri(/))"/> == </xsl:comment>
      <xsl:comment> == Generator: <xsl:value-of select="bc-alg:dref-alg-path(static-base-uri())"/> == </xsl:comment>

      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="implementation | community | inherit | terminologyAssociation"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="@iddisplay | @versionLabel"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="valueDomain">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="* except conceptList"/>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="valueSet">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="name | desc"/>
      <conceptList>
        <xsl:for-each select="conceptList/*">
          <xsl:copy copy-namespaces="no">
              <xsl:copy-of select="(@localId, @code, @codeSystem, @displayName)" copy-namespaces="no"/>
               <xsl:attribute name="value" select="@code"/>
              <xsl:copy-of select="name" copy-namespaces="no"/>
          </xsl:copy>
        </xsl:for-each>
      </conceptList>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="@*|*">
      <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
