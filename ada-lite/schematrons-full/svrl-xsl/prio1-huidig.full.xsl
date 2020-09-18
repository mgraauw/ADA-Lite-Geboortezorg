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
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M58"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M59"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M61"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M62"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M64"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M65"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M67"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M68"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M70"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/" priority="1000" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(prio1_huidige_zwangerschap) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(prio1_huidige_zwangerschap) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Prio1 huidige zwangerschap": <xsl:text/>
                  <xsl:value-of select="count(prio1_huidige_zwangerschap)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap" priority="1000" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@transactionRef)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@transactionRef)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "transactionRef" ontbreekt [/prio1_huidige_zwangerschap/@transactionRef]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_huidige_zwangerschap/@transactionRef; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2493')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2493')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2493" [/prio1_huidige_zwangerschap/@transactionRef]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@transactionEffectiveDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(@transactionEffectiveDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "transactionEffectiveDate" ontbreekt [/prio1_huidige_zwangerschap/@transactionEffectiveDate]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_huidige_zwangerschap/@transactionEffectiveDate; type=xs:dateTime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2020-01-08T13:13:15')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2020-01-08T13:13:15')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2020-01-08T13:13:15" [/prio1_huidige_zwangerschap/@transactionEffectiveDate]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@versionDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@versionDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "versionDate" ontbreekt [/prio1_huidige_zwangerschap/@versionDate]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@versionDate"/>
                  <xsl:text/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_huidige_zwangerschap/@versionDate; type=xs:dateTime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@prefix)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@prefix)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": Attribuut "prefix" ontbreekt [/prio1_huidige_zwangerschap/@prefix]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 huidige zwangerschap": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(zorgverlenerzorginstelling) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(zorgverlenerzorginstelling) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener/Zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(zorgverlenerzorginstelling)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(zwangerschap) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(zwangerschap) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zwangerschap": <xsl:text/>
                  <xsl:value-of select="count(zwangerschap)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap]</svrl:text>
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
                  <xsl:text/> (verwacht: 0 of meer) [/prio1_huidige_zwangerschap/medisch_onderzoek]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::medisch_onderzoek)][not(self::adaextension)]"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::medisch_onderzoek)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/<xsl:text/>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.1" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw" priority="1000" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vrouw": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.2" [/prio1_huidige_zwangerschap/vrouw/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschap": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.3" [/prio1_huidige_zwangerschap/zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.14')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.14')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.14" [/prio1_huidige_zwangerschap/medisch_onderzoek/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling"/>
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
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/*[not(self::zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/*[not(self::zorginstelling)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10020" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorginstelling_oid) ge 0) and (count(zorginstelling_oid) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorginstelling_oid) ge 0) and (count(zorginstelling_oid) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorginstelling OID": <xsl:text/>
                  <xsl:value-of select="count(zorginstelling_oid)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorginstelling_agbid) ge 0) and (count(zorginstelling_agbid) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorginstelling_agbid) ge 0) and (count(zorginstelling_agbid) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorginstelling AGB-ID": <xsl:text/>
                  <xsl:value-of select="count(zorginstelling_agbid)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorginstelling_lvrid) ge 0) and (count(zorginstelling_lvrid) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorginstelling LVR-ID": <xsl:text/>
                  <xsl:value-of select="count(zorginstelling_lvrid)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorginstelling_ura) ge 0) and (count(zorginstelling_ura) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorginstelling_ura) ge 0) and (count(zorginstelling_ura) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorginstelling URA": <xsl:text/>
                  <xsl:value-of select="count(zorginstelling_ura)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(naam_zorginstelling) ge 0) and (count(naam_zorginstelling) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(naam_zorginstelling) ge 0) and (count(naam_zorginstelling) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Naam zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(naam_zorginstelling)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adres_zorginstelling) ge 0) and (count(adres_zorginstelling) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adres_zorginstelling) ge 0) and (count(adres_zorginstelling) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Adres zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(adres_zorginstelling)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(type_zorginstelling) ge 0) and (count(type_zorginstelling) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(type_zorginstelling) ge 0) and (count(type_zorginstelling) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Type zorginstelling": <xsl:text/>
                  <xsl:value-of select="count(type_zorginstelling)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(type_zorginstelling_bij_verwijzing) ge 0) and (count(type_zorginstelling_bij_verwijzing) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(type_zorginstelling_bij_verwijzing) ge 0) and (count(type_zorginstelling_bij_verwijzing) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Type zorginstelling (bij verwijzing)": <xsl:text/>
                  <xsl:value-of select="count(type_zorginstelling_bij_verwijzing)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::type_zorginstelling)][not(self::type_zorginstelling_bij_verwijzing)][not(self::adaextension)]"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::type_zorginstelling)][not(self::type_zorginstelling_bij_verwijzing)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10021" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10022" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) ge 8)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) ge 8)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; min-length=8]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) le 8)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) le 8)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; max-length=8]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10023" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) ge 4)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) ge 4)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 4 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; min-length=4]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) le 5)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) le 5)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; max-length=5]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10024" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) ge 8)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) ge 8)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; min-length=8]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) le 8)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) le 8)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; max-length=8]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10026" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10027" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10029" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type zorginstelling": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@value; allowed=('1', '2', '3', '4', '5')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('Z3', 'G3', 'V4', 'B2', 'L1'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('Z3', 'G3', 'V4', 'B2', 'L1'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@code; allowed=('Z3', 'G3', 'V4', 'B2', 'L1')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@codeSystem; allowed=('2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060', '2.16.840.1.113883.2.4.15.1060')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82019" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type zorginstelling (bij verwijzing)": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/type_zorginstelling_bij_verwijzing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(straatnaam) ge 0) and (count(straatnaam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(straatnaam) ge 0) and (count(straatnaam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Straatnaam": <xsl:text/>
                  <xsl:value-of select="count(straatnaam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(huisnummer) ge 0) and (count(huisnummer) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(huisnummer) ge 0) and (count(huisnummer) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Huisnummer": <xsl:text/>
                  <xsl:value-of select="count(huisnummer)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(huisletterhuisnummertoevoeging) ge 0) and (count(huisletterhuisnummertoevoeging) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(huisletterhuisnummertoevoeging) ge 0) and (count(huisletterhuisnummertoevoeging) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Huisletter/huisnummertoevoeging": <xsl:text/>
                  <xsl:value-of select="count(huisletterhuisnummertoevoeging)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(postcode) ge 0) and (count(postcode) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(postcode) ge 0) and (count(postcode) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Postcode": <xsl:text/>
                  <xsl:value-of select="count(postcode)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(plaatsnaam) ge 0) and (count(plaatsnaam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(plaatsnaam) ge 0) and (count(plaatsnaam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Plaatsnaam": <xsl:text/>
                  <xsl:value-of select="count(plaatsnaam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(gemeentenaam) ge 0) and (count(gemeentenaam) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(gemeentenaam) ge 0) and (count(gemeentenaam) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Gemeentenaam": <xsl:text/>
                  <xsl:value-of select="count(gemeentenaam)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(land) ge 0) and (count(land) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(land) ge 0) and (count(land) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Land": <xsl:text/>
                  <xsl:value-of select="count(land)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(adrestype) ge 0) and (count(adrestype) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(adrestype) ge 0) and (count(adrestype) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Adrestype": <xsl:text/>
                  <xsl:value-of select="count(adrestype)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::gemeentenaam)][not(self::land)][not(self::adrestype)][not(self::adaextension)]"
                 priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::gemeentenaam)][not(self::land)][not(self::adrestype)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Straatnaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Straatnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Straatnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10032" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Straatnaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisnummer": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisnummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisnummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10033" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisnummer": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10034" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"
                 priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Postcode": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Postcode": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Postcode": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10041" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Plaatsnaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Plaatsnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Plaatsnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10036" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Plaatsnaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gemeentenaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gemeentenaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gemeentenaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10037" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gemeentenaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/gemeentenaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Land": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Land": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Land": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10038" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Land": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10039" [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Adrestype": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adrestype": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adrestype; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw"/>
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
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)][not(self::adaextension)]"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::bloedgroep_vrouw)][not(self::rhesus_d_factor_vrouw)][not(self::rhesus_c_factor)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/vrouw/<xsl:text/>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/burgerservicenummer"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/burgerservicenummer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10030" [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@value; min-length=9]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer/@value; max-length=9]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10035" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10810')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10810')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10810" [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@value; allowed=('1', '2', '3', '4', '5', '6')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@code]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@code; allowed=('112144000', '112149005', '165743006', '58460004', 'UNK', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@codeSystem]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedgroep vrouw": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/bloedgroep_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10811')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10811')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10811" [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@value; allowed=('1', '2', '3', '4')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@code]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@code; allowed=('165747007', '165746003', 'UNK', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@codeSystem]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus D Factor vrouw": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/rhesus_d_factor_vrouw; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10816')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10816')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10816" [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@value; allowed=('1', '2', '3')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@code]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@code; allowed=('733120009', '733119003', 'NI')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@codeSystem]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Rhesus c Factor": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/rhesus_c_factor; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(voornamen) ge 0) and (count(voornamen) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(voornamen) ge 0) and (count(voornamen) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Voornamen": <xsl:text/>
                  <xsl:value-of select="count(voornamen)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(initialen) ge 0) and (count(initialen) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(initialen) ge 0) and (count(initialen) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Initialen": <xsl:text/>
                  <xsl:value-of select="count(initialen)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(achternaam) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(achternaam) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Achternaam": <xsl:text/>
                  <xsl:value-of select="count(achternaam)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/vrouw/naamgegevens/<xsl:text/>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10042" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/voornamen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Initialen": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Initialen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Initialen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82359" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Initialen": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/initialen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82360" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82361" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam"/>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(achternaam) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(achternaam) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Achternaam": <xsl:text/>
                  <xsl:value-of select="count(achternaam)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82362" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "value" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('1', '2')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@code)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@code)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "code" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@code]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@codeSystem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@codeSystem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "codeSystem" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@displayName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@displayName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "displayName" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam/@displayName]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.82363" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam"
                 priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10043" [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(dossiernummer) ge 0) and (count(dossiernummer) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(dossiernummer) ge 0) and (count(dossiernummer) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Dossiernummer": <xsl:text/>
                  <xsl:value-of select="count(dossiernummer)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zwangerschap/dossiernummer]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(graviditeit) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(graviditeit) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Graviditeit": <xsl:text/>
                  <xsl:value-of select="count(graviditeit)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/graviditeit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(pariteit) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(pariteit) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Pariteit": <xsl:text/>
                  <xsl:value-of select="count(pariteit)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/pariteit]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zwangerschap/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/*[not(self::dossiernummer)][not(self::graviditeit)][not(self::pariteit)][not(self::a_terme_datum_groep)][not(self::adaextension)]"
                 priority="1000"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/*[not(self::dossiernummer)][not(self::graviditeit)][not(self::pariteit)][not(self::a_terme_datum_groep)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/zwangerschap/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/dossiernummer"
                 priority="1000"
                 mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/dossiernummer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dossiernummer": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/dossiernummer/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dossiernummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/dossiernummer/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.999.60.5.6.3.1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.999.60.5.6.3.1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dossiernummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.999.60.5.6.3.1" [/prio1_huidige_zwangerschap/zwangerschap/dossiernummer/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dossiernummer": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/dossiernummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/graviditeit"
                 priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/graviditeit"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20010" [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@value; min-inclusive=1]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_huidige_zwangerschap/zwangerschap/graviditeit/@value; max-inclusive=75]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/graviditeit; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/pariteit"
                 priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/pariteit"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20153')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20153')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20153" [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@value; min-inclusive=0]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_huidige_zwangerschap/zwangerschap/pariteit/@value; max-inclusive=30]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/pariteit; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep"
                 priority="1000"
                 mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20029')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20029')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20029" [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep"
                 priority="1000"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep"/>
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
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]"
                 priority="1000"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum"
                 priority="1000"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20030')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20030')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.20030" [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum/@value; type=t-datetime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "A terme datum": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/zwangerschap/a_terme_datum_groep/a_terme_datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek"
                 priority="1000"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(datum_onderzoek) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(datum_onderzoek) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Datum onderzoek": <xsl:text/>
                  <xsl:value-of select="count(datum_onderzoek)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(maternale_onderzoeksgegevens) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(maternale_onderzoeksgegevens) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Maternale onderzoeksgegevens": <xsl:text/>
                  <xsl:value-of select="count(maternale_onderzoeksgegevens)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/medisch_onderzoek/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/*[not(self::datum_onderzoek)][not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]"
                 priority="1000"
                 mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/*[not(self::datum_onderzoek)][not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/medisch_onderzoek/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek"
                 priority="1000"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum onderzoek": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum onderzoek": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.50020')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.50020')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum onderzoek": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.50020" [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum onderzoek": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek/@value; type=t-datetime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum onderzoek": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/datum_onderzoek; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens"
                 priority="1000"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.142')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.142')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.142" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(urine_bloed_en_aanvullende_onderzoeken) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(urine_bloed_en_aanvullende_onderzoeken) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Urine-, bloed- en aanvullende onderzoeken": <xsl:text/>
                  <xsl:value-of select="count(urine_bloed_en_aanvullende_onderzoeken)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]"
                 priority="1000"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"
                 priority="1000"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80959')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80959')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.80959" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"
                 priority="1000"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(hb) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hb) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Hb": <xsl:text/>
                  <xsl:value-of select="count(hb)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)][not(self::adaextension)]"
                 priority="1000"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::hb)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"
                 priority="1000"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": Attribuut "conceptId" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10814')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10814')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.6.10814" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@value; min-inclusive=0]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@unit)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@unit)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": Attribuut "unit" ontbreekt [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@unit]</svrl:text>
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
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "mmol/L" [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb/@unit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@* except (@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hb": Ongeldige attributen aangetroffen [/prio1_huidige_zwangerschap/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/hb; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
</xsl:stylesheet>
