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
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M71"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M73"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M74"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M76"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M77"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M79"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M80"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M82"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M83"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M84"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M85"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M86"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M87"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M88"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M89"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M90"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M91"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M92"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M93"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M94"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M95"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M96"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M97"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M98"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M99"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M100"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M101"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M102"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M103"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M104"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M105"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M106"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M107"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M108"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M109"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M110"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M111"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M112"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M113"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M114"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M115"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M116"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M117"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M118"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M119"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M120"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M121"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M122"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M123"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M124"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M125"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M126"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M127"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M128"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M129"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M130"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M131"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M132"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M133"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M134"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M135"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M136"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M137"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M138"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M139"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M140"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M141"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M142"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M143"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M144"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M145"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M146"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M147"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M148"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M149"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M150"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M151"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M152"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M153"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M154"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M155"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M156"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M157"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M158"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M159"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M160"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M161"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M162"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M163"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M164"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M165"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M166"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M167"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M168"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M169"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M170"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M171"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M172"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M173"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M174"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M175"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M176"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/" priority="1000" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(voorgaande_zwangerschap_samenvatting_22) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(voorgaande_zwangerschap_samenvatting_22) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Voorgaande zwangerschap samenvatting (2.2)": <xsl:text/>
                  <xsl:value-of select="count(voorgaande_zwangerschap_samenvatting_22)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@transactionRef)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@transactionRef)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "transactionRef" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@transactionRef]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/@transactionRef; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2465')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2465')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2465" [/voorgaande_zwangerschap_samenvatting_22/@transactionRef]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "transactionEffectiveDate" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@transactionEffectiveDate]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/@transactionEffectiveDate; type=xs:dateTime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2019-03-07T15:23:44')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2019-03-07T15:23:44')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2019-03-07T15:23:44" [/voorgaande_zwangerschap_samenvatting_22/@transactionEffectiveDate]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "versionDate" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@versionDate]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": De waarde "<xsl:text/>
                  <xsl:value-of select="@versionDate"/>
                  <xsl:text/>" voor attribuut "versionDate" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/@versionDate; type=xs:dateTime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Attribuut "prefix" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/@prefix]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorgaande zwangerschap samenvatting (2.2)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22"/>
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
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/vrouw]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(bevalling) ge 0) and (count(bevalling) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(bevalling) ge 0) and (count(bevalling) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Bevalling": <xsl:text/>
                  <xsl:value-of select="count(bevalling)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(uitkomst_per_kind) ge 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(uitkomst_per_kind) ge 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Uitkomst (per kind)": <xsl:text/>
                  <xsl:value-of select="count(uitkomst_per_kind)"/>
                  <xsl:text/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(medisch_onderzoek) ge 0) and (count(medisch_onderzoek) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(medisch_onderzoek) ge 0) and (count(medisch_onderzoek) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Medisch onderzoek": <xsl:text/>
                  <xsl:value-of select="count(medisch_onderzoek)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::medisch_onderzoek)][not(self::adaextension)]"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::medisch_onderzoek)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/<xsl:text/>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw"
                 priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vrouw": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/voorgaande_zwangerschap_samenvatting_22/vrouw/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bevalling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bevalling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bevalling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6" [/voorgaande_zwangerschap_samenvatting_22/bevalling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Uitkomst (per kind)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Uitkomst (per kind)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Uitkomst (per kind)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.14" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Medisch onderzoek": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(zorgverlener) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(zorgverlener) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener": <xsl:text/>
                  <xsl:value-of select="count(zorgverlener)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorgverlener_uzinummer) ge 0) and (count(zorgverlener_uzinummer) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorgverlener_uzinummer) ge 0) and (count(zorgverlener_uzinummer) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener UZI-nummer": <xsl:text/>
                  <xsl:value-of select="count(zorgverlener_uzinummer)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorgverlener_agbid) ge 0) and (count(zorgverlener_agbid) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorgverlener_agbid) ge 0) and (count(zorgverlener_agbid) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener AGB-ID": <xsl:text/>
                  <xsl:value-of select="count(zorgverlener_agbid)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorgverlener_lvr1id) ge 0) and (count(zorgverlener_lvr1id) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorgverlener_lvr1id) ge 0) and (count(zorgverlener_lvr1id) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlener LVR1-ID": <xsl:text/>
                  <xsl:value-of select="count(zorgverlener_lvr1id)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zorgverlenertype) ge 0) and (count(zorgverlenertype) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zorgverlenertype) ge 0) and (count(zorgverlenertype) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zorgverlenertype": <xsl:text/>
                  <xsl:value-of select="count(zorgverlenertype)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/*[not(self::zorgverlener_uzinummer)][not(self::zorgverlener_agbid)][not(self::zorgverlener_lvr1id)][not(self::naam_zorgverlener)][not(self::zorgverlenertype)][not(self::adaextension)]"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/*[not(self::zorgverlener_uzinummer)][not(self::zorgverlener_agbid)][not(self::zorgverlener_lvr1id)][not(self::naam_zorgverlener)][not(self::zorgverlenertype)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener UZI-nummer": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10002')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10002')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10002" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@value; min-length=9]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener UZI-nummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer/@value; max-length=9]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener UZI-nummer": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_uzinummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener AGB-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10003')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10003')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10003" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@value; min-length=8]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid/@value; max-length=8]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener AGB-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_agbid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener LVR1-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10004')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10004')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10004" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@value; min-length=4]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) le 4)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) le 4)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlener LVR1-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id/@value; max-length=4]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener LVR1-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlener_lvr1id; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10010')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10010')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10010" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('01.000', '01.015', '01.019', '01.020', '01.046', '03.000', 'AA.001', 'AA.002'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('01.000', '01.015', '01.019', '01.020', '01.046', '03.000', 'AA.001', 'AA.002'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@code; allowed=('01.000', '01.015', '01.019', '01.020', '01.046', '03.000', 'AA.001', 'AA.002')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.98.111', '2.16.840.1.113883.2.4.98.111'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.98.111', '2.16.840.1.113883.2.4.98.111'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@codeSystem; allowed=('2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.15.111', '2.16.840.1.113883.2.4.98.111', '2.16.840.1.113883.2.4.98.111')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlenertype": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorgverlener/zorgverlenertype; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling"/>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/*[not(self::zorginstelling_oid)][not(self::zorginstelling_agbid)][not(self::zorginstelling_lvrid)][not(self::zorginstelling_ura)][not(self::naam_zorginstelling)][not(self::adres_zorginstelling)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/<xsl:text/>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10021')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10021')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10021" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling OID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_oid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10022')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10022')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10022" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; min-length=8]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid/@value; max-length=8]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_agbid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10023" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; min-length=4]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 5 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid/@value; max-length=5]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling LVR-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"
                 priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10024')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10024')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10024" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; min-length=8]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura/@value; max-length=8]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling URA": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/zorginstelling_ura; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10027')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10027')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10027" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Adres zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(straatnaam) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(straatnaam) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Straatnaam": <xsl:text/>
                  <xsl:value-of select="count(straatnaam)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(huisnummer) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(huisnummer) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Huisnummer": <xsl:text/>
                  <xsl:value-of select="count(huisnummer)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(postcode) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(postcode) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Postcode": <xsl:text/>
                  <xsl:value-of select="count(postcode)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(plaatsnaam) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(plaatsnaam) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Plaatsnaam": <xsl:text/>
                  <xsl:value-of select="count(plaatsnaam)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::land)][not(self::adaextension)]"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/*[not(self::straatnaam)][not(self::huisnummer)][not(self::huisletterhuisnummertoevoeging)][not(self::postcode)][not(self::plaatsnaam)][not(self::land)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Straatnaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10032')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10032')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Straatnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10032" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Straatnaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/straatnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisnummer": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10033')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10033')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisnummer": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10033" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Huisnummer": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisnummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10034')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10034')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10034" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Huisletter/huisnummertoevoeging": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/huisletterhuisnummertoevoeging; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Postcode": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10041')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10041')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Postcode": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10041" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Postcode": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/postcode; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Plaatsnaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10036')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10036')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Plaatsnaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10036" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Plaatsnaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/plaatsnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Land": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10038')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10038')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Land": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10038" [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Land": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zorgverlenerzorginstelling/zorginstelling/adres_zorginstelling/land; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(burgerservicenummer) ge 0) and (count(burgerservicenummer) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(burgerservicenummer) ge 0) and (count(burgerservicenummer) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Burgerservicenummer": <xsl:text/>
                  <xsl:value-of select="count(burgerservicenummer)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(naamgegevens) ge 1) and (count(naamgegevens) le 2)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(naamgegevens) ge 1) and (count(naamgegevens) le 2)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Naamgegevens": <xsl:text/>
                  <xsl:value-of select="count(naamgegevens)"/>
                  <xsl:text/> (verwacht: 1..2) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Geboortedatum": <xsl:text/>
                  <xsl:value-of select="count(geboortedatum)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::geboortedatum)][not(self::adaextension)]"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::geboortedatum)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/vrouw/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@value; min-length=9]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer/@value; max-length=9]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortedatum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortedatum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10040" [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortedatum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum/@value; type=t-datetime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/geboortedatum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens"/>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/*[not(self::voornamen)][not(self::initialen)][not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/<xsl:text/>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10042" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/voornamen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Initialen": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Initialen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82359" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Initialen": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/initialen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Roepnaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam"/>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/<xsl:text/>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam"
                 priority="1000"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('1', '2')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@code]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel"
                 priority="1000"
                 mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam"
                 priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043" [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap"
                 priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(identificatie_van_de_zwangerschap) ge 0) and (count(identificatie_van_de_zwangerschap) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(identificatie_van_de_zwangerschap) ge 0) and (count(identificatie_van_de_zwangerschap) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Identificatie van de zwangerschap": <xsl:text/>
                  <xsl:value-of select="count(identificatie_van_de_zwangerschap)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(pariteit_voor_deze_zwangerschap) ge 0) and (count(pariteit_voor_deze_zwangerschap) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Pariteit (vóór deze zwangerschap)": <xsl:text/>
                  <xsl:value-of select="count(pariteit_voor_deze_zwangerschap)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(definitieve_a_terme_datum) ge 0) and (count(definitieve_a_terme_datum) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Definitieve à terme datum": <xsl:text/>
                  <xsl:value-of select="count(definitieve_a_terme_datum)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(diagnose) ge 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(diagnose) ge 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Diagnose": <xsl:text/>
                  <xsl:value-of select="count(diagnose)"/>
                  <xsl:text/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(wijze_einde_zwangerschap) ge 0) and (count(wijze_einde_zwangerschap) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Wijze einde zwangerschap": <xsl:text/>
                  <xsl:value-of select="count(wijze_einde_zwangerschap)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(datum_einde_zwangerschap) ge 0) and (count(datum_einde_zwangerschap) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(datum_einde_zwangerschap) ge 0) and (count(datum_einde_zwangerschap) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Datum einde zwangerschap": <xsl:text/>
                  <xsl:value-of select="count(datum_einde_zwangerschap)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/*[not(self::identificatie_van_de_zwangerschap)][not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::diagnose)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]"
                 priority="1000"
                 mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/*[not(self::identificatie_van_de_zwangerschap)][not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::definitieve_a_terme_datum)][not(self::diagnose)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap"
                 priority="1000"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Identificatie van de zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Identificatie van de zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80627')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80627')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Identificatie van de zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80627" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Identificatie van de zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/identificatie_van_de_zwangerschap; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit"
                 priority="1000"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Graviditeit": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 1 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value; min-inclusive=1]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag maximaal 75 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit/@value; max-inclusive=75]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/graviditeit; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap"
                 priority="1000"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value; type=xs:decimal]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value; min-inclusive=0]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag maximaal 30 zijn [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap/@value; max-inclusive=30]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/pariteit_voor_deze_zwangerschap; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum"
                 priority="1000"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Definitieve à terme datum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Definitieve à terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Definitieve à terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82160" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Definitieve à terme datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum/@value; type=t-datetime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Definitieve à terme datum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/definitieve_a_terme_datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose"
                 priority="1000"
                 mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diagnose": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diagnose": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diagnose": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82268" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diagnose": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap"
                 priority="1000"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap"
                 priority="1000"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap/@value; type=t-datetime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/datum_einde_zwangerschap; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(gynaecologische_aandoening) ge 0) and (count(gynaecologische_aandoening) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Gynaecologische aandoening": <xsl:text/>
                  <xsl:value-of select="count(gynaecologische_aandoening)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(bloedverliesq) ge 0) and (count(bloedverliesq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Bloedverlies?": <xsl:text/>
                  <xsl:value-of select="count(bloedverliesq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cervixinsufficientieq) ge 0) and (count(cervixinsufficientieq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Cervixinsufficiëntie?": <xsl:text/>
                  <xsl:value-of select="count(cervixinsufficientieq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(infectie) ge 0) and (count(infectie) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(infectie) ge 0) and (count(infectie) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Infectie": <xsl:text/>
                  <xsl:value-of select="count(infectie)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(hyperemesis_gravidarumq) ge 0) and (count(hyperemesis_gravidarumq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Hyperemesis gravidarum?": <xsl:text/>
                  <xsl:value-of select="count(hyperemesis_gravidarumq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(hypertensieve_aandoening) ge 0) and (count(hypertensieve_aandoening) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Hypertensieve aandoening": <xsl:text/>
                  <xsl:value-of select="count(hypertensieve_aandoening)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zwangerschapscholestaseq) ge 0) and (count(zwangerschapscholestaseq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zwangerschapscholestase?": <xsl:text/>
                  <xsl:value-of select="count(zwangerschapscholestaseq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(diabetes_gravidarum_met_insulineq) ge 0) and (count(diabetes_gravidarum_met_insulineq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Diabetes gravidarum met insuline?": <xsl:text/>
                  <xsl:value-of select="count(diabetes_gravidarum_met_insulineq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(afwijkende_groei_foetus) ge 0) and (count(afwijkende_groei_foetus) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Afwijkende groei foetus": <xsl:text/>
                  <xsl:value-of select="count(afwijkende_groei_foetus)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(dreigende_partus_immaturusq) ge 0) and (count(dreigende_partus_immaturusq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Dreigende partus immaturus?": <xsl:text/>
                  <xsl:value-of select="count(dreigende_partus_immaturusq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(dreigende_partus_prematurusq) ge 0) and (count(dreigende_partus_prematurusq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Dreigende partus prematurus?": <xsl:text/>
                  <xsl:value-of select="count(dreigende_partus_prematurusq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(abruptio_placentaeq) ge 0) and (count(abruptio_placentaeq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Abruptio placentae?": <xsl:text/>
                  <xsl:value-of select="count(abruptio_placentaeq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/adaextension]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/*[not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)][not(self::adaextension)]"
                 priority="1000"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/*[not(self::gynaecologische_aandoening)][not(self::bloedverliesq)][not(self::cervixinsufficientieq)][not(self::infectie)][not(self::hyperemesis_gravidarumq)][not(self::hypertensieve_aandoening)][not(self::zwangerschapscholestaseq)][not(self::diabetes_gravidarum_met_insulineq)][not(self::afwijkende_groei_foetus)][not(self::dreigende_partus_immaturusq)][not(self::dreigende_partus_prematurusq)][not(self::abruptio_placentaeq)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/<xsl:text/>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening"
                 priority="1000"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82269" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@value; allowed=('1', '2', '3', '4')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('129103003', '95315005', '37849005', 'OTH'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@code; allowed=('129103003', '95315005', '37849005', 'OTH')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Gynaecologische aandoening": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/gynaecologische_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq"
                 priority="1000"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedverlies?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bloedverlies?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedverlies?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82270" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bloedverlies?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bloedverlies?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/bloedverliesq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
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
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq"
                 priority="1000"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Cervixinsufficiëntie?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82271" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Cervixinsufficiëntie?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Cervixinsufficiëntie?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/cervixinsufficientieq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie"
                 priority="1000"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Infectie": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Infectie": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82273" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@value; allowed=('1', '2', '3', '4', '5', '6')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Infectie": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@code; allowed=('301775005', '307534009', '45816000', '186156007', 'OTH', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@codeSystem]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Infectie": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/infectie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq"
                 priority="1000"
                 mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hyperemesis gravidarum?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82274" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hyperemesis gravidarum?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hyperemesis gravidarum?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hyperemesis_gravidarumq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening"
                 priority="1000"
                 mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82275" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@value; allowed=('1', '2', '3', '4')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('48194001', '398254007', '95605009', '15938005'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@code; allowed=('48194001', '398254007', '95605009', '15938005')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hypertensieve aandoening": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/hypertensieve_aandoening; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq"
                 priority="1000"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapscholestase?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82276" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapscholestase?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapscholestase?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/zwangerschapscholestaseq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"
                 priority="1000"
                 mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diabetes gravidarum met insuline?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82277" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diabetes gravidarum met insuline?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diabetes gravidarum met insuline?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/diabetes_gravidarum_met_insulineq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus"
                 priority="1000"
                 mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82278" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@value; allowed=('1', '2', '3')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('199616008', '267258002', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@code; allowed=('199616008', '267258002', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Afwijkende groei foetus": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/afwijkende_groei_foetus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq"
                 priority="1000"
                 mode="M76">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dreigende partus immaturus?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82279" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dreigende partus immaturus?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Dreigende partus immaturus?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_immaturusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq"
                 priority="1000"
                 mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dreigende partus prematurus?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82280" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Dreigende partus prematurus?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Dreigende partus prematurus?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/dreigende_partus_prematurusq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq"
                 priority="1000"
                 mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Abruptio placentae?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Abruptio placentae?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Abruptio placentae?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82289" [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Abruptio placentae?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Abruptio placentae?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/zwangerschap/diagnose/abruptio_placentaeq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling"
                 priority="1000"
                 mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(diagnose_bevalling) ge 0) and (count(diagnose_bevalling) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(diagnose_bevalling) ge 0) and (count(diagnose_bevalling) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Diagnose bevalling": <xsl:text/>
                  <xsl:value-of select="count(diagnose_bevalling)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(wijze_waarop_de_baring_begon) ge 0) and (count(wijze_waarop_de_baring_begon) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(wijze_waarop_de_baring_begon) ge 0) and (count(wijze_waarop_de_baring_begon) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Wijze waarop de baring begon": <xsl:text/>
                  <xsl:value-of select="count(wijze_waarop_de_baring_begon)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(interventies_begin_baring_groep) ge 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(interventies_begin_baring_groep) ge 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Interventies begin baring (groep)": <xsl:text/>
                  <xsl:value-of select="count(interventies_begin_baring_groep)"/>
                  <xsl:text/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(placenta) ge 0) and (count(placenta) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(placenta) ge 0) and (count(placenta) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Placenta": <xsl:text/>
                  <xsl:value-of select="count(placenta)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(hoeveelheid_bloedverlies) ge 0) and (count(hoeveelheid_bloedverlies) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Hoeveelheid bloedverlies": <xsl:text/>
                  <xsl:value-of select="count(hoeveelheid_bloedverlies)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(conditie_perineum_postpartum) ge 0) and (count(conditie_perineum_postpartum) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Conditie perineum postpartum": <xsl:text/>
                  <xsl:value-of select="count(conditie_perineum_postpartum)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/*[not(self::diagnose_bevalling)][not(self::wijze_waarop_de_baring_begon)][not(self::interventies_begin_baring_groep)][not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]"
                 priority="1000"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/*[not(self::diagnose_bevalling)][not(self::wijze_waarop_de_baring_begon)][not(self::interventies_begin_baring_groep)][not(self::placenta)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling"
                 priority="1000"
                 mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diagnose bevalling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diagnose bevalling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Diagnose bevalling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diagnose bevalling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon"
                 priority="1000"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20550" [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@value; allowed=('1', '2', '3', '4', '5')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@code; allowed=('1', '2', '3', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.2.4.3.22.1.2.46', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze waarop de baring begon": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/wijze_waarop_de_baring_begon; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep"
                 priority="1000"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventies begin baring (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventies begin baring (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20555" [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventies begin baring (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta"
                 priority="1000"
                 mode="M84">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Placenta": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80612" [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Placenta": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies"
                 priority="1000"
                 mode="M85">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640" [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@unit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@unit) or (@unit eq 'ml')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@unit) or (@unit eq 'ml')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": De waarde "<xsl:text/>
                  <xsl:value-of select="@unit"/>
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum"
                 priority="1000"
                 mode="M86">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673" [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@code; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/conditie_perineum_postpartum; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling"
                 priority="1000"
                 mode="M87">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(datum) ge 0) and (count(datum) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(datum) ge 0) and (count(datum) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Datum": <xsl:text/>
                  <xsl:value-of select="count(datum)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zwangerschapsduur": <xsl:text/>
                  <xsl:value-of select="count(zwangerschapsduur)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(fluxus_postpartumq) ge 0) and (count(fluxus_postpartumq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(fluxus_postpartumq) ge 0) and (count(fluxus_postpartumq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Fluxus postpartum?": <xsl:text/>
                  <xsl:value-of select="count(fluxus_postpartumq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/*[not(self::datum)][not(self::zwangerschapsduur)][not(self::fluxus_postpartumq)][not(self::adaextension)]"
                 priority="1000"
                 mode="M88">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/*[not(self::datum)][not(self::zwangerschapsduur)][not(self::fluxus_postpartumq)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum"
                 priority="1000"
                 mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82381')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82381')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82381" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum/@value; type=t-datetime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/datum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur"
                 priority="1000"
                 mode="M90">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@value; type=xs:decimal]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@unit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@unit) or (@unit eq 'd')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@unit) or (@unit eq 'd')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@unit"/>
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq"
                 priority="1000"
                 mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fluxus postpartum?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fluxus postpartum?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82398')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82398')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fluxus postpartum?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82398" [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fluxus postpartum?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fluxus postpartum?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/diagnose_bevalling/fluxus_postpartumq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep"
                 priority="1000"
                 mode="M92">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(interventie_begin_baring) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(interventie_begin_baring) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Interventie begin baring": <xsl:text/>
                  <xsl:value-of select="count(interventie_begin_baring)"/>
                  <xsl:text/> (verwacht: 1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(indicatie_interventie_begin_baring) ge 0) and (count(indicatie_interventie_begin_baring) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(indicatie_interventie_begin_baring) ge 0) and (count(indicatie_interventie_begin_baring) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Indicatie interventie begin baring": <xsl:text/>
                  <xsl:value-of select="count(indicatie_interventie_begin_baring)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/*[not(self::interventie_begin_baring)][not(self::indicatie_interventie_begin_baring)][not(self::adaextension)]"
                 priority="1000"
                 mode="M93">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/*[not(self::interventie_begin_baring)][not(self::indicatie_interventie_begin_baring)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring"
                 priority="1000"
                 mode="M94">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventie begin baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20560" [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventie begin baring": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventie begin baring": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@code; allowed=('236960006', '408818004', '425861005', '236966000', '177135005', '177136006', '177141003', 'OTH', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventie begin baring": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventie begin baring": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Interventie begin baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/interventie_begin_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring"
                 priority="1000"
                 mode="M95">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20570" [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@value; allowed=('2', '3', '4', '6', '7', '8', '9', '10', '11', '12', '13', '14')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@code; allowed=('1', '3', '8', '2', '4', '9', '5', '6', '7', 'OTH', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.2.4.3.22.1.2.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie interventie begin baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/interventies_begin_baring_groep/indicatie_interventie_begin_baring; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta"
                 priority="1000"
                 mode="M96">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(geboorte_placenta) ge 0) and (count(geboorte_placenta) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Geboorte placenta": <xsl:text/>
                  <xsl:value-of select="count(geboorte_placenta)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/*[not(self::geboorte_placenta)][not(self::adaextension)]"
                 priority="1000"
                 mode="M97">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/*[not(self::geboorte_placenta)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta"
                 priority="1000"
                 mode="M98">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboorte placenta": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboorte placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboorte placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20630" [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboorte placenta": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboorte placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboorte placenta": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('0', '2', '3', '4', 'OTH', 'NI', 'UNK'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboorte placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@code; allowed=('0', '2', '3', '4', 'OTH', 'NI', 'UNK')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboorte placenta": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboorte placenta": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.2.4.4.13.19', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboorte placenta": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboorte placenta": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/bevalling/placenta/geboorte_placenta; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind"
                 priority="1000"
                 mode="M99">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(baring) ge 0) and (count(baring) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(baring) ge 0) and (count(baring) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Baring": <xsl:text/>
                  <xsl:value-of select="count(baring)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]"
                 priority="1000"
                 mode="M100">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring"
                 priority="1000"
                 mode="M101">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring"
                 priority="1000"
                 mode="M102">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(werkelijke_plaats_baring_type_locatie) ge 0) and (count(werkelijke_plaats_baring_type_locatie) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(werkelijke_plaats_baring_type_locatie) ge 0) and (count(werkelijke_plaats_baring_type_locatie) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Werkelijke plaats baring (type locatie)": <xsl:text/>
                  <xsl:value-of select="count(werkelijke_plaats_baring_type_locatie)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(ziekenhuis_baring) ge 0) and (count(ziekenhuis_baring) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(ziekenhuis_baring) ge 0) and (count(ziekenhuis_baring) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Ziekenhuis baring": <xsl:text/>
                  <xsl:value-of select="count(ziekenhuis_baring)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(demografische_gegevens) ge 0) and (count(demografische_gegevens) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(demografische_gegevens) ge 0) and (count(demografische_gegevens) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Demografische gegevens": <xsl:text/>
                  <xsl:value-of select="count(demografische_gegevens)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(kindspecifieke_uitkomstgegevens) ge 0) and (count(kindspecifieke_uitkomstgegevens) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Kindspecifieke uitkomstgegevens": <xsl:text/>
                  <xsl:value-of select="count(kindspecifieke_uitkomstgegevens)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/*[not(self::werkelijke_plaats_baring_type_locatie)][not(self::ziekenhuis_baring)][not(self::demografische_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]"
                 priority="1000"
                 mode="M103">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/*[not(self::werkelijke_plaats_baring_type_locatie)][not(self::ziekenhuis_baring)][not(self::demografische_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie"
                 priority="1000"
                 mode="M104">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40003" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@value; allowed=('1', '2', '3', '4', '5', '6')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('169813005', '23', '22232009', '40', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('169813005', '23', '22232009', '40', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@code; allowed=('169813005', '23', '22232009', '40', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.8.7', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Werkelijke plaats baring (type locatie)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/werkelijke_plaats_baring_type_locatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring"
                 priority="1000"
                 mode="M105">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Ziekenhuis baring": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Ziekenhuis baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Ziekenhuis baring": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82114" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Ziekenhuis baring": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="@*|node()" priority="-2" mode="M105">
      <xsl:apply-templates select="*" mode="M105"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens"
                 priority="1000"
                 mode="M106">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Demografische gegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Demografische gegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Demografische gegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40006" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Demografische gegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="@*|node()" priority="-2" mode="M106">
      <xsl:apply-templates select="*" mode="M106"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"
                 priority="1000"
                 mode="M107">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Kindspecifieke uitkomstgegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="@*|node()" priority="-2" mode="M107">
      <xsl:apply-templates select="*" mode="M107"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring"
                 priority="1000"
                 mode="M108">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(ziekenhuisnummer_lvrid) ge 0) and (count(ziekenhuisnummer_lvrid) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(ziekenhuisnummer_lvrid) ge 0) and (count(ziekenhuisnummer_lvrid) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Ziekenhuisnummer (LVR-id)": <xsl:text/>
                  <xsl:value-of select="count(ziekenhuisnummer_lvrid)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="@*|node()" priority="-2" mode="M108">
      <xsl:apply-templates select="*" mode="M108"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/*[not(self::ziekenhuisnummer_lvrid)][not(self::zorginstelling_agbid)][not(self::naam_zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M109">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/*[not(self::ziekenhuisnummer_lvrid)][not(self::zorginstelling_agbid)][not(self::naam_zorginstelling)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="@*|node()" priority="-2" mode="M109">
      <xsl:apply-templates select="*" mode="M109"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid"
                 priority="1000"
                 mode="M110">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40005" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value; min-length=4]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (string-length(@value) le 4)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (string-length(@value) le 4)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag hoogstens 4 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid/@value; max-length=4]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Ziekenhuisnummer (LVR-id)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/ziekenhuisnummer_lvrid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="@*|node()" priority="-2" mode="M110">
      <xsl:apply-templates select="*" mode="M110"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid"
                 priority="1000"
                 mode="M111">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82116')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82116')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82116" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@value; min-length=8]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 8 karakters bevatten [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid/@value; max-length=8]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling AGB-ID": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/zorginstelling_agbid; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="@*|node()" priority="-2" mode="M111">
      <xsl:apply-templates select="*" mode="M111"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling"
                 priority="1000"
                 mode="M112">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82117')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82117')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82117" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/ziekenhuis_baring/naam_zorginstelling; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="@*|node()" priority="-2" mode="M112">
      <xsl:apply-templates select="*" mode="M112"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens"
                 priority="1000"
                 mode="M113">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(naamgegevens_kind) ge 0) and (count(naamgegevens_kind) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(naamgegevens_kind) ge 0) and (count(naamgegevens_kind) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Naamgegevens kind": <xsl:text/>
                  <xsl:value-of select="count(naamgegevens_kind)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(geslacht_medische_observatie) ge 0) and (count(geslacht_medische_observatie) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(geslacht_medische_observatie) ge 0) and (count(geslacht_medische_observatie) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Geslacht (medische observatie)": <xsl:text/>
                  <xsl:value-of select="count(geslacht_medische_observatie)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(geboortedatum) ge 0) and (count(geboortedatum) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Geboortedatum": <xsl:text/>
                  <xsl:value-of select="count(geboortedatum)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(perinatale_sterfte_groep) ge 0) and (count(perinatale_sterfte_groep) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(perinatale_sterfte_groep) ge 0) and (count(perinatale_sterfte_groep) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Perinatale sterfte (groep)": <xsl:text/>
                  <xsl:value-of select="count(perinatale_sterfte_groep)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M113"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M113"/>
   <xsl:template match="@*|node()" priority="-2" mode="M113">
      <xsl:apply-templates select="*" mode="M113"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/*[not(self::naamgegevens_kind)][not(self::geslacht_medische_observatie)][not(self::geboortedatum)][not(self::perinatale_sterfte_groep)][not(self::adaextension)]"
                 priority="1000"
                 mode="M114">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/*[not(self::naamgegevens_kind)][not(self::geslacht_medische_observatie)][not(self::geboortedatum)][not(self::perinatale_sterfte_groep)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="@*|node()" priority="-2" mode="M114">
      <xsl:apply-templates select="*" mode="M114"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind"
                 priority="1000"
                 mode="M115">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens kind": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naamgegevens kind": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82051')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82051')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Naamgegevens kind": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82051" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naamgegevens kind": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M115"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M115"/>
   <xsl:template match="@*|node()" priority="-2" mode="M115">
      <xsl:apply-templates select="*" mode="M115"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie"
                 priority="1000"
                 mode="M116">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40041" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@value; allowed=('1', '2', '3', '4', '5')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('1', '2', '3', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@code; allowed=('1', '2', '3', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.2.4.4.13.21', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geslacht (medische observatie)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geslacht_medische_observatie; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M116"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M116"/>
   <xsl:template match="@*|node()" priority="-2" mode="M116">
      <xsl:apply-templates select="*" mode="M116"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum"
                 priority="1000"
                 mode="M117">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortedatum": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortedatum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortedatum": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40050" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortedatum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum/@value; type=t-datetime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortedatum": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/geboortedatum; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="@*|node()" priority="-2" mode="M117">
      <xsl:apply-templates select="*" mode="M117"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"
                 priority="1000"
                 mode="M118">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Perinatale sterfte (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Perinatale sterfte (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40279" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Perinatale sterfte (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M118"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M118"/>
   <xsl:template match="@*|node()" priority="-2" mode="M118">
      <xsl:apply-templates select="*" mode="M118"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind"
                 priority="1000"
                 mode="M119">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(voornamen) ge 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(voornamen) ge 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Voornamen": <xsl:text/>
                  <xsl:value-of select="count(voornamen)"/>
                  <xsl:text/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M119"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M119"/>
   <xsl:template match="@*|node()" priority="-2" mode="M119">
      <xsl:apply-templates select="*" mode="M119"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/*[not(self::voornamen)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M120">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/*[not(self::voornamen)][not(self::achternaam)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M120"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M120"/>
   <xsl:template match="@*|node()" priority="-2" mode="M120">
      <xsl:apply-templates select="*" mode="M120"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen"
                 priority="1000"
                 mode="M121">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82353')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82353')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voornamen": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82353" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voornamen": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/voornamen; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M121"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M121"/>
   <xsl:template match="@*|node()" priority="-2" mode="M121">
      <xsl:apply-templates select="*" mode="M121"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam"
                 priority="1000"
                 mode="M122">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82053')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82053')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82053" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M122"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M122"/>
   <xsl:template match="@*|node()" priority="-2" mode="M122">
      <xsl:apply-templates select="*" mode="M122"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam"
                 priority="1000"
                 mode="M123">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam"/>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M123"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M123"/>
   <xsl:template match="@*|node()" priority="-2" mode="M123">
      <xsl:apply-templates select="*" mode="M123"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/*[not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M124">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/*[not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M124"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M124"/>
   <xsl:template match="@*|node()" priority="-2" mode="M124">
      <xsl:apply-templates select="*" mode="M124"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel"
                 priority="1000"
                 mode="M125">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82054')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82054')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Voorvoegsel": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82054" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/voorvoegsel; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M125"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M125"/>
   <xsl:template match="@*|node()" priority="-2" mode="M125">
      <xsl:apply-templates select="*" mode="M125"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam"
                 priority="1000"
                 mode="M126">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82055')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82055')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Achternaam": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82055" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/naamgegevens_kind/achternaam/achternaam; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M126"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M126"/>
   <xsl:template match="@*|node()" priority="-2" mode="M126">
      <xsl:apply-templates select="*" mode="M126"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"
                 priority="1000"
                 mode="M127">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(perinatale_sterfteq) ge 0) and (count(perinatale_sterfteq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(perinatale_sterfteq) ge 0) and (count(perinatale_sterfteq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Perinatale sterfte?": <xsl:text/>
                  <xsl:value-of select="count(perinatale_sterfteq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(fase_perinatale_sterfte) ge 0) and (count(fase_perinatale_sterfte) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(fase_perinatale_sterfte) ge 0) and (count(fase_perinatale_sterfte) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Fase perinatale sterfte": <xsl:text/>
                  <xsl:value-of select="count(fase_perinatale_sterfte)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M127"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M127"/>
   <xsl:template match="@*|node()" priority="-2" mode="M127">
      <xsl:apply-templates select="*" mode="M127"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/*[not(self::perinatale_sterfteq)][not(self::fase_perinatale_sterfte)][not(self::adaextension)]"
                 priority="1000"
                 mode="M128">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/*[not(self::perinatale_sterfteq)][not(self::fase_perinatale_sterfte)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M128"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M128"/>
   <xsl:template match="@*|node()" priority="-2" mode="M128">
      <xsl:apply-templates select="*" mode="M128"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq"
                 priority="1000"
                 mode="M129">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Perinatale sterfte?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Perinatale sterfte?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Perinatale sterfte?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40280" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Perinatale sterfte?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Perinatale sterfte?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/perinatale_sterfteq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M129"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M129"/>
   <xsl:template match="@*|node()" priority="-2" mode="M129">
      <xsl:apply-templates select="*" mode="M129"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte"
                 priority="1000"
                 mode="M130">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40290" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@value; allowed=('1', '2', '3', '4')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('237361005', '237362003', '276506001', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('237361005', '237362003', '276506001', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@code; allowed=('237361005', '237362003', '276506001', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Fase perinatale sterfte": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep/fase_perinatale_sterfte; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M130"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M130"/>
   <xsl:template match="@*|node()" priority="-2" mode="M130">
      <xsl:apply-templates select="*" mode="M130"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"
                 priority="1000"
                 mode="M131">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(type_partus) ge 0) and (count(type_partus) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(type_partus) ge 0) and (count(type_partus) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Type partus": <xsl:text/>
                  <xsl:value-of select="count(type_partus)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(zwangerschapsduur) ge 0) and (count(zwangerschapsduur) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Zwangerschapsduur": <xsl:text/>
                  <xsl:value-of select="count(zwangerschapsduur)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(apgarscore_na_5_min) ge 0) and (count(apgarscore_na_5_min) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Apgarscore na 5 min.": <xsl:text/>
                  <xsl:value-of select="count(apgarscore_na_5_min)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(vaginale_kunstverlossing_groep) ge 0) and (count(vaginale_kunstverlossing_groep) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(vaginale_kunstverlossing_groep) ge 0) and (count(vaginale_kunstverlossing_groep) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Vaginale kunstverlossing (groep)": <xsl:text/>
                  <xsl:value-of select="count(vaginale_kunstverlossing_groep)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(sectio_caesarea_group) ge 0) and (count(sectio_caesarea_group) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(sectio_caesarea_group) ge 0) and (count(sectio_caesarea_group) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Sectio caesarea (group)": <xsl:text/>
                  <xsl:value-of select="count(sectio_caesarea_group)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(overige_interventies) ge 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(overige_interventies) ge 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Overige interventies": <xsl:text/>
                  <xsl:value-of select="count(overige_interventies)"/>
                  <xsl:text/> (verwacht: 0 of meer) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(lichamelijk_onderzoek_kind) ge 0) and (count(lichamelijk_onderzoek_kind) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(lichamelijk_onderzoek_kind) ge 0) and (count(lichamelijk_onderzoek_kind) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Lichamelijk onderzoek kind": <xsl:text/>
                  <xsl:value-of select="count(lichamelijk_onderzoek_kind)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(congenitale_afwijkingenq) ge 0) and (count(congenitale_afwijkingenq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Congenitale afwijkingen?": <xsl:text/>
                  <xsl:value-of select="count(congenitale_afwijkingenq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(congenitale_afwijkingen_groep) ge 0) and (count(congenitale_afwijkingen_groep) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Congenitale afwijkingen (groep)": <xsl:text/>
                  <xsl:value-of select="count(congenitale_afwijkingen_groep)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(bijzonderheden_kind) ge 0) and (count(bijzonderheden_kind) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(bijzonderheden_kind) ge 0) and (count(bijzonderheden_kind) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Bijzonderheden kind": <xsl:text/>
                  <xsl:value-of select="count(bijzonderheden_kind)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M131"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M131"/>
   <xsl:template match="@*|node()" priority="-2" mode="M131">
      <xsl:apply-templates select="*" mode="M131"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::apgarscore_na_5_min)][not(self::vaginale_kunstverlossing_groep)][not(self::sectio_caesarea_group)][not(self::overige_interventies)][not(self::lichamelijk_onderzoek_kind)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)][not(self::bijzonderheden_kind)][not(self::adaextension)]"
                 priority="1000"
                 mode="M132">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::apgarscore_na_5_min)][not(self::vaginale_kunstverlossing_groep)][not(self::sectio_caesarea_group)][not(self::overige_interventies)][not(self::lichamelijk_onderzoek_kind)][not(self::congenitale_afwijkingenq)][not(self::congenitale_afwijkingen_groep)][not(self::bijzonderheden_kind)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M132"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M132"/>
   <xsl:template match="@*|node()" priority="-2" mode="M132">
      <xsl:apply-templates select="*" mode="M132"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"
                 priority="1000"
                 mode="M133">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M133"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M133"/>
   <xsl:template match="@*|node()" priority="-2" mode="M133">
      <xsl:apply-templates select="*" mode="M133"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"
                 priority="1000"
                 mode="M134">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; type=xs:decimal]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; min-inclusive=0]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@unit) or (@unit eq 'd')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@unit) or (@unit eq 'd')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": De waarde "<xsl:text/>
                  <xsl:value-of select="@unit"/>
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M134"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M134"/>
   <xsl:template match="@*|node()" priority="-2" mode="M134">
      <xsl:apply-templates select="*" mode="M134"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"
                 priority="1000"
                 mode="M135">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; type=xs:decimal]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; min-inclusive=0]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (local:decimal-convert(@value) le 10)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (local:decimal-convert(@value) le 10)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" mag maximaal 10 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; max-inclusive=10]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M135"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M135"/>
   <xsl:template match="@*|node()" priority="-2" mode="M135">
      <xsl:apply-templates select="*" mode="M135"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"
                 priority="1000"
                 mode="M136">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M136"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M136"/>
   <xsl:template match="@*|node()" priority="-2" mode="M136">
      <xsl:apply-templates select="*" mode="M136"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"
                 priority="1000"
                 mode="M137">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Sectio caesarea (group)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Sectio caesarea (group)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Sectio caesarea (group)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40219" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Sectio caesarea (group)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M137"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M137"/>
   <xsl:template match="@*|node()" priority="-2" mode="M137">
      <xsl:apply-templates select="*" mode="M137"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies"
                 priority="1000"
                 mode="M138">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Overige interventies": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Overige interventies": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40240" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@value; allowed=('1', '2', '3', '4')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('32189006', '237008007', '40792007', 'OTH'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('32189006', '237008007', '40792007', 'OTH'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Overige interventies": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@code; allowed=('32189006', '237008007', '40792007', 'OTH')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Overige interventies": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Overige interventies": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/overige_interventies; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M138"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M138"/>
   <xsl:template match="@*|node()" priority="-2" mode="M138">
      <xsl:apply-templates select="*" mode="M138"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"
                 priority="1000"
                 mode="M139">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Lichamelijk onderzoek kind": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Lichamelijk onderzoek kind": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M139"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M139"/>
   <xsl:template match="@*|node()" priority="-2" mode="M139">
      <xsl:apply-templates select="*" mode="M139"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq"
                 priority="1000"
                 mode="M140">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40080" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M140"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M140"/>
   <xsl:template match="@*|node()" priority="-2" mode="M140">
      <xsl:apply-templates select="*" mode="M140"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"
                 priority="1000"
                 mode="M141">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40081" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Congenitale afwijkingen (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M141"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M141"/>
   <xsl:template match="@*|node()" priority="-2" mode="M141">
      <xsl:apply-templates select="*" mode="M141"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind"
                 priority="1000"
                 mode="M142">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bijzonderheden kind": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bijzonderheden kind": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80790')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80790')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Bijzonderheden kind": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80790" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bijzonderheden kind": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/bijzonderheden_kind; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M142"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M142"/>
   <xsl:template match="@*|node()" priority="-2" mode="M142">
      <xsl:apply-templates select="*" mode="M142"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"
                 priority="1000"
                 mode="M143">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(vaginale_kunstverlossing) ge 0) and (count(vaginale_kunstverlossing) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Vaginale kunstverlossing": <xsl:text/>
                  <xsl:value-of select="count(vaginale_kunstverlossing)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M143"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M143"/>
   <xsl:template match="@*|node()" priority="-2" mode="M143">
      <xsl:apply-templates select="*" mode="M143"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]"
                 priority="1000"
                 mode="M144">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M144"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M144"/>
   <xsl:template match="@*|node()" priority="-2" mode="M144">
      <xsl:apply-templates select="*" mode="M144"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"
                 priority="1000"
                 mode="M145">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M145"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M145"/>
   <xsl:template match="@*|node()" priority="-2" mode="M145">
      <xsl:apply-templates select="*" mode="M145"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"
                 priority="1000"
                 mode="M146">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(beslismoment_sectio_caesarea) ge 0) and (count(beslismoment_sectio_caesarea) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(beslismoment_sectio_caesarea) ge 0) and (count(beslismoment_sectio_caesarea) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Beslismoment sectio caesarea": <xsl:text/>
                  <xsl:value-of select="count(beslismoment_sectio_caesarea)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(indicatie_sectio_caesarea) ge 0) and (count(indicatie_sectio_caesarea) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(indicatie_sectio_caesarea) ge 0) and (count(indicatie_sectio_caesarea) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Indicatie sectio caesarea": <xsl:text/>
                  <xsl:value-of select="count(indicatie_sectio_caesarea)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M146"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M146"/>
   <xsl:template match="@*|node()" priority="-2" mode="M146">
      <xsl:apply-templates select="*" mode="M146"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/*[not(self::beslismoment_sectio_caesarea)][not(self::indicatie_sectio_caesarea)][not(self::adaextension)]"
                 priority="1000"
                 mode="M147">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/*[not(self::beslismoment_sectio_caesarea)][not(self::indicatie_sectio_caesarea)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M147"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M147"/>
   <xsl:template match="@*|node()" priority="-2" mode="M147">
      <xsl:apply-templates select="*" mode="M147"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea"
                 priority="1000"
                 mode="M148">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40225" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@value; allowed=('1', '2', '3')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('2', '3', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('2', '3', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@code; allowed=('2', '3', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@codeSystem; allowed=('2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.2.4.3.22.1.3.5', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Beslismoment sectio caesarea": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/beslismoment_sectio_caesarea; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M148"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M148"/>
   <xsl:template match="@*|node()" priority="-2" mode="M148">
      <xsl:apply-templates select="*" mode="M148"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea"
                 priority="1000"
                 mode="M149">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40230" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@code; allowed=('312850006:246090004=10217006', '312850006:24609004=399031001', '15028002', '237320005', '249166003', '444433005:246090004=130955003', '418138009', '408854000', 'E', 'F', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.2.4.3.22.1.2.55', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Indicatie sectio caesarea": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/sectio_caesarea_group/indicatie_sectio_caesarea; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M149"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M149"/>
   <xsl:template match="@*|node()" priority="-2" mode="M149">
      <xsl:apply-templates select="*" mode="M149"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"
                 priority="1000"
                 mode="M150">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(geboortegewicht) ge 0) and (count(geboortegewicht) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Geboortegewicht": <xsl:text/>
                  <xsl:value-of select="count(geboortegewicht)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(percentiel_van_het_geboortegewicht) ge 0) and (count(percentiel_van_het_geboortegewicht) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(percentiel_van_het_geboortegewicht) ge 0) and (count(percentiel_van_het_geboortegewicht) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Percentiel van het geboortegewicht": <xsl:text/>
                  <xsl:value-of select="count(percentiel_van_het_geboortegewicht)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M150"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M150"/>
   <xsl:template match="@*|node()" priority="-2" mode="M150">
      <xsl:apply-templates select="*" mode="M150"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::percentiel_van_het_geboortegewicht)][not(self::adaextension)]"
                 priority="1000"
                 mode="M151">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::percentiel_van_het_geboortegewicht)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M151"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M151"/>
   <xsl:template match="@*|node()" priority="-2" mode="M151">
      <xsl:apply-templates select="*" mode="M151"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"
                 priority="1000"
                 mode="M152">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortegewicht": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; type=xs:decimal]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; min-inclusive=0]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": Attribuut "unit" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@unit) or (@unit eq 'gram')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@unit) or (@unit eq 'gram')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@unit"/>
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht; allowed=(@conceptId, @value, @unit, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M152"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M152"/>
   <xsl:template match="@*|node()" priority="-2" mode="M152">
      <xsl:apply-templates select="*" mode="M152"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht"
                 priority="1000"
                 mode="M153">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80670')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80670')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80670" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('1', '2', '3', '4', '5', '6', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@code; allowed=('1', '2', '3', '4', '5', '6', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.2.4.4.13.50', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Percentiel van het geboortegewicht": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/percentiel_van_het_geboortegewicht; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M153"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M153"/>
   <xsl:template match="@*|node()" priority="-2" mode="M153">
      <xsl:apply-templates select="*" mode="M153"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"
                 priority="1000"
                 mode="M154">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(specificatie_congenitale_afwijking_groep) ge 0) and (count(specificatie_congenitale_afwijking_groep) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(specificatie_congenitale_afwijking_groep) ge 0) and (count(specificatie_congenitale_afwijking_groep) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Specificatie congenitale afwijking (groep)": <xsl:text/>
                  <xsl:value-of select="count(specificatie_congenitale_afwijking_groep)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(chromosomale_afwijkingenq) ge 0) and (count(chromosomale_afwijkingenq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Chromosomale afwijkingen?": <xsl:text/>
                  <xsl:value-of select="count(chromosomale_afwijkingenq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(specificatie_chromosomale_afwijking_groep) ge 0) and (count(specificatie_chromosomale_afwijking_groep) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(specificatie_chromosomale_afwijking_groep) ge 0) and (count(specificatie_chromosomale_afwijking_groep) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Specificatie chromosomale afwijking (groep)": <xsl:text/>
                  <xsl:value-of select="count(specificatie_chromosomale_afwijking_groep)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M154"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M154"/>
   <xsl:template match="@*|node()" priority="-2" mode="M154">
      <xsl:apply-templates select="*" mode="M154"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/*[not(self::specificatie_congenitale_afwijking_groep)][not(self::chromosomale_afwijkingenq)][not(self::specificatie_chromosomale_afwijking_groep)][not(self::adaextension)]"
                 priority="1000"
                 mode="M155">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/*[not(self::specificatie_congenitale_afwijking_groep)][not(self::chromosomale_afwijkingenq)][not(self::specificatie_chromosomale_afwijking_groep)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M155"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M155"/>
   <xsl:template match="@*|node()" priority="-2" mode="M155">
      <xsl:apply-templates select="*" mode="M155"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"
                 priority="1000"
                 mode="M156">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40082" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M156"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M156"/>
   <xsl:template match="@*|node()" priority="-2" mode="M156">
      <xsl:apply-templates select="*" mode="M156"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"
                 priority="1000"
                 mode="M157">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Chromosomale afwijkingen?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40110" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Chromosomale afwijkingen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Chromosomale afwijkingen?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/chromosomale_afwijkingenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M157"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M157"/>
   <xsl:template match="@*|node()" priority="-2" mode="M157">
      <xsl:apply-templates select="*" mode="M157"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"
                 priority="1000"
                 mode="M158">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40111" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking (groep)": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M158"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M158"/>
   <xsl:template match="@*|node()" priority="-2" mode="M158">
      <xsl:apply-templates select="*" mode="M158"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"
                 priority="1000"
                 mode="M159">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(specificatie_congenitale_afwijking) ge 0) and (count(specificatie_congenitale_afwijking) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(specificatie_congenitale_afwijking) ge 0) and (count(specificatie_congenitale_afwijking) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Specificatie congenitale afwijking": <xsl:text/>
                  <xsl:value-of select="count(specificatie_congenitale_afwijking)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M159"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M159"/>
   <xsl:template match="@*|node()" priority="-2" mode="M159">
      <xsl:apply-templates select="*" mode="M159"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/*[not(self::specificatie_congenitale_afwijking)][not(self::adaextension)]"
                 priority="1000"
                 mode="M160">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/*[not(self::specificatie_congenitale_afwijking)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M160"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M160"/>
   <xsl:template match="@*|node()" priority="-2" mode="M160">
      <xsl:apply-templates select="*" mode="M160"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking"
                 priority="1000"
                 mode="M161">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40090" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@value; allowed=('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@code; allowed=('88425004', '609417004', '431265009', '76916001', '414667000', '171131006', '47032000', '30915001', '55999004', '363222009', '09', 'B', '19416009', '61142002', '11', '8380000', '13', '9904008', '204470001', '204296002', '86299006', '30288003', '62067003', '7305005', '4374004', '94702005', '22', '95470009', '80281008', '87979003', '69771008', '84296002', '204711007', '204712000', '204739008', '29980002', '9707006', '30', '77868001', '204508009', '14532008', '80825009', '66987001', '111318005', '79231000', '83035003', '17190001', '21524000', '38', '287085006', '416010008', '406476007', '204878001', '61758007', '41962002', '82525005', '7163005', '39179006', '69', '199879009', '93471006', '398943008', '74', '81336004', '72951007', '18735004', '396347007', '429200006', '85', '73573004', '367506006', '373413006', '302297009', '45806008', '77595004', '96', '36172001', '98', 'J', '276720006', '43876007', '444406006', '82354003', '104', 'K', '217710005', '86095007', '112', '363346000:246454002=255399007', 'OTH', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.8', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie congenitale afwijking": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_congenitale_afwijking_groep/specificatie_congenitale_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M161"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M161"/>
   <xsl:template match="@*|node()" priority="-2" mode="M161">
      <xsl:apply-templates select="*" mode="M161"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"
                 priority="1000"
                 mode="M162">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(specificatie_chromosomale_afwijking) ge 0) and (count(specificatie_chromosomale_afwijking) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(specificatie_chromosomale_afwijking) ge 0) and (count(specificatie_chromosomale_afwijking) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Specificatie chromosomale afwijking": <xsl:text/>
                  <xsl:value-of select="count(specificatie_chromosomale_afwijking)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M162"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M162"/>
   <xsl:template match="@*|node()" priority="-2" mode="M162">
      <xsl:apply-templates select="*" mode="M162"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/*[not(self::specificatie_chromosomale_afwijking)][not(self::adaextension)]"
                 priority="1000"
                 mode="M163">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/*[not(self::specificatie_chromosomale_afwijking)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M163"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M163"/>
   <xsl:template match="@*|node()" priority="-2" mode="M163">
      <xsl:apply-templates select="*" mode="M163"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking"
                 priority="1000"
                 mode="M164">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40120" [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "value" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@value]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '3', '4', '5', '6', '7'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@value; allowed=('1', '2', '3', '4', '5', '6', '7')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "code" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@code]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@code) or (@code = ('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@code) or (@code = ('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@code"/>
                  <xsl:text/>" voor attribuut "code" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@code; allowed=('41040004', '51500006', '21111006', '7', 'OTH', 'UNK', 'NI')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "codeSystem" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@codeSystem]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@codeSystem) or (@codeSystem = ('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": De waarde "<xsl:text/>
                  <xsl:value-of select="@codeSystem"/>
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.2.4.4.13.22', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": Attribuut "displayName" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking/@displayName]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Specificatie chromosomale afwijking": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/congenitale_afwijkingen_groep/specificatie_chromosomale_afwijking_groep/specificatie_chromosomale_afwijking; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M164"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M164"/>
   <xsl:template match="@*|node()" priority="-2" mode="M164">
      <xsl:apply-templates select="*" mode="M164"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek"
                 priority="1000"
                 mode="M165">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek"/>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M165"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M165"/>
   <xsl:template match="@*|node()" priority="-2" mode="M165">
      <xsl:apply-templates select="*" mode="M165"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]"
                 priority="1000"
                 mode="M166">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/*[not(self::maternale_onderzoeksgegevens)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M166"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M166"/>
   <xsl:template match="@*|node()" priority="-2" mode="M166">
      <xsl:apply-templates select="*" mode="M166"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens"
                 priority="1000"
                 mode="M167">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.142" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Maternale onderzoeksgegevens": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M167"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M167"/>
   <xsl:template match="@*|node()" priority="-2" mode="M167">
      <xsl:apply-templates select="*" mode="M167"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens"
                 priority="1000"
                 mode="M168">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens"/>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M168"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M168"/>
   <xsl:template match="@*|node()" priority="-2" mode="M168">
      <xsl:apply-templates select="*" mode="M168"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]"
                 priority="1000"
                 mode="M169">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/*[not(self::urine_bloed_en_aanvullende_onderzoeken)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M169"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M169"/>
   <xsl:template match="@*|node()" priority="-2" mode="M169">
      <xsl:apply-templates select="*" mode="M169"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"
                 priority="1000"
                 mode="M170">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80959" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Urine-, bloed- en aanvullende onderzoeken": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M170"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M170"/>
   <xsl:template match="@*|node()" priority="-2" mode="M170">
      <xsl:apply-templates select="*" mode="M170"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"
                 priority="1000"
                 mode="M171">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(psie) ge 0) and (count(psie) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(psie) ge 0) and (count(psie) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "PSIE": <xsl:text/>
                  <xsl:value-of select="count(psie)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M171"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M171"/>
   <xsl:template match="@*|node()" priority="-2" mode="M171">
      <xsl:apply-templates select="*" mode="M171"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::psie)][not(self::adaextension)]"
                 priority="1000"
                 mode="M172">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/*[not(self::psie)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M172"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M172"/>
   <xsl:template match="@*|node()" priority="-2" mode="M172">
      <xsl:apply-templates select="*" mode="M172"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"
                 priority="1000"
                 mode="M173">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "PSIE": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "PSIE": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "PSIE": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80949" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "PSIE": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie; allowed=(@conceptId, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M173"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M173"/>
   <xsl:template match="@*|node()" priority="-2" mode="M173">
      <xsl:apply-templates select="*" mode="M173"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"
                 priority="1000"
                 mode="M174">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(irregulaire_antistoffenq) ge 0) and (count(irregulaire_antistoffenq) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Irregulaire antistoffen?": <xsl:text/>
                  <xsl:value-of select="count(irregulaire_antistoffenq)"/>
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/adaextension]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M174"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M174"/>
   <xsl:template match="@*|node()" priority="-2" mode="M174">
      <xsl:apply-templates select="*" mode="M174"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/*[not(self::irregulaire_antistoffenq)][not(self::adaextension)]"
                 priority="1000"
                 mode="M175">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/*[not(self::irregulaire_antistoffenq)][not(self::adaextension)]"/>
      <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M175"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M175"/>
   <xsl:template match="@*|node()" priority="-2" mode="M175">
      <xsl:apply-templates select="*" mode="M175"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq"
                 priority="1000"
                 mode="M176">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@conceptId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@conceptId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Irregulaire antistoffen?": Attribuut "conceptId" ontbreekt [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10812" [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value castable as xs:boolean)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value castable as xs:boolean)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Irregulaire antistoffen?": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq/@value; type=xs:boolean]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Irregulaire antistoffen?": Ongeldige attributen aangetroffen [/voorgaande_zwangerschap_samenvatting_22/medisch_onderzoek/maternale_onderzoeksgegevens/urine_bloed_en_aanvullende_onderzoeken/psie/irregulaire_antistoffenq; allowed=(@conceptId, @value, @nullFlavor, @root, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M176"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M176"/>
   <xsl:template match="@*|node()" priority="-2" mode="M176">
      <xsl:apply-templates select="*" mode="M176"/>
   </xsl:template>
</xsl:stylesheet>
