<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.pj1_vyb_wgb" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
        This stylesheet transforms an ADA Receive Transaction Dataset (shortened to rtd) into a
        (simple) XML schema. This schema is not meant to be processed directly (although there is no problem 
        in doing so). It will be used primarily for the conversion into Schematron by
        ada-schema-simple2ada-schematron.xsl
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="lib/xsl-common.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="ada-lite-version" as="xs:string" required="false" select="string(true())">
    <!-- When true or omitted it creates a schema for ADA lite. When false for full ADA. -->
  </xsl:param>
  <xsl:variable name="do-ada-lite-version" as="xs:boolean" select="xs:boolean($ada-lite-version)"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="simple-type-name-for-identifier" as="xs:string" select="'t-id'"/>

  <xsl:variable name="base-type-numeric" as="xs:string" select="'xs:decimal'"/>
  <xsl:variable name="base-type-boolean" as="xs:string" select="'xs:boolean'"/>
  <xsl:variable name="base-type-string" as="xs:string" select="'xs:string'"/>

  <xsl:variable name="use-required" as="xs:string" select="'required'"/>
  <xsl:variable name="use-optional" as="xs:string" select="'optional'"/>
  <xsl:variable name="required-in-ada-full" as="xs:string" select="if ($do-ada-lite-version) then $use-optional else $use-required"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">

    <xsl:variable name="lite-or-full" as="xs:string" select="if ($do-ada-lite-version) then 'Lite' else 'Full'"/>
    <xsl:variable name="source" as="xs:string" select="bc-alg:dref-alg-path(base-uri(/))"/>
    <xsl:variable name="shortname" as="xs:string" select="string(/*/@shortName)"/>
    <xsl:variable name="generator" as="xs:string" select="bc-alg:dref-alg-path(fn:static-base-uri())"/>

    <!-- Setup the schema: -->
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
      <xs:annotation>
        <xs:documentation xml:lang="nl-NL">
          <xsl:text>Schema for ADA documents </xsl:text>
          <xsl:value-of select="$shortname"/>
          <xsl:text> - </xsl:text>
          <xsl:value-of select="$lite-or-full"/>
          <xsl:text> version</xsl:text>
        </xs:documentation>
        <xs:documentation xml:lang="nl-NL" >
          <xsl:text>Source: </xsl:text>
          <xsl:value-of select="$source"/>
        </xs:documentation>
        <xs:documentation xml:lang="nl-NL" >
          <xsl:text>Generator: </xsl:text>
          <xsl:value-of select="$generator"/>
        </xs:documentation>
        <xs:appinfo source="shortname">{$shortname}</xs:appinfo>
        <xs:appinfo source="source">{$source}</xs:appinfo>
        <xs:appinfo source="lite-or-full">{$lite-or-full}</xs:appinfo>
        <xs:appinfo source="generator">{$generator}</xs:appinfo>
      </xs:annotation>

      <xsl:apply-templates select="/*"/>

      <!-- Standard simple types used: -->
      <xs:simpleType name="{$simple-type-name-for-identifier}">
        <xs:annotation>
          <xs:documentation>An identifier in an ADA transaction</xs:documentation>
        </xs:annotation>
        <xs:restriction base="xs:string">
          <xs:pattern value="([0-9]+\.)+([0-9]+)"/>
        </xs:restriction>
      </xs:simpleType>

    </xs:schema>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="/*">
    <!-- Create the definition for the root element of the message: -->

    <xs:element name="{/*/@shortName}">
      <xsl:call-template name="process-name-description"/>
      <xs:complexType>
        <xs:sequence>
          <xsl:apply-templates select="concept"/>
        </xs:sequence>
        <!-- Define the standard root element attributes: -->
        <xs:attribute name="transactionRef" type="{$simple-type-name-for-identifier}" use="{$use-required}" fixed="{@transactionId}"/>
        <xs:attribute name="transactionEffectiveDate" type="xs:dateTime" use="{$required-in-ada-full}" fixed="{@transactionEffectiveDate}"/>
        <xs:attribute name="versionDate" type="xs:dateTime" use="{$required-in-ada-full}"/>
        <xs:attribute name="prefix" type="xs:string" use="{$required-in-ada-full}"/>
      </xs:complexType>
    </xs:element>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="concept">

    <xs:element name="{@shortName}" minOccurs="{@minimumMultiplicity}"
      maxOccurs="{if (@maximumMultiplicity eq '*') then 'unbounded' else @maximumMultiplicity}">
      <xsl:call-template name="process-name-description"/>
      <xs:complexType>
        <xsl:where-populated>
          <xs:sequence>
            <xsl:apply-templates select="concept"/>
          </xs:sequence>
        </xsl:where-populated>
        <xs:attribute name="conceptId" type="{$simple-type-name-for-identifier}" use="{$required-in-ada-full}" fixed="{@id}"/>
        <xsl:call-template name="handle-value-domain"/>
      </xs:complexType>

    </xs:element>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:template name="process-name-description">
    <xsl:param name="elm" as="element()?" required="false" select="."/>

    <xsl:for-each select="$elm">
      <xsl:where-populated>
        <xs:annotation>
          <!-- Add the name: -->
          <xsl:variable name="name-value" as="xs:string" select="normalize-space(name)"/>
          <xsl:if test="$name-value ne ''">
            <xs:documentation source="name">
              <xsl:if test="normalize-space(name/@language) ne ''">
                <xsl:attribute name="xml:lang" select="name/@language"/>
              </xsl:if>
              <xsl:value-of select="$name-value"/>
            </xs:documentation>
          </xsl:if>
          <!-- Only add the description if is non-empty and ne name: -->
          <xsl:variable name="desc-value" as="xs:string" select="normalize-space(desc)"/>
          <xsl:if test="($desc-value ne '') and ($desc-value ne $name-value)">
            <xs:documentation source="desc">
              <xsl:if test="normalize-space(desc/@language) ne ''">
                <xsl:attribute name="xml:lang" select="desc/@language"/>
              </xsl:if>
              <xsl:value-of select="$desc-value"/>
            </xs:documentation>
          </xsl:if>
        </xs:annotation>
      </xsl:where-populated>
    </xsl:for-each>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="handle-value-domain">
    <xsl:param name="concept" as="element(concept)" required="false" select="."/>
    <!-- Creates the definitions of attributes when there is a <valueDomain> specified. 
         See also https://www.art-decor.org/mediawiki/index.php?title=DECOR-dataset 
    -->
    <xsl:for-each select="$concept/valueDomain">
      <xsl:variable name="valuetype" as="xs:string" select="@type"/>
      <xsl:choose>

        <!-- Quantity: -->
        <xsl:when test="$valuetype eq 'quantity'">
          <xsl:call-template name="create-value-attribute-definition">
            <xsl:with-param name="base-type" select="$base-type-numeric"/>
          </xsl:call-template>
          <!-- See if there's a unit definition: -->
          <xsl:variable name="unit" as="xs:string?" select="property/@unit"/>
          <xsl:if test="exists($unit)">
            <xs:attribute name="unit" type="xs:string" use="{$required-in-ada-full}" fixed="{$unit}"/>
          </xsl:if>
        </xsl:when>

        <!-- Boolean: -->
        <xsl:when test="$valuetype eq 'boolean'">
          <xsl:call-template name="create-value-attribute-definition">
            <xsl:with-param name="base-type" select="$base-type-boolean"/>
          </xsl:call-template>
        </xsl:when>

        <xsl:when test="$valuetype = ('count', 'ordinal', 'currency')">
          <xsl:call-template name="create-value-attribute-definition">
            <xsl:with-param name="base-type" select="$base-type-numeric"/>
          </xsl:call-template>
        </xsl:when>

        <xsl:when test="$valuetype eq 'code'">
          <xsl:call-template name="create-code-attribute-definitions"/>
        </xsl:when>

        <!-- Anything else we take as a string for now: -->
        <xsl:otherwise>
          <xsl:call-template name="create-value-attribute-definition">
            <xsl:with-param name="base-type" select="$base-type-string"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>


    </xsl:for-each>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="create-value-attribute-definition" as="element(xs:attribute)">
    <xsl:param name="value-domain" as="element(valueDomain)" required="false" select="."/>
    <xsl:param name="base-type" as="xs:string" required="yes"/>
    <!-- Establishes the type for a value attribute. This is either an <xs:simpleType> element or a type attribute. 
         This is not very exact code. We ignore @timeStampPrecision and do not always exactly check that the properties are appropriate for the 
         datatype.
    -->

    <!-- Find out if we have any restriction definition: -->
    <xsl:variable name="restriction-definition" as="element(xs:restriction)?">
      <xsl:where-populated>
        <xs:restriction base="{$base-type}">
          <!-- Numeric related properties: -->
          <xsl:if test="$base-type eq $base-type-numeric">
            <xsl:variable name="min-include" as="xs:string?" select="property/@minInclude"/>
            <xsl:if test="exists($min-include) and ($min-include castable as xs:decimal)">
              <xs:minInclusive value="{xs:decimal($min-include)}"/>
            </xsl:if>
            <xsl:variable name="max-include" as="xs:string?" select="property/@maxInclude"/>
            <xsl:if test="exists($max-include) and ($max-include castable as xs:decimal)">
              <xs:maxInclusive value="{xs:decimal($max-include)}"/>
            </xsl:if>
            <!-- Remark: The fraction digits can have a ! at the end to signify that it must be an exact number of digits. Ignore for now. -->
            <xsl:variable name="fraction-digits" as="xs:string?" select="replace(property/@fractionDigits, '!$', '')"/>
            <xsl:if test="exists($fraction-digits) and ($fraction-digits castable as xs:integer)">
              <xs:fractionDigits value="{xs:integer($fraction-digits)}"/>
            </xsl:if>
          </xsl:if>
          <!-- String related properties: -->
          <xsl:if test="$base-type eq $base-type-string">
            <xsl:variable name="min-length" as="xs:string?" select="property/@minLength"/>
            <xsl:if test="exists($min-length) and ($min-length castable as xs:integer)">
              <xs:minLength value="{xs:integer($min-length)}"/>
            </xsl:if>
            <xsl:variable name="max-length" as="xs:string?" select="property/@maxLength"/>
            <xsl:if test="exists($max-length) and ($max-length castable as xs:integer)">
              <xs:maxLength value="{xs:integer($max-length)}"/>
            </xsl:if>
          </xsl:if>
        </xs:restriction>
      </xsl:where-populated>
    </xsl:variable>

    <!-- Create the attribute definition: -->
    <xs:attribute name="value" use="{$use-required}">
      <!-- See if there are any default/fixed settings and output these as the correct attributes. Fixed/default settings are exclusive,
           so let fixed take precedence. -->
      <xsl:variable name="fixed" as="xs:string?" select="property/@fixed"/>
      <xsl:choose>
        <xsl:when test="exists($fixed)">
          <xsl:attribute name="fixed" select="$fixed"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="default" as="xs:string?" select="property/@default"/>
          <xsl:if test="exists($default)">
            <xsl:attribute name="default" select="$default"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <!-- Create the right type: -->
      <xsl:choose>
        <xsl:when test="exists($restriction-definition)">
          <xs:simpleType>
            <xsl:sequence select="$restriction-definition"/>
          </xs:simpleType>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type" select="$base-type"/>
        </xsl:otherwise>
      </xsl:choose>
    </xs:attribute>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="create-code-attribute-definitions">
    <xsl:param name="value-domain" as="element(valueDomain)" required="false" select="."/>

    <!-- The definitions for the codes can be in <concept> and in <exception> elements. -->
    <xsl:variable name="base-concept-elements" as="element()*" select="$value-domain/../valueSet/conceptList/(concept | exception)"/>
    <xsl:if test="empty($base-concept-elements)">
      <xsl:comment> == *** No conceptList entries found for concept {string($value-domain/../@shortName)} == </xsl:comment>
    </xsl:if>

    <xsl:call-template name="add-value-restricted-attribute-definition">
      <xsl:with-param name="attribute-name" select="'value'"/>
      <xsl:with-param name="attribute-allowed-values"
        select="if ($do-ada-lite-version) then data($base-concept-elements/@code) else data($base-concept-elements/@localId)"/>
      <xsl:with-param name="base-elements" select="$base-concept-elements"/>
    </xsl:call-template>
    <xsl:call-template name="add-value-restricted-attribute-definition">
      <xsl:with-param name="attribute-name" select="'code'"/>
      <xsl:with-param name="attribute-allowed-values" select="data($base-concept-elements/@code)"/>
    </xsl:call-template>
    <xsl:call-template name="add-value-restricted-attribute-definition">
      <xsl:with-param name="attribute-name" select="'codeSystem'"/>
      <xsl:with-param name="attribute-allowed-values" select="data($base-concept-elements/@codeSystem)"/>
    </xsl:call-template>
    <xsl:call-template name="add-value-restricted-attribute-definition">
      <xsl:with-param name="attribute-name" select="'displayName'"/>
      <xsl:with-param name="attribute-allowed-values" select="data($base-concept-elements/@displayName)"/>
    </xsl:call-template>

    <!-- For the lite version, add the @enum alternative as well: -->
    <xsl:if test="$do-ada-lite-version">
      <xsl:call-template name="add-value-restricted-attribute-definition">
        <xsl:with-param name="attribute-name" select="'enum'"/>
        <xsl:with-param name="attribute-allowed-values"
          select="for $base-concept-element in $base-concept-elements return bc-alg:value-to-enum($base-concept-element)"/>
        <xsl:with-param name="base-elements" select="$base-concept-elements"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="add-value-restricted-attribute-definition">
    <xsl:param name="attribute-name" as="xs:string" required="yes"/>
    <xsl:param name="attribute-allowed-values" as="xs:string*" required="yes"/>
    <xsl:param name="base-elements" as="element()*" required="false" select="()"/>

    <!-- Remark: When $attribute-allowed-values is empty this will simply generate an xs:string typed attribute definition 
      without any further ado. -->
    <xs:attribute name="{$attribute-name}" use="{$required-in-ada-full}">
      <xsl:choose>
        <xsl:when test="exists($attribute-allowed-values)">
          <xs:simpleType>
            <xs:restriction base="xs:string">
              <xsl:for-each select="$attribute-allowed-values">
                <xsl:variable name="index" as="xs:integer" select="position()"/>
                <xs:enumeration value="{.}">
                  <xsl:if test="exists($base-elements)">
                    <xsl:call-template name="process-name-description">
                      <xsl:with-param name="elm" as="element()?" select="$base-elements[$index]"/>
                    </xsl:call-template>
                  </xsl:if>
                </xs:enumeration>
              </xsl:for-each>
            </xs:restriction>
          </xs:simpleType>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type" select="'xs:string'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xs:attribute>
  </xsl:template>

</xsl:stylesheet>
