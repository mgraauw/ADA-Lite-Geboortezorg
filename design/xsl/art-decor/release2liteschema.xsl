<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright © ART-DECOR Expert Group and ART-DECOR Open Tools
see https://art-decor.org/mediawiki/index.php?title=Copyright
<view></view>
This program is free software; you can redistribute it and/or modify it under the terms 
of the GNU Affero General Public Licenseas published by the Free Software Foundation; 
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU Affero General Public Licensefor more details.

See http://www.gnu.org/licenses/
-->
<xsl:stylesheet xmlns:ada="http://www.art-decor.org/ada"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:include href="ada-basics.xsl"/>

    <xsl:template match="/">
        <xsl:apply-templates select="ada//view[@type = 'crud']/dataset"/>
    </xsl:template>
    
    <xsl:template name="dataset" match="dataset[@transactionId]">
        <xsl:variable name="href" select="concat($projectDiskRoot, 'schemas/', @shortName, '.xsd')"/>
        <xsl:variable name="schema">
            <xs:schema>
                <xs:annotation>
                    <xs:documentation>Schema for transaction: <xsl:value-of select="@transactionId"/></xs:documentation>
                </xs:annotation>
                <xs:simpleType name="empty_string">
                    <xs:annotation>
                        <xs:documentation>Type for empty value-strings on non-mandatory concepts</xs:documentation>
                    </xs:annotation>
                    <xs:restriction base="xs:string">
                        <xs:maxLength value="0"/>
                    </xs:restriction>
                </xs:simpleType>
                <xs:element name="{@shortName}" type="{@shortName}_type"/>
                <xs:complexType name="{@shortName}_type">
                    <xs:sequence>
                        <xsl:call-template name="doConceptGroupContent"/>
                    </xs:sequence>
                    <xs:attribute name="shortName" type="xs:string" use="optional"/>
                    <xs:attribute name="transactionRef" type="xs:string"/>
                    <xs:attribute name="versionDate" type="xs:string"/>
                    <xs:attribute name="language" type="xs:string"/>
                </xs:complexType>
                <!-- This for generating types for all concepts-->
                <xsl:apply-templates select=".//concept[@type = 'group']" mode="doTypes"/>
                <xsl:apply-templates select=".//concept[@type = 'item']" mode="doTypes"/>
                <xs:complexType name="{$extensionElementName}_type">
                    <xs:sequence>
                        <xs:any processContents="skip" minOccurs="0" maxOccurs="unbounded"/>
                    </xs:sequence>
                    <xs:anyAttribute processContents="skip"/>
                </xs:complexType>
                <xs:simpleType name="NullFlavorNoInformation">
                    <xs:restriction base="xs:string">
                        <xs:enumeration value="NI"/>
                        <xs:enumeration value="UNK"/>
                        <xs:enumeration value="OTH"/>
                        <xs:enumeration value="MSK"/>
                        <xs:enumeration value="UNC"/>
                        <xs:enumeration value="NA"/>
                        <xs:enumeration value="NAV"/>
                        <xs:enumeration value="ASKU"/>
                        <xs:enumeration value="NASK"/>
                        <xs:enumeration value="INV"/>
                        <xs:enumeration value="DER"/>
                        <xs:enumeration value="NINF"/>
                        <xs:enumeration value="PINF"/>
                        <xs:enumeration value="QS"/>
                        <xs:enumeration value="TRC"/>
                    </xs:restriction>
                </xs:simpleType>
            </xs:schema>
        </xsl:variable>
        <xsl:copy-of select="$schema"/>
    </xsl:template>

    <xsl:template match="concept[@type = 'group']" mode="doTypes">
        <xs:complexType name="{implementation/@shortName}_type_{tokenize(@id, '\.')[last()]}">
            <xs:annotation>
                <xs:documentation>Type for concept group: <xsl:value-of select="name"/></xs:documentation>
            </xs:annotation>
            <xs:sequence>
                <xsl:call-template name="doConceptGroupContent"/>
            </xs:sequence>
            <xs:attribute name="conceptId" fixed="{@id}" use="optional"/>
            <xs:attribute name="comment" type="xs:string" use="optional"/>
        </xs:complexType>
    </xsl:template>

    <xsl:template match="concept[@type = 'group']">
        <xs:element name="{./implementation/@shortName}" type="{./implementation/@shortName}_type_{tokenize(@id, '\.')[last()]}">
            <xsl:apply-templates select="@minimumMultiplicity | @maximumMultiplicity"/>
        </xs:element>
    </xsl:template>

    <xsl:template name="doConceptGroupContent">
        <xsl:for-each select="concept">
            <xsl:choose>
                <xsl:when test="@type = 'item'">
                    <xs:element name="{./implementation/@shortName}" type="{./implementation/@shortName}_type_{tokenize(@id, '\.')[last()]}">
                        <xsl:apply-templates select="@minimumMultiplicity | @maximumMultiplicity"/>
                    </xs:element>
                </xsl:when>
                <xsl:when test="@type = 'group'">
                    <xsl:apply-templates select="."/>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
        <xs:element name="{$extensionElementName}" type="adaextension_type" minOccurs="0" maxOccurs="1"/>
    </xsl:template>

    <xsl:template name="doConceptItems" match="concept[@type = 'item']" mode="doTypes">
        <xsl:variable name="isMandatory" select="ada:isMandatory(.)" as="xs:boolean"/>
        <xsl:variable name="isRequired" select="ada:isRequired(.)" as="xs:boolean"/>
        
        <xsl:if test="count(valueDomain) > 1">
            <xsl:message>
                <xsl:text>Concept has more than 1 valueDomain. This is not supported. Please check concept "</xsl:text>
                <xsl:value-of select="name[1]"/>
                <xsl:text>" id=</xsl:text>
                <xsl:value-of select="@id | @ref"/>
                <xsl:text> effectiveDate=</xsl:text>
                <xsl:value-of select="@effectiveDate | @flexibility"/>
            </xsl:message>
        </xsl:if>
        <xs:annotation>
            <xs:documentation>
                <xsl:text>Type for concept item: </xsl:text>
                <xsl:value-of select="name"/>
                <xsl:text> - </xsl:text>
                <xsl:value-of select="@minimumMultiplicity"/>
                <xsl:text>..</xsl:text>
                <xsl:value-of select="@maximumMultiplicity"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@conformance"/>
            </xs:documentation>
        </xs:annotation>
        <!-- complexType for concept item -->
        <xs:complexType name="{implementation/@shortName}_type_{tokenize(@id, '\.')[last()]}">
            <!-- @conceptId -->
            <xs:attribute name="conceptId" fixed="{@id}"/>
            <!-- @value -->
            <xs:attribute name="value">
                <xsl:if test="@conformance = 'M'">
                    <xsl:attribute name="use">required</xsl:attribute>
                </xsl:if>
                <xsl:choose>
                    <!-- Use yes/no/unknown for non-mandatory booleans -->
                    <xsl:when test="valueDomain[@type = 'boolean']">
                        <!--<xsl:choose>
                            <xsl:when test="valueDomain/property/@fixed[lower-case(.) = ('yes','si','ja','oui','true','1')]">
                                <xsl:attribute name="fixed">true</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="valueDomain/property/@fixed[lower-case(.) = ('no','non','nein','false','0')]">
                                <xsl:attribute name="fixed">false</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="valueDomain/property/@default[lower-case(.) = ('yes','si','ja','oui','true','1')]">
                                <xsl:attribute name="fixed">true</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="valueDomain/property/@default[lower-case(.) = ('no','non','nein','false','0')]">
                                <xsl:attribute name="fixed">false</xsl:attribute>
                            </xsl:when>
                        </xsl:choose>-->
                        <xs:simpleType>
                            <xs:restriction base="xs:string">
                                <xs:annotation>
                                    <xsl:choose>
                                        <xsl:when test="@conformance = 'M' or @isMandatory = 'true'">
                                            <xs:documentation>mandatory boolean</xs:documentation>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xs:documentation>non-mandatory boolean</xs:documentation>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xs:annotation>
                                <xsl:if test="@minimumMultiplicity = '0' or not(@minimumMultiplicity) or not(@conformance = 'M')">
                                    <xs:enumeration value="">
                                        <xs:annotation>
                                            <xs:documentation>Empty</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                                <xs:enumeration value="true">
                                    <xs:annotation>
                                        <xs:documentation>Yes</xs:documentation>
                                    </xs:annotation>
                                </xs:enumeration>
                                <xs:enumeration value="false">
                                    <xs:annotation>
                                        <xs:documentation>No</xs:documentation>
                                    </xs:annotation>
                                </xs:enumeration>
                                <!-- For non-mandatory elements, allow empty value strings -->
                                <xsl:if test="not(@conformance = 'M' or @isMandatory = 'true')">
                                    <xs:enumeration value="UNK">
                                        <xs:annotation>
                                            <xs:documentation>Unknown</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                            </xs:restriction>
                        </xs:simpleType>
                    </xsl:when>
                    <xsl:when test="valueDomain[@type = 'identifier'][identifierAssociation]">
                        <xs:simpleType>
                            <xs:restriction base="xs:string">
                                <xs:annotation>
                                    <xs:documentation>identifierAssociation</xs:documentation>
                                </xs:annotation>
                                <xsl:if test="@minimumMultiplicity = '0' or not(@minimumMultiplicity) or not(@conformance = 'M')">
                                    <xs:enumeration value="">
                                        <xs:annotation>
                                            <xs:documentation>Empty</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                                <!-- If there are valueSet items, pick those -->
                                <xsl:for-each select="identifierAssociation">
                                    <xs:enumeration value="{@ref}">
                                        <xs:annotation>
                                            <xs:documentation>
                                                <xsl:value-of select="@ref"/> - <xsl:value-of select="@refdisplay"/>
                                            </xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:for-each>
                            </xs:restriction>
                        </xs:simpleType>
                    </xsl:when>
                    <!-- For valueDomain with non-empty properties, use a simpleType memberTypes for each property -->
                    <!-- 
                        Note: for
                        <property minInclude="25" maxInclude="240" unit="kg"/>
                        <property minInclude="2500" maxInclude="24000" unit="g"/>
                        this will still allow 2500 kg... To fix, we need XML Schema 1.1 or Schematron 
                    -->
                    <xsl:when test="valueDomain[not(@type = ('code','ordinal'))][property/@*]">
                        <xs:simpleType>
                            <xs:union>
                                <xsl:attribute name="memberTypes">
                                    <xsl:for-each select="valueDomain/property[@*]">
                                        <xsl:value-of select="../../implementation/@shortName"/>
                                        <xsl:text>_</xsl:text>
                                        <xsl:value-of select="position()"/>
                                        <xsl:text>_datatype_</xsl:text>
                                        <xsl:value-of select="translate(../../@id, '.', '_')"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:for-each>
                                    <!-- For non-mandatory elements, allow empty value strings -->
                                    <xsl:if test="@minimumMultiplicity != '1'">
                                        <xsl:text>empty_string</xsl:text>
                                    </xsl:if>
                                </xsl:attribute>
                            </xs:union>
                        </xs:simpleType>
                    </xsl:when>
                    <!-- For code, always use a simpleType with enumeration -->
                    <xsl:when test=".[valueDomain/@type = ('code', 'ordinal')][valueSet/conceptList/(concept | exception)]">
                        <xs:simpleType>
                            <xs:restriction base="xs:string">
                                <xsl:if test="@minimumMultiplicity = '0' or not(@minimumMultiplicity) or not(@conformance = 'M')">
                                    <xs:enumeration value="">
                                        <xs:annotation>
                                            <xs:documentation>Empty</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                                <!-- If there are valueSet items, pick those -->
                                <xsl:if test="count(valueSet/conceptList/(concept | exception)) > 0">
                                    <xsl:for-each select="valueSet/conceptList/(concept | exception)">
                                        <xs:enumeration value="{@code}">
                                            <xs:annotation>
                                                <xs:documentation>
                                                    <xsl:value-of select="@displayName"/>
                                                </xs:documentation>
                                            </xs:annotation>
                                        </xs:enumeration>
                                    </xsl:for-each>
                                </xsl:if>
                                <!-- If there are no valueSet items, but valueDomain items, pick those -->
                                <xsl:if test="count(valueSet/conceptList/(concept | exception)) = 0 and count(valueDomain/conceptList/(concept | exception)) > 0">
                                    <xsl:for-each select="valueDomain/conceptList/(concept | exception)">
                                        <xs:enumeration value="{name}"/>
                                    </xsl:for-each>
                                </xsl:if>
                            </xs:restriction>
                        </xs:simpleType>
                    </xsl:when>
                    <xsl:otherwise>
                        <xs:simpleType>
                            <xs:restriction>
                                <xsl:attribute name="base">
                                    <!-- try to deal with multiple valueDomains. use xs:string if available, otherwise first from list -->
                                    <xsl:variable name="baseTypes" as="xs:string+">
                                        <xsl:apply-templates select="valueDomain" mode="getSchemaType"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$baseTypes = 'xs:string'">xs:string</xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$baseTypes[1]"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:if test="valueDomain[@type = ('string', 'text', 'identifier', 'complex')][../@isMandatory = 'true']">
                                    <xs:annotation>
                                        <xs:documentation>@conformance='M'</xs:documentation>
                                    </xs:annotation>
                                    <xs:minLength value="1"/>
                                    <xs:pattern value=".*[^\s].*"/>
                                </xsl:if>
                            </xs:restriction>
                        </xs:simpleType>
                    </xsl:otherwise>
                </xsl:choose>
            </xs:attribute>
            <!-- @enum -->
            <xs:attribute name="enum">
                <xsl:if test="@conformance = 'M'">
                    <xsl:attribute name="use">required</xsl:attribute>
                </xsl:if>
                <xsl:choose>
                    <!-- Use yes/no/unknown for non-mandatory booleans -->
                    <xsl:when test="valueDomain[@type = 'boolean']">
                        <xs:simpleType>
                            <xs:restriction base="xs:string">
                                <xs:annotation>
                                    <xsl:choose>
                                        <xsl:when test="@conformance = 'M' or @isMandatory = 'true'">
                                            <xs:documentation>mandatory boolean</xs:documentation>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xs:documentation>non-mandatory boolean</xs:documentation>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xs:annotation>
                                <xsl:if test="@minimumMultiplicity = '0' or not(@minimumMultiplicity) or not(@conformance = 'M')">
                                    <xs:enumeration value="">
                                        <xs:annotation>
                                            <xs:documentation>Empty</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                                <xs:enumeration value="Ja">
                                    <xs:annotation>
                                        <xs:documentation>Yes</xs:documentation>
                                    </xs:annotation>
                                </xs:enumeration>
                                <xs:enumeration value="Nee">
                                    <xs:annotation>
                                        <xs:documentation>No</xs:documentation>
                                    </xs:annotation>
                                </xs:enumeration>
                                <!-- For non-mandatory elements, allow empty value strings -->
                                <xsl:if test="not(@conformance = 'M' or @isMandatory = 'true')">
                                    <xs:enumeration value="UNK">
                                        <xs:annotation>
                                            <xs:documentation>Onbekend</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                            </xs:restriction>
                        </xs:simpleType>
                    </xsl:when>
                    <!-- For code, always use a simpleType with enumeration -->
                    <xsl:when test=".[valueDomain/@type = ('code', 'ordinal')][valueSet/conceptList/(concept | exception)]">
                        <xs:simpleType>
                            <xs:restriction base="xs:string">
                                <xsl:if test="@minimumMultiplicity = '0' or not(@minimumMultiplicity) or not(@conformance = 'M')">
                                    <xs:enumeration value="">
                                        <xs:annotation>
                                            <xs:documentation>Empty</xs:documentation>
                                        </xs:annotation>
                                    </xs:enumeration>
                                </xsl:if>
                                <!-- If there are valueSet items, pick those -->
                                <xsl:if test="count(valueSet/conceptList/(concept | exception)) > 0">
                                    <xsl:for-each select="valueSet/conceptList/(concept | exception)">
                                        <xs:enumeration value="{replace(normalize-space(@displayName), ' ', '_')}">
                                        </xs:enumeration>
                                    </xsl:for-each>
                                </xsl:if>
                                <!-- If there are no valueSet items, but valueDomain items, pick those -->
                                <xsl:if test="count(valueSet/conceptList/(concept | exception)) = 0 and count(valueDomain/conceptList/(concept | exception)) > 0">
                                    <xsl:for-each select="valueDomain/conceptList/(concept | exception)">
                                        <xs:enumeration value="{replace(normalize-space(@name), ' ', '_')}"/>
                                    </xsl:for-each>
                                </xsl:if>
                            </xs:restriction>
                        </xs:simpleType>
                    </xsl:when>
                </xsl:choose>
            </xs:attribute>
            <!-- @unit, use an anonymous simpleType with enumeration -->
            <xsl:if test="valueDomain/@type = ('quantity', 'duration')">
                <xs:attribute name="unit" use="optional">
                    <xs:simpleType>
                        <xs:restriction base="xs:string">
                            <xsl:for-each select="valueDomain/property/@unit">
                                <xs:enumeration value="{.}"/>
                            </xsl:for-each>
                        </xs:restriction>
                    </xs:simpleType>
                </xs:attribute>
            </xsl:if>
            <!-- @root, optional attribute for identifier -->
            <xsl:if test="valueDomain[@type = 'identifier']">
                <xs:attribute name="root" type="xs:string">
                    <xsl:variable name="root" select="distinct-values(identifierAssociation/@ref)"/>
                    <xsl:if test="count($root) = 1">
                        <xsl:attribute name="default" select="$root"/>
                    </xsl:if>
                </xs:attribute>
            </xsl:if>
            <!-- @displayName, @code, @codeSystem, @codeSystemName, @codeSystemVersion optional attributes for code. -->
            <xsl:if test="valueDomain/@type = ('code', 'ordinal')">
                <xsl:variable name="codeSystem" select="distinct-values(valueSet//@codeSystem)"/>
                <xsl:choose>
                    <xsl:when test="not($isMandatory)">
                        <xs:attribute name="displayName" type="xs:string" use="optional"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xs:attribute name="displayName" type="xs:string"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xs:attribute name="code" type="xs:string" use="optional"/>
                <xs:attribute name="codeSystem" type="xs:string" use="optional">
                    <!-- if conformance is mandatory then there cannot be another codeSystem, else there could be NullFlavor -->
                    <xsl:if test="count($codeSystem) = 1 and $isMandatory">
                        <xsl:attribute name="fixed" select="$codeSystem"/>
                    </xsl:if>
                </xs:attribute>
                <xs:attribute name="codeSystemName" type="xs:string" use="optional"/>
                <xs:attribute name="codeSystemVersion" type="xs:string" use="optional"/>
                <xsl:if test="not($isMandatory)">
                    <xs:attribute name="originalText" type="xs:string" use="optional"/>
                </xsl:if>
            </xsl:if>
            <!-- Add nullFlavor if not mandatory, code or ordinal (because then it would be in code/codeSystem) -->
            <xsl:if test="not($isMandatory or valueDomain/@type = ('code', 'ordinal'))">
                <xs:attribute name="nullFlavor" type="NullFlavorNoInformation" use="optional"/>
            </xsl:if>
        </xs:complexType>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Do the multiplicities -->
    <xsl:template name="minimumMultiplicity" match="@minimumMultiplicity">
        <xsl:choose>
            <xsl:when test="(. = '') or (. = '0')">
                <xsl:attribute name="minOccurs">0</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="minOccurs">1</xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="maximumMultiplicity" match="@maximumMultiplicity">
        <xsl:choose>
            <xsl:when test="(. = '') or (. = '*')">
                <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="maxOccurs">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Make a simpleType for each property. Name will be {@shortName)_{counter for each property}_datatype_{underscored_id}, 
        i.e. weight_1_datatype_2_16..., weight_2_datatype_2_16... -->
    <xsl:template name="simpleTypeForProperty" match="valueDomain[property/@*]">
        <!-- For all non-empty properties -->
        <xsl:for-each select="property[@*]">
            <xsl:variable name="baseType" as="xs:string">
                <xsl:apply-templates select="parent::valueDomain" mode="getSchemaType"/>
            </xsl:variable>
            <xs:annotation>
                <xs:documentation>simpleType for valueDomain: <xsl:value-of select="../../name"/>: <xsl:value-of select="../@type"/>
                </xs:documentation>
            </xs:annotation>
            <xs:simpleType name="{../../implementation/@shortName}_{position()}_datatype_{translate(../../@id, '.', '_')}">
                <xsl:choose>
                    <xsl:when test="parent::valueDomain/@type = 'datetime' and @timeStampPrecision = 'YMD'">
                        <xs:union memberTypes="xs:date xs:dateTime"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xs:restriction>
                            <xsl:attribute name="base" select="$baseType"/>
                            <xsl:if test="@minInclude and not($baseType = 'xs:string')">
                                <xs:minInclusive value="{@minInclude}"/>
                            </xsl:if>
                            <xsl:if test="@maxInclude and not($baseType = 'xs:string')">
                                <xs:maxInclusive value="{@maxInclude}"/>
                            </xsl:if>
                            <xsl:if test="@minLength and $baseType = 'xs:string'">
                                <xs:minLength value="{@minLength}"/>
                            </xsl:if>
                            <xsl:if test="not(@minLength) and (../../@conformance = 'M') and $baseType = 'xs:string'">
                                <xs:annotation>
                                    <xs:documentation>@conformance='M'</xs:documentation>
                                </xs:annotation>
                                <xs:minLength value="1"/>
                                <xs:pattern value=".*[^\s].*"/>
                            </xsl:if>
                            <xsl:if test="@maxLength and $baseType = 'xs:string'">
                                <xs:maxLength value="{@maxLength}"/>
                            </xsl:if>
                            <xsl:if test="@timeStampPrecision = 'Y!' and $baseType = 'xs:string'">
                                <xs:pattern value="\d{{4}}"/>
                            </xsl:if>
                            <xsl:if test="@timeStampPrecision = 'YM!' and $baseType = 'xs:string'">
                                <!-- 2018-04 -->
                                <xs:pattern value="\d{{4}}-(0[1-9])|(1[0-2])"/>
                            </xsl:if>
                        </xs:restriction>
                    </xsl:otherwise>
                </xsl:choose>
            </xs:simpleType>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="valueDomain" mode="getSchemaType">
        <xsl:choose>
            <xsl:when test="@type = 'count'">xs:nonNegativeInteger</xsl:when>
            <xsl:when test="@type = 'boolean'">xs:boolean</xsl:when>
            <xsl:when test="@type = ('date','datetime') and property/@timeStampPrecision = ('Y!','YM!')">xs:string</xsl:when>
            <xsl:when test="@type = 'date'">xs:date</xsl:when>
            <xsl:when test="@type = 'datetime' and property/@timeStampPrecision = 'YMD!'">xs:date</xsl:when>
            <xsl:when test="@type = 'datetime'">xs:dateTime</xsl:when>
            <!-- Add better support for duration when it is better defined in DECOR -->
            <xsl:when test="@type = 'duration'">xs:string</xsl:when>
            <xsl:when test="@type = 'blob'">xs:base64Binary</xsl:when>
            <!-- this would be strange, a quantity without property, just in case... -->
            <xsl:when test="@type = 'quantity'">xs:decimal</xsl:when>
            <!-- complex, currency, ratio not supported yet -->
            <!-- For others (string, text, identifier, catchall we do a string -->
            <xsl:otherwise>xs:string</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Skip the rest -->
    <xsl:template match="text() | @*"/>
</xsl:stylesheet>
