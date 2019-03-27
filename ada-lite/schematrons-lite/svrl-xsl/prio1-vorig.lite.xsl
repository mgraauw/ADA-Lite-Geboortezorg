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
This program is free software; you can redistribute it and/or modify it under the terms 
of the GNU Affero General Public License as published by the Free Software Foundation; 
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU Affero General Public Licensefor more details.

See http://www.gnu.org/licenses/
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
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/" priority="1000" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(prio1_vorig) eq 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(prio1_vorig) eq 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Prio1 vorig": <xsl:text/>
                  <xsl:value-of select="count(prio1_vorig)"/>
                  <xsl:text/> (verwacht: 1) [/prio1_vorig]</svrl:text>
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
   <xsl:template match="/prio1_vorig" priority="1000" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_vorig"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="exists(@transactionRef)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@transactionRef)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 vorig": Attribuut "transactionRef" ontbreekt [/prio1_vorig/@transactionRef]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 vorig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft een onjuist formaat [/prio1_vorig/@transactionRef; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2456')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionRef) or (@transactionRef eq '2.16.840.1.113883.2.4.3.11.60.90.77.4.2456')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 vorig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionRef"/>
                  <xsl:text/>" voor attribuut "transactionRef" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.4.2456" [/prio1_vorig/@transactionRef]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 vorig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft een onjuist formaat [/prio1_vorig/@transactionEffectiveDate; type=xs:dateTime]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2019-02-20T11:05:00')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@transactionEffectiveDate) or (@transactionEffectiveDate eq '2019-02-20T11:05:00')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Prio1 vorig": De waarde "<xsl:text/>
                  <xsl:value-of select="@transactionEffectiveDate"/>
                  <xsl:text/>" voor attribuut "transactionEffectiveDate" heeft niet de verwachte vaste waarde "2019-02-20T11:05:00" [/prio1_vorig/@transactionEffectiveDate]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 vorig": De waarde "<xsl:text/>
                  <xsl:value-of select="@versionDate"/>
                  <xsl:text/>" voor attribuut "versionDate" heeft een onjuist formaat [/prio1_vorig/@versionDate; type=xs:dateTime]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Prio1 vorig": Ongeldige attributen aangetroffen [/prio1_vorig; allowed=(@transactionRef, @transactionEffectiveDate, @versionDate, @prefix, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_vorig"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/prio1_vorig/vrouw]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(uitkomst_per_kind) ge 0) and (count(uitkomst_per_kind) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(uitkomst_per_kind) ge 0) and (count(uitkomst_per_kind) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Uitkomst (per kind)": <xsl:text/>
                  <xsl:value-of select="count(uitkomst_per_kind)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::adaextension)]"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/*[not(self::zorgverlenerzorginstelling)][not(self::vrouw)][not(self::zwangerschap)][not(self::bevalling)][not(self::uitkomst_per_kind)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.1" [/prio1_vorig/zorgverlenerzorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener/Zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw" priority="1000" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_vorig/vrouw"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.2" [/prio1_vorig/vrouw/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vrouw": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap" priority="1000" mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.3" [/prio1_vorig/zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling" priority="1000" mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.6" [/prio1_vorig/bevalling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Bevalling": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind" priority="1000" mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.7" [/prio1_vorig/uitkomst_per_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Uitkomst (per kind)": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/*[not(self::zorgverlener)][not(self::zorginstelling)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/zorgverlenerzorginstelling/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10001" [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorgverlener": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10020" [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)][not(self::adaextension)]"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/*[not(self::naam_zorgverlener)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10006" [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": Attribuut "value" ontbreekt [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorgverlener": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorgverlener/naam_zorgverlener; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling"/>

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
                  <xsl:text/> (verwacht: 1) [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)][not(self::adaextension)]"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/*[not(self::naam_zorginstelling)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10026" [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Attribuut "value" ontbreekt [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naam zorginstelling": Ongeldige attributen aangetroffen [/prio1_vorig/zorgverlenerzorginstelling/zorginstelling/naam_zorginstelling; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw" priority="1000" mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/prio1_vorig/vrouw"/>

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
                  <xsl:text/> (verwacht: 1) [/prio1_vorig/vrouw/burgerservicenummer]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::adaextension)]"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/*[not(self::burgerservicenummer)][not(self::naamgegevens)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/vrouw/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/vrouw/burgerservicenummer"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/burgerservicenummer"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/burgerservicenummer/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10030" [/prio1_vorig/vrouw/burgerservicenummer/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/burgerservicenummer/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minstens 9 karakters bevatten [/prio1_vorig/vrouw/burgerservicenummer/@value; min-length=9]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag hoogstens 9 karakters bevatten [/prio1_vorig/vrouw/burgerservicenummer/@value; max-length=9]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Burgerservicenummer": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/burgerservicenummer; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens" priority="1000" mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10035" [/prio1_vorig/vrouw/naamgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Naamgegevens": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens" priority="1000" mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/roepnaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/*[not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/*[not(self::roepnaam)][not(self::achternaam)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/vrouw/naamgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/roepnaam"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/roepnaam"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/roepnaam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82360" [/prio1_vorig/vrouw/naamgegevens/roepnaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Roepnaam": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/naamgegevens/roepnaam/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Roepnaam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/roepnaam; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/achternaam"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82361" [/prio1_vorig/vrouw/naamgegevens/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/achternaam"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/achternaam"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/vrouw/naamgegevens/achternaam/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/achternaam/*[not(self::soort_naam)][not(self::voorvoegsel)][not(self::achternaam)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/vrouw/naamgegevens/achternaam/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82362" [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@conceptId]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@value; allowed=('BR', 'SP')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@code; allowed=('BR', 'SP')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@codeSystem; allowed=('2.16.840.1.113883.5.43', '2.16.840.1.113883.5.43')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@displayName; allowed=('Geslachtsnaam', 'Geslachtsnaam partner')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('geslachtsnaam', 'geslachtsnaam_partner'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('geslachtsnaam', 'geslachtsnaam_partner'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Soort naam": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam/@enum; allowed=('geslachtsnaam', 'geslachtsnaam_partner')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Soort naam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam/soort_naam; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82363" [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Voorvoegsel": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam/voorvoegsel; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.10043" [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Attribuut "value" ontbreekt [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Achternaam": Ongeldige attributen aangetroffen [/prio1_vorig/vrouw/naamgegevens/achternaam/achternaam; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap" priority="1000" mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/graviditeit]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap]</svrl:text>
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
                  <xsl:text/> (verwacht: 1) [/prio1_vorig/zwangerschap/a_terme_datum_groep]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/datum_einde_zwangerschap]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::a_terme_datum_groep)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/*[not(self::graviditeit)][not(self::pariteit_voor_deze_zwangerschap)][not(self::a_terme_datum_groep)][not(self::wijze_einde_zwangerschap)][not(self::datum_einde_zwangerschap)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/zwangerschap/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/zwangerschap/graviditeit"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/graviditeit"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/graviditeit/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20010" [/prio1_vorig/zwangerschap/graviditeit/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Graviditeit": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/graviditeit/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/zwangerschap/graviditeit/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 1 zijn [/prio1_vorig/zwangerschap/graviditeit/@value; min-inclusive=1]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag maximaal 75 zijn [/prio1_vorig/zwangerschap/graviditeit/@value; max-inclusive=75]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Graviditeit": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/graviditeit; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20150" [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value; min-inclusive=0]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag maximaal 30 zijn [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap/@value; max-inclusive=30]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Pariteit (vóór deze zwangerschap)": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/pariteit_voor_deze_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/a_terme_datum_groep"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/a_terme_datum_groep"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/a_terme_datum_groep/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20029" [/prio1_vorig/zwangerschap/a_terme_datum_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "A terme datum (groep)": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/a_terme_datum_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/wijze_einde_zwangerschap"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/wijze_einde_zwangerschap"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80625" [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@value; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@code; allowed=('1', '2', '21', '22', '23', '3', '31', '32', '4', '5', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@codeSystem; allowed=('2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.2.4.4.13.46', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@displayName; allowed=('Partus', 'Miskraam', 'Spontaan', 'Medicamenteus', 'Instrumenteel', 'APLA', 'Medicamenteus', 'Instrumenteel', 'EUG - behandeld', '(partiële) Mola - behandeld', 'geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('partus', 'miskraam', 'spontaan', 'medicamenteus', 'instrumenteel', 'apla', 'medicamenteus', 'instrumenteel', 'eug__behandeld', 'partiele_mola__behandeld', 'geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('partus', 'miskraam', 'spontaan', 'medicamenteus', 'instrumenteel', 'apla', 'medicamenteus', 'instrumenteel', 'eug__behandeld', 'partiele_mola__behandeld', 'geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap/@enum; allowed=('partus', 'miskraam', 'spontaan', 'medicamenteus', 'instrumenteel', 'apla', 'medicamenteus', 'instrumenteel', 'eug__behandeld', 'partiele_mola__behandeld', 'geen_informatie')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Wijze einde zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/wijze_einde_zwangerschap; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/datum_einde_zwangerschap"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/datum_einde_zwangerschap"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/datum_einde_zwangerschap/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20540" [/prio1_vorig/zwangerschap/datum_einde_zwangerschap/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/datum_einde_zwangerschap/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Datum einde zwangerschap": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/datum_einde_zwangerschap; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/a_terme_datum_groep"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/a_terme_datum_groep"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(a_terme_datum) ge 0) and (count(a_terme_datum) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(a_terme_datum) ge 0) and (count(a_terme_datum) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "A terme datum": <xsl:text/>
                  <xsl:value-of select="count(a_terme_datum)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/zwangerschap/a_terme_datum_groep/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/a_terme_datum_groep/*[not(self::a_terme_datum)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/zwangerschap/a_terme_datum_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20030" [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "A terme datum": Attribuut "value" ontbreekt [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum/@value]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "A terme datum": Ongeldige attributen aangetroffen [/prio1_vorig/zwangerschap/a_terme_datum_groep/a_terme_datum; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling" priority="1000" mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling/diagnose_bevalling]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling/hoeveelheid_bloedverlies]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling/conditie_perineum_postpartum]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling/*[not(self::diagnose_bevalling)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/*[not(self::diagnose_bevalling)][not(self::hoeveelheid_bloedverlies)][not(self::conditie_perineum_postpartum)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/bevalling/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/bevalling/diagnose_bevalling"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/diagnose_bevalling"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/diagnose_bevalling/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82291" [/prio1_vorig/bevalling/diagnose_bevalling/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Diagnose bevalling": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/diagnose_bevalling; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling/hoeveelheid_bloedverlies"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/hoeveelheid_bloedverlies"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20640" [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": Attribuut "value" ontbreekt [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "ml" [/prio1_vorig/bevalling/hoeveelheid_bloedverlies/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Hoeveelheid bloedverlies": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/hoeveelheid_bloedverlies; allowed=(@conceptId, @value, @unit, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling/conditie_perineum_postpartum"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/conditie_perineum_postpartum"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/conditie_perineum_postpartum/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80673" [/prio1_vorig/bevalling/conditie_perineum_postpartum/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@value; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@code; allowed=('289854007', '199916005', '199925004', '199930000', '449807005', '449808000', '449809008', '199934009', '609344008', 'OTH', 'UNK', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Perineum intact  (finding)', 'First degree perineal tear during delivery - delivered (disorder)', 'Second degree perineal tear during delivery - delivered  (disorder)', 'Third degree perineal tear during delivery - delivered  (disorder)', 'Type 3a third degree laceration of perineum  (disorder)', 'Type 3b third degree laceration of perineum (disorder)', 'Type 3c third degree laceration of perineum (disorder)', 'Fourth degree perineal tear during delivery - delivered  (disorder)', 'Episiotomy wound  (morphologic abnormality)', 'Anders', 'Onbekend', 'Geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Perineum intact (finding)', 'First degree perineal tear during delivery - delivered (disorder)', 'Second degree perineal tear during delivery - delivered (disorder)', 'Third degree perineal tear during delivery - delivered (disorder)', 'Type 3a third degree laceration of perineum (disorder)', 'Type 3b third degree laceration of perineum (disorder)', 'Type 3c third degree laceration of perineum (disorder)', 'Fourth degree perineal tear during delivery - delivered (disorder)', 'Episiotomy wound (morphologic abnormality)', 'Anders', 'Onbekend', 'Geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@displayName; allowed=('Perineum intact  (finding)', 'First degree perineal tear during delivery - delivered (disorder)', 'Second degree perineal tear during delivery - delivered  (disorder)', 'Third degree perineal tear during delivery - delivered  (disorder)', 'Type 3a third degree laceration of perineum  (disorder)', 'Type 3b third degree laceration of perineum (disorder)', 'Type 3c third degree laceration of perineum (disorder)', 'Fourth degree perineal tear during delivery - delivered  (disorder)', 'Episiotomy wound  (morphologic abnormality)', 'Anders', 'Onbekend', 'Geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('perineum_intact_finding', 'first_degree_perineal_tear_during_delivery__delivered_disorder', 'second_degree_perineal_tear_during_delivery__delivered_disorder', 'third_degree_perineal_tear_during_delivery__delivered_disorder', 'type_3a_third_degree_laceration_of_perineum_disorder', 'type_3b_third_degree_laceration_of_perineum_disorder', 'type_3c_third_degree_laceration_of_perineum_disorder', 'fourth_degree_perineal_tear_during_delivery__delivered_disorder', 'episiotomy_wound_morphologic_abnormality', 'anders', 'onbekend', 'geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('perineum_intact_finding', 'first_degree_perineal_tear_during_delivery__delivered_disorder', 'second_degree_perineal_tear_during_delivery__delivered_disorder', 'third_degree_perineal_tear_during_delivery__delivered_disorder', 'type_3a_third_degree_laceration_of_perineum_disorder', 'type_3b_third_degree_laceration_of_perineum_disorder', 'type_3c_third_degree_laceration_of_perineum_disorder', 'fourth_degree_perineal_tear_during_delivery__delivered_disorder', 'episiotomy_wound_morphologic_abnormality', 'anders', 'onbekend', 'geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_vorig/bevalling/conditie_perineum_postpartum/@enum; allowed=('perineum_intact_finding', 'first_degree_perineal_tear_during_delivery__delivered_disorder', 'second_degree_perineal_tear_during_delivery__delivered_disorder', 'third_degree_perineal_tear_during_delivery__delivered_disorder', 'type_3a_third_degree_laceration_of_perineum_disorder', 'type_3b_third_degree_laceration_of_perineum_disorder', 'type_3c_third_degree_laceration_of_perineum_disorder', 'fourth_degree_perineal_tear_during_delivery__delivered_disorder', 'episiotomy_wound_morphologic_abnormality', 'anders', 'onbekend', 'geen_informatie')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Conditie perineum postpartum": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/conditie_perineum_postpartum; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling/diagnose_bevalling"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/diagnose_bevalling"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/bevalling/diagnose_bevalling/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/bevalling/diagnose_bevalling/*[not(self::zwangerschapsduur)][not(self::adaextension)]"
                 priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/diagnose_bevalling/*[not(self::zwangerschapsduur)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/bevalling/diagnose_bevalling/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.82382" [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/prio1_vorig/bevalling/diagnose_bevalling/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind" priority="1000" mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]"
                 priority="1000"
                 mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/*[not(self::baring)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/uitkomst_per_kind/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring"
                 priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40002" [/prio1_vorig/uitkomst_per_kind/baring/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Baring": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring"
                 priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(kindspecifieke_maternale_gegevens) ge 0) and (count(kindspecifieke_maternale_gegevens) le 1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(kindspecifieke_maternale_gegevens) ge 0) and (count(kindspecifieke_maternale_gegevens) le 1)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Fout aantal voorkomens van "Kindspecifieke maternale gegevens": <xsl:text/>
                  <xsl:value-of select="count(kindspecifieke_maternale_gegevens)"/>
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/*[not(self::kindspecifieke_maternale_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]"
                 priority="1000"
                 mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/*[not(self::kindspecifieke_maternale_gegevens)][not(self::kindspecifieke_uitkomstgegevens)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/uitkomst_per_kind/baring/<xsl:text/>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"
                 priority="1000"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or matches(@conceptId, '^([0-9]+\.)+([0-9]+)$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId; type=t-id]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@conceptId) or (@conceptId eq '2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Kindspecifieke maternale gegevens": De waarde "<xsl:text/>
                  <xsl:value-of select="@conceptId"/>
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.71" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Kindspecifieke maternale gegevens": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"
                 priority="1000"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.72" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Kindspecifieke uitkomstgegevens": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"
                 priority="1000"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/*[not(self::adaextension)]"
                 priority="1000"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/*[not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_maternale_gegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"
                 priority="1000"
                 mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::apgarscore_na_5_min)][not(self::vaginale_kunstverlossing_groep)][not(self::lichamelijk_onderzoek_kind)][not(self::adaextension)]"
                 priority="1000"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/*[not(self::type_partus)][not(self::zwangerschapsduur)][not(self::apgarscore_na_5_min)][not(self::vaginale_kunstverlossing_groep)][not(self::lichamelijk_onderzoek_kind)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"
                 priority="1000"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80626" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@value; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@code; allowed=('48782003', '8561000146109', '200146002', '200148001', '200149009', '39406005', 'UNK', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@displayName; allowed=('Delivery normal (finding)', 'Assisted delivery of fetus (finding)', 'Cesarean delivery - delivered (finding)', 'Delivery by elective cesarean section (finding)', 'Delivery by emergency cesarean section (finding)', 'Legally induced abortion (disorder)', 'onbekend', 'geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('delivery_normal_finding', 'assisted_delivery_of_fetus_finding', 'cesarean_delivery__delivered_finding', 'delivery_by_elective_cesarean_section_finding', 'delivery_by_emergency_cesarean_section_finding', 'legally_induced_abortion_disorder', 'onbekend', 'geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('delivery_normal_finding', 'assisted_delivery_of_fetus_finding', 'cesarean_delivery__delivered_finding', 'delivery_by_elective_cesarean_section_finding', 'delivery_by_emergency_cesarean_section_finding', 'legally_induced_abortion_disorder', 'onbekend', 'geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Type partus": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus/@enum; allowed=('delivery_normal_finding', 'assisted_delivery_of_fetus_finding', 'cesarean_delivery__delivered_finding', 'delivery_by_elective_cesarean_section_finding', 'delivery_by_emergency_cesarean_section_finding', 'legally_induced_abortion_disorder', 'onbekend', 'geen_informatie')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Type partus": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/type_partus; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.20062" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Attribuut "value" ontbreekt [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@value; min-inclusive=0]</svrl:text>
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
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "d" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Zwangerschapsduur": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/zwangerschapsduur; allowed=(@conceptId, @value, @unit, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"
                 priority="1000"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40071" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": Attribuut "value" ontbreekt [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; min-inclusive=0]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" mag maximaal 10 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min/@value; max-inclusive=10]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Apgarscore na 5 min.": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/apgarscore_na_5_min; allowed=(@conceptId, @value, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"
                 priority="1000"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40189" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing (groep)": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"
                 priority="1000"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.80766" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Lichamelijk onderzoek kind": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind; allowed=(@conceptId, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"
                 priority="1000"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]"
                 priority="1000"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/*[not(self::vaginale_kunstverlossing)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"
                 priority="1000"
                 mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40190" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@conceptId]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@value) or (@value = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@value) or (@value = ('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@value"/>
                  <xsl:text/>" voor attribuut "value" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@value; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "code" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@code; allowed=('302383004', '61586001', '699999008', '359940006', '416055001', 'OTH', 'NI')]</svrl:text>
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
                  <xsl:text/>" voor attribuut "codeSystem" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@codeSystem; allowed=('2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.6.96', '2.16.840.1.113883.5.1008', '2.16.840.1.113883.5.1008')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@displayName) or (@displayName = ('Forceps delivery (procedure)', 'Delivery by vacuum extraction (procedure)', 'Obstetrical version with extraction (procedure)', 'Partial breech extraction (procedure)', 'Total breech extraction (procedure)', 'anders', 'geen informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@displayName) or (@displayName = ('Forceps delivery (procedure)', 'Delivery by vacuum extraction (procedure)', 'Obstetrical version with extraction (procedure)', 'Partial breech extraction (procedure)', 'Total breech extraction (procedure)', 'anders', 'geen informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@displayName"/>
                  <xsl:text/>" voor attribuut "displayName" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@displayName; allowed=('Forceps delivery (procedure)', 'Delivery by vacuum extraction (procedure)', 'Obstetrical version with extraction (procedure)', 'Partial breech extraction (procedure)', 'Total breech extraction (procedure)', 'anders', 'geen informatie')]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="empty(@enum) or (@enum = ('forceps_delivery_procedure', 'delivery_by_vacuum_extraction_procedure', 'obstetrical_version_with_extraction_procedure', 'partial_breech_extraction_procedure', 'total_breech_extraction_procedure', 'anders', 'geen_informatie'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@enum) or (@enum = ('forceps_delivery_procedure', 'delivery_by_vacuum_extraction_procedure', 'obstetrical_version_with_extraction_procedure', 'partial_breech_extraction_procedure', 'total_breech_extraction_procedure', 'anders', 'geen_informatie'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": De waarde "<xsl:text/>
                  <xsl:value-of select="@enum"/>
                  <xsl:text/>" voor attribuut "enum" is onjuist [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing/@enum; allowed=('forceps_delivery_procedure', 'delivery_by_vacuum_extraction_procedure', 'obstetrical_version_with_extraction_procedure', 'partial_breech_extraction_procedure', 'total_breech_extraction_procedure', 'anders', 'geen_informatie')]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Vaginale kunstverlossing": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/vaginale_kunstverlossing_groep/vaginale_kunstverlossing; allowed=(@conceptId, @value, @code, @codeSystem, @displayName, @enum, @xsi:*)]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"
                 priority="1000"
                 mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind"/>

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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht]</svrl:text>
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
                  <xsl:text/> (verwacht: 0..1) [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/adaextension]</svrl:text>
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
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::adaextension)]"
                 priority="1000"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/*[not(self::geboortegewicht)][not(self::adaextension)]"/>

		    <!--REPORT -->
      <xsl:if test="true()">
         <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="true()">
            <xsl:attribute name="location">
               <xsl:apply-templates select="." mode="schematron-select-full-path"/>
            </xsl:attribute>
            <svrl:text>Ongeldige informatie aangetroffen: <xsl:text/>
               <xsl:value-of select="local-name(.)"/>
               <xsl:text/> [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>]</svrl:text>
         </svrl:successful-report>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"
                 priority="1000"
                 mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht"/>

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
                  <xsl:text/>" voor attribuut "conceptId" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId; type=t-id]</svrl:text>
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
                  <xsl:text/>" voor attribuut "conceptId" heeft niet de verwachte vaste waarde "2.16.840.1.113883.2.4.3.11.60.90.77.2.5.40060" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@conceptId]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": Attribuut "value" ontbreekt [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" heeft een onjuist formaat [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; type=xs:decimal]</svrl:text>
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
                  <xsl:text/>" voor attribuut "value" moet minimaal 0 zijn [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@value; min-inclusive=0]</svrl:text>
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
                  <xsl:text/>" voor attribuut "unit" heeft niet de verwachte vaste waarde "gram" [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht/@unit]</svrl:text>
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
               <svrl:text>Foutieve informatie voor "Geboortegewicht": Ongeldige attributen aangetroffen [/prio1_vorig/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens/lichamelijk_onderzoek_kind/geboortegewicht; allowed=(@conceptId, @value, @unit, @xsi:*)]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
</xsl:stylesheet>
