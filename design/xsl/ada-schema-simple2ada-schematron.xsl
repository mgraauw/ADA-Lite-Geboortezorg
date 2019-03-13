<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://purl.oclc.org/dsdl/schematron"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.mfj_4hd_wgb" xmlns:xslgen="#xslgen"
  xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Transforms the output of ada-rtd2ada-schema-simple.xsl into a Schematron file.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:include href="lib/xsl-common.xsl"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:namespace-alias stylesheet-prefix="xslgen" result-prefix="xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="add-technical-info" as="xs:string" required="false" select="string(true())">
    <!-- When true, technical info (full XPath-s etc.) is added to the assertion messages. -->
  </xsl:param>
  <xsl:variable name="do-add-technical-info" as="xs:boolean" select="xs:boolean($add-technical-info)"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <!-- Value used to signify a @maxOccurs="unbounded" situation: -->
  <xsl:variable name="max-occurs-unbounded-value" as="xs:integer" select="-1"/>

  <!-- Regular expression for an id: -->
  <xsl:variable name="id-type-regexp" as="xs:string" select="'^([0-9]+\.)+([0-9]+)$'"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">

    <!-- Setup the Schematron: -->
    <schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:local="#local" queryBinding="xslt2"
      xml:lang="nl-NL">

      <!-- Generate some identifying comments. If the source was created using ada-rtd2ada-schema-simple.xsl, we can say more because this leaves 
        interesting global annotations: -->
      <xsl:variable name="source-info" as="xs:string?" select="/*/xs:annotation/xs:appinfo[@source eq 'source'][1]"/>
      <xsl:variable name="lite-or-full-info" as="xs:string?" select="/*/xs:annotation/xs:appinfo[@source eq 'lite-or-full'][1]"/>
      <xsl:variable name="shortname-info" as="xs:string?" select="/*/xs:annotation/xs:appinfo[@source eq 'shortname'][1]"/>
      <xsl:variable name="generator-info" as="xs:string?" select="/*/xs:annotation/xs:appinfo[@source eq 'generator'][1]"/>
      <xsl:comment> == Generated Schematron file for validating ADA {$lite-or-full-info} {$shortname-info} documents == </xsl:comment>
      <xsl:if test="exists($source-info)">
        <xsl:comment> == Source: {$source-info} == </xsl:comment>
      </xsl:if>
      <xsl:comment> == Generator(s): {string-join(($generator-info, bc-alg:dref-alg-path(fn:static-base-uri())), '; ')} == </xsl:comment>
      
      <!-- Define the xsi namespace in the Schematron: -->
      <ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>

      <!-- Create a function for safe decimal conversion: -->
      <ns uri="#local" prefix="local"/>
      <xslgen:function name="local:decimal-convert" as="xs:decimal">
        <xslgen:param name="in" as="xs:string"/>
        <xslgen:sequence select="if ($in castable as xs:decimal) then xs:decimal($in) else xs:decimal(0)"/>
      </xslgen:function>

      <!-- A simple ADA schema has only a single <xs:element> definition for the root element. The rest is nested inside this. So we start here. -->
      <xsl:call-template name="handle-element-definitions">
        <xsl:with-param name="element-definitions" select="/*/xs:element[1]"/>
      </xsl:call-template>

    </schema>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="handle-element-definitions">
    <!-- Generates all the Schematron patterns for one-or-more <xs:element> entries in the simple ADA schema. -->
    <xsl:param name="element-definitions" as="element(xs:element)+" required="true"/>
    <xsl:param name="xpath-to-parent" as="xs:string" required="false" select="'/'">
      <!-- The XPath expression that leads up to the parent of this element -->
    </xsl:param>

    <!-- Create a pattern for each of the element definitions that tests the occurrences: -->
    <pattern>
      <rule context="{$xpath-to-parent}">

        <xsl:comment> == Check occurrences of children of {$xpath-to-parent}: == </xsl:comment>
        <xsl:for-each select="$element-definitions">
          <xsl:variable name="element-name" as="xs:string" select="string(@name)"/>

          <xsl:variable name="min-occurs" as="xs:integer" select="xs:integer((@minOccurs, 1)[1])"/>
          <xsl:variable name="max-occurs" as="xs:integer"
            select="if (@maxOccurs eq 'unbounded') then $max-occurs-unbounded-value else xs:integer((@maxOccurs, if ($min-occurs eq 0) then 1 else $min-occurs)[1])"/>
          <xsl:variable name="expected-count-display-string" as="xs:string">
            <xsl:choose>
              <xsl:when test="$min-occurs eq $max-occurs">
                <xsl:sequence select="string($min-occurs)"/>
              </xsl:when>
              <xsl:when test="$max-occurs eq $max-occurs-unbounded-value">
                <xsl:sequence select="$min-occurs || ' of meer'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="string($min-occurs) || '..' || string($max-occurs)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:call-template name="create-assertion">
            <xsl:with-param name="test-expression">
              <xsl:choose>
                <xsl:when test="$min-occurs eq $max-occurs">
                  <xsl:sequence select="'count(' || $element-name || ') eq ' || $min-occurs"/>
                </xsl:when>
                <xsl:when test="$max-occurs eq $max-occurs-unbounded-value">
                  <xsl:sequence select="'count(' || $element-name || ') ge ' || $min-occurs"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence
                    select="'(count(' || $element-name || ') ge ' || $min-occurs || ') and (count(' || $element-name || ') le ' || $max-occurs || ')'"
                  />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="message-parts"
              select="( 'Fout aantal voorkomens van ', local:get-display-name(.), ': ', '#count(' || $element-name || ')', 
                ' (verwacht: ', $expected-count-display-string, ')' )"/>
            <xsl:with-param name="technical-info-parts" select="local:xpath-concat($xpath-to-parent, $element-name)"/>
          </xsl:call-template>
        </xsl:for-each>
      </rule>
    </pattern>

    <!-- Create a pattern that tests for unexpected child elements of the parent (child elements that are not mentioned in $element-definitions).
      We don't need to do this for the children of / (since there can only be one root element).
    -->
    <xsl:if test="$xpath-to-parent ne '/'">
      <pattern>
        <xsl:comment> == Check for any unexpected elements in {$xpath-to-parent}: == </xsl:comment>
        <xsl:variable name="context-expression-components" as="xs:string+">
          <xsl:for-each select="$element-definitions">
            <xsl:sequence select="'[not(self::' || @name || ')]'"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="context-expression" as="xs:string"
          select="local:xpath-concat($xpath-to-parent, '*') || string-join($context-expression-components)"/>
        <rule context="{$context-expression}">
          <xsl:call-template name="create-assertion">
            <xsl:with-param name="is-report" select="true()"/>
            <xsl:with-param name="test-expression" select="'true()'"/>
            <xsl:with-param name="message-parts" select="( 'Ongeldige informatie aangetroffen: ', '#local-name(.)' )"/>
            <xsl:with-param name="technical-info-parts" select="( $xpath-to-parent, '/', '#name(.)' )"/>
          </xsl:call-template>
        </rule>
      </pattern>
    </xsl:if>

    <!-- Handle the attributes of each of the element definitions: -->
    <xsl:for-each select="$element-definitions">
      <xsl:variable name="xpath-to-element" as="xs:string" select="local:xpath-concat($xpath-to-parent, @name)"/>
      <xsl:variable name="attribute-definitions" as="element(xs:attribute)*" select="xs:complexType/xs:attribute"/>
      <xsl:choose>
        <xsl:when test="exists($attribute-definitions)">
          <xsl:call-template name="handle-attribute-definitions">
            <xsl:with-param name="attribute-definitions" select="$attribute-definitions"/>
            <xsl:with-param name="has-any-attribute-set" select="exists(xs:complexType/xs:anyAttribute)"/>
            <xsl:with-param name="xpath-to-parent" select="$xpath-to-element"/>
            <xsl:with-param name="parent-display-name" select="local:get-display-name(.)"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:comment> == No attributes for {$xpath-to-element} == </xsl:comment>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <!-- Dive deeper, do all the child element definitions:  -->
    <xsl:for-each select="$element-definitions">
      <xsl:variable name="xpath-to-element" as="xs:string" select="local:xpath-concat($xpath-to-parent, @name)"/>
      <xsl:variable name="child-element-definitions" as="element(xs:element)*" select="xs:complexType/xs:sequence/xs:element"/>
      <xsl:if test="exists($child-element-definitions)">
        <xsl:call-template name="handle-element-definitions">
          <xsl:with-param name="element-definitions" select="$child-element-definitions"/>
          <xsl:with-param name="xpath-to-parent" select="$xpath-to-element"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="handle-attribute-definitions">
    <xsl:param name="attribute-definitions" as="element(xs:attribute)+" required="yes"/>
    <xsl:param name="has-any-attribute-set" as="xs:boolean" required="yes"/>
    <xsl:param name="xpath-to-parent" as="xs:string" required="yes"/>
    <xsl:param name="parent-display-name" as="xs:string" required="yes"/>

    <xsl:variable name="base-message" as="xs:string" select="'Foutieve informatie voor ' || $parent-display-name || ': '"/>
    <xsl:variable name="sep" as="xs:string" select="'; '"/>

    <xsl:comment> == Check attributes of {$xpath-to-parent}: == </xsl:comment>
    <pattern>
      <rule context="{$xpath-to-parent}">
        <xsl:for-each select="$attribute-definitions">
          <xsl:variable name="attribute-name" as="xs:string" select="@name"/>
          <xsl:variable name="attribute-display-name" as="xs:string" select="local:get-display-name(.)"/>
          <xsl:variable name="exists-test-expression" as="xs:string" select="'exists(@' || $attribute-name || ')'"/>
          <xsl:variable name="empty-test-expression" as="xs:string" select="'empty(@' || $attribute-name || ')'"/>
          <xsl:variable name="base-technical-info" as="xs:string" select="$xpath-to-parent || '/@' || $attribute-name"/>

          <xsl:comment> == Attribute {$attribute-display-name}: == </xsl:comment>

          <!-- Required/optional: -->
          <xsl:variable name="is-required" as="xs:boolean" select="string(@use) eq 'required'"/>
          <xsl:if test="$is-required">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression" select="$exists-test-expression"/>
              <xsl:with-param name="message-parts" select="$base-message, 'Attribuut ', $attribute-display-name, ' ontbreekt'"/>
              <xsl:with-param name="technical-info-parts" select="$base-technical-info"/>
            </xsl:call-template>
          </xsl:if>

          <!-- Data type: -->
          <xsl:variable name="datatype" as="xs:string?" select="(@type, xs:simpleType/xs:restriction/@base)[1]"/>
          <xsl:variable name="datatype-test-expression" as="xs:string?">
            <xsl:choose>
              <xsl:when test="empty($datatype) or ($datatype eq 'xs:string')">
                <!-- Strings can be anything so a type check is superfluous. -->
                <xsl:sequence select="()"/>
              </xsl:when>
              <xsl:when test="starts-with($datatype, 'xs:')">
                <xsl:sequence select="'(@' || $attribute-name || ' castable as ' || $datatype || ')'"/>
              </xsl:when>
              <xsl:when test="$datatype eq 't-id'">
                <xsl:sequence select="'matches(@'|| $attribute-name || ', ' || local:apos($id-type-regexp) || ')'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence
                  select="error((), 'Unrecognized type information for ' || $xpath-to-parent || '/@' || $attribute-name || ': ' || $datatype)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:if test="exists($datatype-test-expression)">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression" select="$empty-test-expression || ' or ' || $datatype-test-expression"/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, ' heeft een onjuist formaat' )"/>
              <xsl:with-param name="technical-info-parts" select="( $base-technical-info, $sep, 'type=', $datatype )"/>
            </xsl:call-template>
          </xsl:if>

          <!-- Fixed value: -->
          <xsl:variable name="fixed-value" as="xs:string?" select="@fixed"/>
          <xsl:if test="exists($fixed-value)">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression"
                select="$empty-test-expression || ' or (@' || $attribute-name || ' eq ' || local:apos($fixed-value) || ')'"/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, ' heeft niet de verwachte vaste waarde ', local:q($fixed-value) )"/>
              <xsl:with-param name="technical-info-parts" select="$base-technical-info"/>
            </xsl:call-template>
          </xsl:if>

          <!-- Enumerated restrictions: -->
          <xsl:variable name="enumerated-restrictions" as="xs:string*" select="xs:simpleType/xs:restriction/xs:enumeration/@value"/>
          <xsl:if test="exists($enumerated-restrictions)">
            <xsl:variable name="enumerated-restrictions-sequence-expression" as="xs:string"
              select="'(' || string-join(for $restriction in $enumerated-restrictions return local:apos($restriction), ', ') || ')'"/>
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression"
                select="$empty-test-expression || ' or (@' || $attribute-name || ' = ' || $enumerated-restrictions-sequence-expression || ')'"/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, ' is onjuist' )"/>
              <xsl:with-param name="technical-info-parts"
                select="( $base-technical-info, $sep, 'allowed=', $enumerated-restrictions-sequence-expression )"/>
            </xsl:call-template>
          </xsl:if>

          <!-- Min and max length: -->
          <xsl:variable name="min-length" as="xs:integer?" select="xs:integer(xs:simpleType/xs:restriction/xs:minLength/@value)"/>
          <xsl:if test="exists($min-length)">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression"
                select="$empty-test-expression || ' or (string-length(@' || $attribute-name || ') ge ' || $min-length || ')' "/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, 
                  ' moet minstens ', string($min-length), ' karakters bevatten' )"/>
              <xsl:with-param name="technical-info-parts" select="( $base-technical-info, $sep, 'min-length=', string($min-length) )"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:variable name="max-length" as="xs:integer?" select="xs:integer(xs:simpleType/xs:restriction/xs:maxLength/@value)"/>
          <xsl:if test="exists($max-length)">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression"
                select="$empty-test-expression || ' or (string-length(@' || $attribute-name || ') le ' || $max-length || ')'"/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, 
                ' mag hoogstens ', string($max-length), ' karakters bevatten' )"/>
              <xsl:with-param name="technical-info-parts" select="( $base-technical-info, $sep, 'max-length=', string($max-length) )"/>
            </xsl:call-template>
          </xsl:if>

          <!-- Min and max inclusive: -->
          <xsl:variable name="min-inclusive" as="xs:decimal?" select="xs:decimal(xs:simpleType/xs:restriction/xs:minInclusive/@value)"/>
          <xsl:if test="exists($min-inclusive)">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression"
                select="$empty-test-expression || ' or (local:decimal-convert(@' || $attribute-name || ') ge ' || $min-inclusive || ')' "/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, 
                  ' moet minimaal ', string($min-inclusive), ' zijn' )"/>
              <xsl:with-param name="technical-info-parts" select="( $base-technical-info, $sep, 'min-inclusive=', string($min-inclusive) )"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:variable name="max-inclusive" as="xs:decimal?" select="xs:decimal(xs:simpleType/xs:restriction/xs:maxInclusive/@value)"/>
          <xsl:if test="exists($max-inclusive)">
            <xsl:call-template name="create-assertion">
              <xsl:with-param name="test-expression"
                select="$empty-test-expression || ' or (local:decimal-convert(@' || $attribute-name || ') le ' || $max-inclusive || ')' "/>
              <xsl:with-param name="message-parts"
                select="( $base-message, 'De waarde &quot;', '#@' || $attribute-name, '&quot; voor attribuut ', $attribute-display-name, 
                ' mag maximaal ', string($max-inclusive), ' zijn' )"/>
              <xsl:with-param name="technical-info-parts" select="( $base-technical-info, $sep, 'max-inclusive=', string($max-inclusive) )"/>
            </xsl:call-template>
          </xsl:if>

        </xsl:for-each>

        <!-- Add a rule to catch attributes that do not belong here (we explicitly exclude the xsi namespace attributes): -->
        <xsl:if test="not($has-any-attribute-set)">
          <xsl:variable name="attribute-name-sequence-expression" as="xs:string"
            select="'(' || fn:string-join(for $name in $attribute-definitions/@name/string() return '@'|| $name, ', ') || ', @xsi:*)'"/>
          <xsl:call-template name="create-assertion">
            <xsl:with-param name="test-expression" select="'empty(@* except ' || $attribute-name-sequence-expression || ')'"/>
            <xsl:with-param name="message-parts" select="( $base-message, 'Ongeldige attributen aangetroffen' )"/>
            <xsl:with-param name="technical-info-parts" select="( $xpath-to-parent, $sep, 'allowed=', $attribute-name-sequence-expression )"/>
          </xsl:call-template>
        </xsl:if>

      </rule>
    </pattern>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="create-assertion">
    <xsl:param name="is-report" as="xs:boolean" required="false" select="false()"/>
    <xsl:param name="test-expression" as="xs:string" required="true"/>
    <xsl:param name="message-parts" as="xs:string+" required="true"> </xsl:param>
    <xsl:param name="technical-info-parts" as="xs:string*" required="false" select="()"/>

    <xsl:element name="{if ($is-report) then 'report' else 'assert'}">
      <xsl:attribute name="test" select="$test-expression"/>
      <xsl:sequence select="local:message-parts-to-items($message-parts)"/>
      <xsl:if test="$do-add-technical-info and exists($technical-info-parts)">
        <xsl:text> [</xsl:text>
        <xsl:sequence select="local:message-parts-to-items($technical-info-parts)"/>
        <xsl:text>]</xsl:text>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:message-parts-to-items" as="item()*">
    <!-- Converts a sequence of message parts into the correct sequence of items for output. 
      A message part that starts with a # will expand into a <value-of select="{part-after-the-#}"/> element  
    -->
    <xsl:param name="message-parts" as="xs:string*"/>

    <xsl:for-each select="$message-parts">
      <xsl:choose>
        <xsl:when test="starts-with(., '#')">
          <value-of select="{substring(., 2)}"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-display-name" as="xs:string">
    <!-- Tries to find a user friendly name, suitable for display, for the definition in $elm.  -->
    <xsl:param name="elm" as="element()"/>

    <!-- When a user-friendly name for this element was available from the rtd, it is stored in a documentation element with source="name": -->
    <xsl:variable name="name" as="xs:string" select="string(($elm/xs:annotation/xs:documentation[@source eq 'name'])[1])"/>
    <xsl:choose>
      <xsl:when test="$name eq ''">
        <xsl:sequence select="local:q(($elm/@name, $elm/@value)[1])"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="local:q($name)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:xpath-concat" as="xs:string">
    <!-- Concatenates the XPath expressions $remainder to $base. Makes sure only a single / is in-between them.  -->
    <xsl:param name="base" as="xs:string"/>
    <xsl:param name="remainder" as="xs:string"/>
    <xsl:sequence select="if (ends-with($base, '/')) then $base || $remainder else $base || '/' || $remainder"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:apos" as="xs:string">
    <!-- Puts a value in single quotes (apostrophes) and doubles every single quote in the input. The result is a valid quoted XPath string. -->
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="'''' || replace($in, '''', '''''') || ''''"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:q" as="xs:string">
    <!-- Puts a value in double quotes -->
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="'&quot;' || $in || '&quot;'"/>
  </xsl:function>

</xsl:stylesheet>
