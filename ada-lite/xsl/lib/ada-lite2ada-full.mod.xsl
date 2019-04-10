<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" xmlns:bc-al2af="https://babyconnect.org/ns/ada-lite2ada-full"
  xmlns:local="#local.lct_4kn_jhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!--	
       Library that contains code to convert an XML document from the ADA Lite format into full ADA.
       For this it uses the definitions from a Retrieve Transaction Dataset (shortened to rtd here). 
       
       The ADA LIte input is assumed to be validated already. Therefore, when an error condition occurs, only a comment is output, no 
       error is raised.
       
       This was separated into a library because it was needed on more than on occasion.
	-->
  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="bc-al2af:fixed-version-date" as="xs:string" select="'2019-01-01T00:00:00'">
    <!-- The fixed version date used when bc-al2af:ada-lite2ada-full is called with use-fixed-version-date set to true. -->
  </xsl:variable>

  <!-- ================================================================== -->

  <xsl:template name="bc-al2af:ada-lite2ada-full">
    <xsl:param name="ada-lite-root-element" as="element()" required="yes">
      <!-- Root element of the ADA LIte XML. It is assumed this is a valid ADA Lite document. -->
    </xsl:param>
    <xsl:param name="rtd-root-element" as="element(dataset)" required="yes">
      <!-- Root element of the accompanying Retrieve Transaction Dataset. -->
    </xsl:param>
    <xsl:param name="use-fixed-version-date" as="xs:boolean" required="no" select="false()">
      <!-- Determines the value of /*/@versionDate when this attribute was not specified in the ada-lite input document.
           - If false, the current date/time is used
           - If true, a *fixed* version date (see $bc-al2af:fixed-version-date above) is used. 
             This is useful because for generating the ada-full examples we don't want a new @versionDate with every generation: This would 
             mean changes to the GIT repository after every generation, even when nothing was changed.
      -->
    </xsl:param>

    <xsl:for-each select="$ada-lite-root-element">
      <xsl:element name="{$rtd-root-element/@shortName}">
        <xsl:copy select="@transactionRef"/>
        <xsl:copy select="$rtd-root-element/@transactionEffectiveDate"/>
        <!-- About @versionDate: See the remarks for parameter use-fixed-version-date above.  -->
        <xsl:variable name="version-date" as="xs:string"
          select="if ($use-fixed-version-date) then $bc-al2af:fixed-version-date else substring(string(current-dateTime()), 1, 19)"/>
        <xsl:attribute name="versionDate" select="(/*/@versionDate, $version-date)[1]"/>
        <xsl:attribute name="prefix" select="($rtd-root-element/@prefix, 'peri20-')[1]"/>

        <xsl:comment> == ADA full format document generated from lite format document == </xsl:comment>
        <xsl:comment> == Source: {bc-alg:dref-alg-path(base-uri(/))} == </xsl:comment>
        <xsl:comment> == Specification used: {bc-alg:dref-alg-path(base-uri($rtd-root-element))} == </xsl:comment>
        <xsl:comment> == Generator: {bc-alg:dref-alg-path(static-base-uri())} == </xsl:comment>

        <xsl:apply-templates select="*" mode="bc-al2af:mode-convert-ada-lite2ada-full">
          <xsl:with-param name="concept-root" as="element()" select="$rtd-root-element" tunnel="true"/>
          <xsl:with-param name="parent-name-set" as="xs:string*" select="local-name(.)" tunnel="true"/>
        </xsl:apply-templates>

      </xsl:element>
    </xsl:for-each>

  </xsl:template>

  <!-- ================================================================== -->
  <!-- SUPPORT TEMPLATES FOR CONVERTING TO ADA FULL: -->

  <xsl:template match="*" mode="bc-al2af:mode-convert-ada-lite2ada-full">
    <xsl:param name="concept-root" as="element()" required="true" tunnel="true"/>
    <xsl:param name="parent-name-set" as="xs:string*" required="true" tunnel="true"/>

    <xsl:variable name="elm-name" as="xs:string" select="local-name(.)"/>
    <xsl:variable name="full-elm-path" as="xs:string" select="string-join(($parent-name-set, $elm-name), '/')"/>

    <!-- Find the right concept child and pre-flight check it:: -->
    <xsl:variable name="concept" as="element(concept)?" select="($concept-root/concept[@shortName eq $elm-name])[1]"/>

    <xsl:choose>
      <xsl:when test="exists($concept)">
        <xsl:element name="{$elm-name}">
          <xsl:attribute name="conceptId" select="$concept/@id"/>

          <!-- Get the value for this concept:  -->
          <xsl:variable name="concept-type" as="xs:string" select="$concept/@type"/>
          <xsl:choose>
            <xsl:when test="($concept-type eq 'item') and (exists(@value) or exists(@enum))">
              <xsl:call-template name="local:handle-concept-value">
                <xsl:with-param name="concept" select="$concept"/>
                <xsl:with-param name="value" select="@value"/>
                <xsl:with-param name="enum" select="@enum"/>
                <xsl:with-param name="full-elm-path" select="$full-elm-path"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="$concept-type eq 'group'">
              <!-- Just dive deeper -->
            </xsl:when>
            <xsl:otherwise>
              <!-- Since we assume the input is already validated this should not happen. Just output the value and a comment for now: -->
              <xsl:copy select="@value"/>
              <xsl:comment> == *** Unrecognized concept-type/value combination for {$full-elm-path} == </xsl:comment>
            </xsl:otherwise>
          </xsl:choose>

          <!-- Now dive into the child elements: -->
          <xsl:apply-templates select="*" mode="#current">
            <xsl:with-param name="concept-root" as="element()" select="$concept" tunnel="true"/>
            <xsl:with-param name="parent-name-set" as="xs:string*" select="($parent-name-set, $elm-name)" tunnel="true"/>
          </xsl:apply-templates>

        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment> == *** No concept found for element {$full-elm-path} in {bc-alg:dref-alg-path(base-uri($concept-root))} == </xsl:comment>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="adaextension" mode="bc-al2af:mode-convert-ada-lite2ada-full">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="local:handle-concept-value">
    <xsl:param name="concept" as="element(concept)" required="yes"/>
    <xsl:param name="value" as="xs:string?" required="yes"/>
    <xsl:param name="enum" as="xs:string?" required="yes"/>
    <xsl:param name="full-elm-path" as="xs:string" required="yes"/>

    <xsl:variable name="value-domain" as="element(valueDomain)" select="$concept/valueDomain"/>
    <xsl:variable name="value-domain-type" as="xs:string" select="$value-domain/@type"/>

    <xsl:choose>

      <!-- Code: Lookup the value in the code list of the concept. The actual value is the @localId. -->
      <xsl:when test="$value-domain-type eq 'code'">
        <xsl:variable name="valueset-concept-or-exception-elements" as="element()*" select="$concept/valueSet/conceptList/(concept | exception)"/>
        <xsl:variable name="code-element" as="element()?">
          <xsl:choose>
            <xsl:when test="exists($value)">
              <xsl:sequence select="($valueset-concept-or-exception-elements[@code eq $value])[1]"/>
            </xsl:when>
            <xsl:when test="exists($enum)">
              <xsl:sequence select="($valueset-concept-or-exception-elements[bc-alg:value-to-enum(.) eq $enum])[1]"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- Should not happen... -->
              <xsl:sequence select="error((), 'Internal error in ' || static-base-uri() || ': no value or enum')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:attribute name="value" select="$code-element/@localId"/>
        <xsl:copy-of select="($code-element/@code, $code-element/@codeSystem, $code-element/@displayName)"/>

        <xsl:if test="empty($code-element)">
          <xsl:comment> == *** No concept/exception found for value="{$value}" enum="{$enum}" == </xsl:comment>
        </xsl:if>
      </xsl:when>

      <!-- Quantity: Just output the value and a unit (if any): -->
      <xsl:when test="$value-domain-type eq 'quantity'">
        <xsl:attribute name="value" select="$value"/>
        <xsl:copy select="$value-domain/property/@unit"/>
      </xsl:when>

      <!-- Anything else, just output the value as-is: -->
      <xsl:otherwise>
        <xsl:attribute name="value" select="$value"/>
      </xsl:otherwise>

    </xsl:choose>

  </xsl:template>


</xsl:stylesheet>
