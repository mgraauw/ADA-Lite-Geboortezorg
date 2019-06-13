<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:local="#local"
                version="2.0">
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
<!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


   <!--PROLOG-->
   <xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


   <!--KEYS AND FUNCTIONS-->
   <xsl:function xmlns="http://purl.oclc.org/dsdl/schematron"
                 name="local:decimal-convert"
                 as="xs:decimal">
      <xsl:param name="in" as="xs:string"/>
      <xsl:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
   </xsl:function>

   <!--DEFAULT RULES-->


   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
         <svrl:ns-prefix-in-attribute-values uri="#local" prefix="local"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M3"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M4"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M55"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M56"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/" priority="1000" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(prio1_huidig) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(prio1_huidig) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Prio1 huidig": <xsl:text/>
                  <xsl:value-of select="count(prio1_huidig)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M3"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*" mode="M3"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig" priority="1000" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_huidig"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@transactionRef)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@transactionRef)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": Attribuut "transactionRef" ontbreekt [/prio1_huidig/@transactionRef]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionRef) or matches(@transactionRef, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_huidig/@transactionRef; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2453')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2453')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2453" [/prio1_huidig/@transactionRef]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate castable as xs:dateTime)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_huidig/@transactionEffectiveDate; type=xs:dateTime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2018-12-17T15:21:25')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2018-12-17T15:21:25')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2018-12-17T15:21:25" [/prio1_huidig/@transactionEffectiveDate]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@versionDate) or (@versionDate castable as xs:dateTime)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@versionDate) or (@versionDate castable as xs:dateTime)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": De waarde "<xsl:text/>
                  <xsl:value-of select="@versionDate"/>
                  <xsl:text/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_huidig/@versionDate; type=xs:dateTime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidig": Ongeldige attributen aangetroffen [/prio1_huidig; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*" mode="M4"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_huidig"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorgverlenerzorginstelling) ge 0) and (count(zorgverlenerzorginstelling) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorgverlenerzorginstelling) ge 0) and (count(zorgverlenerzorginstelling) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(zorgverlenerzorginstelling)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(vrouw) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(vrouw) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Vrouw": <xsl:text/>
                  <xsl:value-of select="count(vrouw)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig/vrouw]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zwangerschap) ge 0) and (count(zwangerschap) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zwangerschap) ge 0) and (count(zwangerschap) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zwangerschap": <xsl:text/>
                  <xsl:value-of select="count(zwangerschap)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zwangerschap]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(a_terme_datum_groep) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(a_terme_datum_groep) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "A terme datum (groep)": <xsl:text/>
                  <xsl:value-of select="count(a_terme_datum_groep)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig/a_terme_datum_groep]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(medisch_onderzoek) ge 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(medisch_onderzoek) ge 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Medisch onderzoek": <xsl:text/>
                  <xsl:value-of select="count(medisch_onderzoek)"/>
                  <xsl:text/> (verwacht: 0 of meer) [/prio1_huidig/medisch_onderzoek]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::a_terme_datum_groep)][not(self::medisch_onderzoek)][not(self::adaextension)]"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::a_terme_datum_groep)][not(self::medisch_onderzoek)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/prio1_huidig/zorgverlenerzorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw" priority="1000" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_huidig/vrouw"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/prio1_huidig/vrouw/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zwangerschap" priority="1000" mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zwangerschap"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/prio1_huidig/zwangerschap/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/a_terme_datum_groep"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/a_terme_datum_groep"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/a_terme_datum_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029" [/prio1_huidig/a_terme_datum_groep/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": Ongeldige attributen aangetroffen [/prio1_huidig/a_terme_datum_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek" priority="1000" mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14" [/prio1_huidig/medisch_onderzoek/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorgverlener) ge 0) and (count(zorgverlener) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorgverlener) ge 0) and (count(zorgverlener) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener": <xsl:text/>
                  <xsl:value-of select="count(zorgverlener)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(zorginstelling) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(zorginstelling) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(zorginstelling)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/zorgverlenerzorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001" [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(naam_zorgverlener) ge 0) and (count(naam_zorgverlener) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(naam_zorgverlener) ge 0) and (count(naam_zorgverlener) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Naam zorgverlener": <xsl:text/>
                  <xsl:value-of select="count(naam_zorgverlener)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)][not(self::adaextension)]"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006" [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": Attribuut "value" ontbreekt [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(naam_zorginstelling) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(naam_zorginstelling) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Naam zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(naam_zorginstelling)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026" [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw" priority="1000" mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_huidig/vrouw"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(burgerservicenummer) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(burgerservicenummer) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Burgerservicenummer": <xsl:text/>
                  <xsl:value-of select="count(burgerservicenummer)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig/vrouw/burgerservicenummer]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(naamgegevens) ge 0) and (count(naamgegevens) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(naamgegevens) ge 0) and (count(naamgegevens) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Naamgegevens": <xsl:text/>
                  <xsl:value-of select="count(naamgegevens)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(anamnese) ge 0) and (count(anamnese) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(anamnese) ge 0) and (count(anamnese) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Anamnese": <xsl:text/>
                  <xsl:value-of select="count(anamnese)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/anamnese]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(bloedgroep_vrouw) ge 0) and (count(bloedgroep_vrouw) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(bloedgroep_vrouw) ge 0) and (count(bloedgroep_vrouw) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Bloedgroep vrouw": <xsl:text/>
                  <xsl:value-of select="count(bloedgroep_vrouw)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/bloedgroep_vrouw]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(rhesus_d_factor_vrouw) ge 0) and (count(rhesus_d_factor_vrouw) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(rhesus_d_factor_vrouw) ge 0) and (count(rhesus_d_factor_vrouw) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Rhesus D Factor vrouw": <xsl:text/>
                  <xsl:value-of select="count(rhesus_d_factor_vrouw)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/rhesus_d_factor_vrouw]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(rhesus_c_factor) ge 0) and (count(rhesus_c_factor) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(rhesus_c_factor) ge 0) and (count(rhesus_c_factor) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Rhesus c Factor": <xsl:text/>
                  <xsl:value-of select="count(rhesus_c_factor)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/rhesus_c_factor]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::anamnese)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)][not(self::adaextension)]"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::anamnese)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/vrouw/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/burgerservicenummer"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/burgerservicenummer"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/burgerservicenummer/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/prio1_huidig/vrouw/burgerservicenummer/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/burgerservicenummer/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) ge 9)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) ge 9)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_huidig/vrouw/burgerservicenummer/@value; min-length=9]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) le 9)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) le 9)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_huidig/vrouw/burgerservicenummer/@value; max-length=9]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens" priority="1000" mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035" [/prio1_huidig/vrouw/naamgegevens/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/anamnese" priority="1000" mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/anamnese"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Anamnese": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/anamnese/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Anamnese": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80811" [/prio1_huidig/vrouw/anamnese/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Anamnese": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/anamnese; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/bloedgroep_vrouw"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/bloedgroep_vrouw"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/bloedgroep_vrouw/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10810" [/prio1_huidig/vrouw/bloedgroep_vrouw/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@value; allowed=('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@code; allowed=('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Blood group A (finding)', 'Blood group B (finding)', 'Blood group AB (finding)', 'Blood group O (finding)', 'Onbekend', 'Geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Blood group A (finding)', 'Blood group B (finding)', 'Blood group AB (finding)', 'Blood group O (finding)', 'Onbekend', 'Geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@displayName; allowed=('Blood group A (finding)', 'Blood group B (finding)', 'Blood group AB (finding)', 'Blood group O (finding)', 'Onbekend', 'Geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('Blood_group_A_(finding)', 'Blood_group_B_(finding)', 'Blood_group_AB_(finding)', 'Blood_group_O_(finding)', 'Onbekend', 'Geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('Blood_group_A_(finding)', 'Blood_group_B_(finding)', 'Blood_group_AB_(finding)', 'Blood_group_O_(finding)', 'Onbekend', 'Geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/bloedgroep_vrouw/@enum; allowed=('Blood_group_A_(finding)', 'Blood_group_B_(finding)', 'Blood_group_AB_(finding)', 'Blood_group_O_(finding)', 'Onbekend', 'Geen_informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/bloedgroep_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/rhesus_d_factor_vrouw"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/rhesus_d_factor_vrouw"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10811" [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('165747007', '165746003', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('165747007', '165746003', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@value; allowed=('165747007', '165746003', 'UNK', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('165747007', '165746003', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('165747007', '165746003', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@code; allowed=('165747007', '165746003', 'UNK', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Rh D Positief', 'Rh D Negatief', 'onbekend', 'geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Rh D Positief', 'Rh D Negatief', 'onbekend', 'geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@displayName; allowed=('Rh D Positief', 'Rh D Negatief', 'onbekend', 'geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('Rh_D_Positief', 'Rh_D_Negatief', 'onbekend', 'geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('Rh_D_Positief', 'Rh_D_Negatief', 'onbekend', 'geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/rhesus_d_factor_vrouw/@enum; allowed=('Rh_D_Positief', 'Rh_D_Negatief', 'onbekend', 'geen_informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/rhesus_d_factor_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/rhesus_c_factor"
                 priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/rhesus_c_factor"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/rhesus_c_factor/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10816" [/prio1_huidig/vrouw/rhesus_c_factor/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('733120009', '733119003', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('733120009', '733119003', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@value; allowed=('733120009', '733119003', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('733120009', '733119003', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('733120009', '733119003', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@code; allowed=('733120009', '733119003', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Rhc positive (finding)', 'Rhc negative (finding)', 'Geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Rhc positive (finding)', 'Rhc negative (finding)', 'Geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@displayName; allowed=('Rhc positive (finding)', 'Rhc negative (finding)', 'Geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('Rhc_positive_(finding)', 'Rhc_negative_(finding)', 'Geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('Rhc_positive_(finding)', 'Rhc_negative_(finding)', 'Geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/rhesus_c_factor/@enum; allowed=('Rhc_positive_(finding)', 'Rhc_negative_(finding)', 'Geen_informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/rhesus_c_factor; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens" priority="1000" mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(roepnaam) ge 0) and (count(roepnaam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Roepnaam": <xsl:text/>
                  <xsl:value-of select="count(roepnaam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/roepnaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(achternaam) ge 0) and (count(achternaam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(achternaam) ge 0) and (count(achternaam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Achternaam": <xsl:text/>
                  <xsl:value-of select="count(achternaam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/*[not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/*[not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/vrouw/naamgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/roepnaam"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/roepnaam"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360" [/prio1_huidig/vrouw/naamgegevens/roepnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/roepnaam/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/achternaam"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361" [/prio1_huidig/vrouw/naamgegevens/achternaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/achternaam"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(soort_naam) ge 0) and (count(soort_naam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Soort naam": <xsl:text/>
                  <xsl:value-of select="count(soort_naam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(voorvoegsel) ge 0) and (count(voorvoegsel) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Voorvoegsel": <xsl:text/>
                  <xsl:value-of select="count(voorvoegsel)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(achternaam) ge 0) and (count(achternaam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(achternaam) ge 0) and (count(achternaam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Achternaam": <xsl:text/>
                  <xsl:value-of select="count(achternaam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/naamgegevens/achternaam/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/vrouw/naamgegevens/achternaam/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362" [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('BR', 'SP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('BR', 'SP'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('BR', 'SP')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('BR', 'SP'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('BR', 'SP'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Geslachtsnaam', 'Geslachtsnaam partner'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Geslachtsnaam', 'Geslachtsnaam partner'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@displayName; allowed=('Geslachtsnaam', 'Geslachtsnaam partner')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('Geslachtsnaam', 'Geslachtsnaam_partner'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('Geslachtsnaam', 'Geslachtsnaam_partner'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam/@enum; allowed=('Geslachtsnaam', 'Geslachtsnaam_partner')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363" [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043" [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidig/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/anamnese" priority="1000" mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/anamnese"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/vrouw/anamnese/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/vrouw/anamnese/*[not(self::adaextension)]"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/vrouw/anamnese/*[not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/vrouw/anamnese/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zwangerschap" priority="1000" mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zwangerschap"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(graviditeit) ge 0) and (count(graviditeit) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Graviditeit": <xsl:text/>
                  <xsl:value-of select="count(graviditeit)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/graviditeit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(pariteit) ge 0) and (count(pariteit) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(pariteit) ge 0) and (count(pariteit) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Pariteit": <xsl:text/>
                  <xsl:value-of select="count(pariteit)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/pariteit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/zwangerschap/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit)][not(self::adaextension)]"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/zwangerschap/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zwangerschap/graviditeit"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zwangerschap/graviditeit"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/graviditeit/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/prio1_huidig/zwangerschap/graviditeit/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt [/prio1_huidig/zwangerschap/graviditeit/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:decimal)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:decimal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/zwangerschap/graviditeit/@value; type=xs:decimal]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (local:decimal-convert(@value) ge 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (local:decimal-convert(@value) ge 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_huidig/zwangerschap/graviditeit/@value; min-inclusive=1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (local:decimal-convert(@value) le 75)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (local:decimal-convert(@value) le 75)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_huidig/zwangerschap/graviditeit/@value; max-inclusive=75]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap/graviditeit; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/zwangerschap/pariteit"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/zwangerschap/pariteit"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/zwangerschap/pariteit/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20153" [/prio1_huidig/zwangerschap/pariteit/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": Attribuut "value" ontbreekt [/prio1_huidig/zwangerschap/pariteit/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:decimal)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:decimal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/zwangerschap/pariteit/@value; type=xs:decimal]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (local:decimal-convert(@value) ge 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (local:decimal-convert(@value) ge 0)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidig/zwangerschap/pariteit/@value; min-inclusive=0]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (local:decimal-convert(@value) le 30)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (local:decimal-convert(@value) le 30)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_huidig/zwangerschap/pariteit/@value; max-inclusive=30]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": Ongeldige attributen aangetroffen [/prio1_huidig/zwangerschap/pariteit; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/a_terme_datum_groep"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/a_terme_datum_groep"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(a_terme_datum) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(a_terme_datum) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "A terme datum": <xsl:text/>
                  <xsl:value-of select="count(a_terme_datum)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidig/a_terme_datum_groep/a_terme_datum]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/a_terme_datum_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/a_terme_datum_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/a_terme_datum_groep/a_terme_datum"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/a_terme_datum_groep/a_terme_datum"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/a_terme_datum_groep/a_terme_datum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030" [/prio1_huidig/a_terme_datum_groep/a_terme_datum/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": Attribuut "value" ontbreekt [/prio1_huidig/a_terme_datum_groep/a_terme_datum/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or ((@value castable as xs:date) or (@value castable as xs:dateTime))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/a_terme_datum_groep/a_terme_datum/@value; type=t-datetime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": Ongeldige attributen aangetroffen [/prio1_huidig/a_terme_datum_groep/a_terme_datum; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek" priority="1000" mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(maternale_onderzoeksgegevens) ge 0) and (count(maternale_onderzoeksgegevens) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Maternale onderzoeksgegevens": <xsl:text/>
                  <xsl:value-of select="count(maternale_onderzoeksgegevens)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/medisch_onderzoek/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"
                 priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(urine_bloed_en_aanvullende_onderzoeken) ge 0) and (count(urine_bloed_en_aanvullende_onderzoeken) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <xsl:text/>
                  <xsl:value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"
                 priority="1000"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"
                 priority="1000"
                 mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(hb) ge 0) and (count(hb) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(hb) ge 0) and (count(hb) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Hb": <xsl:text/>
                  <xsl:value-of select="count(hb)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adaextension) ge 0) and (count(adaextension) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adaextension) ge 0) and (count(adaextension) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "adaextension": <xsl:text/>
                  <xsl:value-of select="count(adaextension)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)][not(self::adaextension)]"
                 priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"
                 priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10814" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@value)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@value)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": Attribuut "value" ontbreekt [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:decimal)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:decimal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; type=xs:decimal]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (local:decimal-convert(@value) ge 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (local:decimal-convert(@value) ge 0)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; min-inclusive=0]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@unit) or (@unit eq 'mmol/L')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@unit) or (@unit eq 'mmol/L')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": De waarde "<xsl:text/>
                  <xsl:value-of select="@unit"/>
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "mmol/L" [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@unit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @unit, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @unit, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": Ongeldige attributen aangetroffen [/prio1_huidig/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb; allowed=(@conceptId, @value, @unit, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
</xsl:stylesheet>
