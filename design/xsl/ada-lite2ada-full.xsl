<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="#local.cvh_lb3_vgb"
  xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" xmlns:bc-al2af="https://babyconnect.org/ns/ada-lite2ada-full"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       This stylesheet converts an XML document from the ADA Lite format into full ADA XML.
       For this it uses the definitions from a Retrieve Transaction Dataset (shortened to rtd here). 
       
       The input is assumed to be validated already. Therefore, when an error condition occurs, only a comment is output, no 
       error is raised.
       
       It is part of the conversion stylesheets in the Babyconnect project/program.
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
  <xsl:include href="lib/ada-lite2ada-full.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-rtd" as="xs:string" required="yes"/>
  <!-- Document reference to the Retrieve Transaction Dataset document (with root element <dataset>). -->

  <xsl:param name="use-fixed-version-date" as="xs:string" required="false" select="string(false())"/>
  <!-- Determines the value of /*/@versionDate when this attribute was not specified in the ada-lite input document.
       - If false or unspecified, the current date/time is used
       - If true, a *fixed* version date (see $fixed-version-date below) is used. 
         This is useful because for generating the ada-full examples we don't want a new @versionDate with every generation: This would 
         mean changes to the GIT repository after every generation, even when nothing was changed.
  -->

  <!-- ================================================================== -->

  <xsl:template match="/">
    <xsl:call-template name="bc-al2af:ada-lite2ada-full">
      <xsl:with-param name="ada-lite-root-element" select="/*"/>
      <xsl:with-param name="rtd-root-element" select="doc($dref-rtd)/*"/>
      <xsl:with-param name="use-fixed-version-date" select="xs:boolean($use-fixed-version-date)"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
