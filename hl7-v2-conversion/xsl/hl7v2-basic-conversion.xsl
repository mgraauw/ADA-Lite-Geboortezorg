<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:bc-hl7v2c="https://babyconnect.org/ns/hl7v2-conversion" xmlns:local="#local.uf3_5pv_jhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Simple driver stylesheet for the basic conversion of a HL7V2 message to the basic structured format.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:mode name="mode-cleanup" on-no-match="shallow-copy"/>

  <xsl:include href="../xslmod/hl7v2-conversion.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-hl7v2" as="xs:string" required="yes"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="hl7v2-structured" as="element(hl7v2-structured)">
    <xsl:call-template name="bc-hl7v2c:hl7v2-to-structured">
      <xsl:with-param name="dref-hl7v2" select="$dref-hl7v2"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="a-code" as="xs:integer" select="string-to-codepoints('A')"/>

  <!-- ================================================================== -->
  
  <xsl:template match="/">
  
    <xsl:variable name="conversion-result" as="element()">
      <xsl:apply-templates select="/*"/>
    </xsl:variable>

  <xsl:call-template name="cleanup">
    <xsl:with-param name="elm" select="$conversion-result"/>
  </xsl:call-template>

  </xsl:template>
  
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  
  <xsl:template match="*[exists(hl7v2-value)]">
    <xsl:param name="repeat-index" as="xs:integer?" required="no" select="()" tunnel="yes"/>

    <xsl:variable name="values" as="xs:string*">
      <xsl:for-each select="hl7v2-value">
        <xsl:variable name="elm" as="element(subcomponent)?" select="local:get-subcomponent-element(., $repeat-index)"/>
        <xsl:choose>
          <xsl:when test="string($elm) ne ''">
            <xsl:sequence select="local:value-convert(string($elm), @conversion)"/>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="exists($values)">
        <xsl:copy>
          <xsl:attribute name="value" select="string-join($values, ' ')"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <!-- Discard element -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="*[exists(hl7v2-repeat-char)]">
    <xsl:param name="repeat-index" as="xs:integer?" required="no" select="()" tunnel="yes"/>

    <xsl:variable name="repeat-char" as="xs:string"
      select="if (exists($repeat-index)) then codepoints-to-string($a-code + $repeat-index - 1) else '?'"/>
    <xsl:copy>
      <xsl:attribute name="value" select="$repeat-char"/>
    </xsl:copy>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="hl7v2-repeat">
    <xsl:param name="repeat-index" as="xs:integer?" required="no" select="()" tunnel="yes"/>
    <!-- This looks at the field numbered @field-index and takes the highest integer value of this field as a repeat count. -->

    <xsl:variable name="repeat-elm" as="element(hl7v2-repeat)" select="."/>
    <xsl:variable name="field-index" as="xs:integer" select="xs:integer(@field-index)"/>
    <xsl:variable name="segment-elements" as="element(segment)*" select="local:get-segment-elements(., $repeat-index)"/>
    <xsl:variable name="counts" as="xs:integer*">
      <xsl:for-each select="$segment-elements">
        <xsl:variable name="field-value" as="xs:string" select="string(fieldgroup[$field-index])"/>
        <xsl:sequence select="if ($field-value castable as xs:integer) then xs:integer($field-value) else ()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="count" as="xs:integer" select="max($counts)"/>

    <xsl:for-each select="1 to $count">
      <xsl:variable name="index" as="xs:integer" select="position()"/>
      <xsl:comment> == Start repeat {$index}/{$count} == </xsl:comment>
      <xsl:apply-templates select="$repeat-elm/*">
        <xsl:with-param name="repeat-index" as="xs:integer" select="$index" tunnel="yes"/>
      </xsl:apply-templates>
      <xsl:comment> == End repeat {$index}/{$count} == </xsl:comment>
    </xsl:for-each>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="comment()"/>
  
  <!-- ================================================================== -->
  <!-- FINAL CLEANUP: -->
  
  <xsl:template name="cleanup">
    <xsl:param name="elm" as="element()" required="yes"/>
    
    <xsl:apply-templates select="$elm" mode="mode-cleanup"/>
  </xsl:template>
  
  <xsl:template match="*[exists(@value)][@value eq '']" mode="mode-cleanup"/>
  <xsl:template match="*[empty(@value)][empty(.//*[exists(@value)][@value ne ''])]" mode="mode-cleanup"/>
  <xsl:template match="text()[normalize-space() eq '']" mode="mode-cleanup"/>
    
  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:function name="local:value-convert" as="xs:string">
    <xsl:param name="value" as="xs:string"/>
    <xsl:param name="conversion" as="xs:string?"/>

    <xsl:choose>

      <xsl:when test="string($conversion) eq ''">
        <xsl:sequence select="$value"/>
      </xsl:when>

      <xsl:when test="$conversion eq 'datetime'">
        <xsl:choose>
          <xsl:when test="matches($value, '^[0-9]{8}$')">
            <xsl:sequence select="substring($value, 1, 4) || '-' || substring($value, 5, 2) || '-' || substring($value, 7, 2)"/>
          </xsl:when>
          <xsl:when test="matches($value, '^[0-9]{14}$')">
            <xsl:sequence
              select="substring($value, 1, 4) || '-' || substring($value, 5, 2) || '-' || substring($value, 7, 2) ||
              'T' || substring($value, 9, 2) || ':' || substring($value, 11, 2) || ':' || substring($value, 13, 2)"
            />
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="error((), 'Unrecognized date/time value: ' || local:q($value))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="$conversion eq 'weekdays'">
        <xsl:choose>
          <xsl:when test="matches($value, '^[0-9]{1,2}w$')">
            <xsl:sequence select="string(xs:integer(substring-before($value, 'w')) * 7)"/>
          </xsl:when>
          <xsl:when test="matches($value, '^[0-9]{1,2}w[0-7]d$')">
            <xsl:sequence
              select="string((xs:integer(substring-before($value, 'w')) * 7) +
              xs:integer(substring-before($value, 'd') => substring-after('w')))"
            />
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="error((), 'Unrecognized weekdays (xxwxd) value: ' || local:q($value))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:otherwise>
        <xsl:sequence select="error((), 'Unrecognized conversion: ' || local:q($conversion))"/>
      </xsl:otherwise>

    </xsl:choose>

  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-subcomponent-element" as="element(subcomponent)?">
    <xsl:param name="base-elm" as="element()"/>
    <xsl:param name="repeat-index" as="xs:integer?"/>

    <!-- Gather data: -->
    <xsl:variable name="fieldgroup-index" as="xs:integer" select="local:get-int($base-elm/@fieldgroup-index)"/>
    <xsl:variable name="field-index" as="xs:integer" select="local:get-int($base-elm/@field-index)"/>
    <xsl:variable name="component-index" as="xs:integer" select="local:get-int($base-elm/@component-index)"/>
    <xsl:variable name="subcomponent-index" as="xs:integer" select="local:get-int($base-elm/@subcomponent-index)"/>
    <xsl:variable name="required" as="xs:boolean" select="xs:boolean(($base-elm/@required, true())[1])"/>

    <!-- Get and check the element: -->
    <xsl:variable name="segment-elm" as="element(segment)*" select="local:get-segment-elements($base-elm, $repeat-index)"/>
    <xsl:if test="count($segment-elm) gt 1">
      <xsl:sequence select="error((), 'Multiple segments returned for: ' || local:atts2str($base-elm/@*))"/>
    </xsl:if>
    <xsl:variable name="subcomponent-elm" as="element(subcomponent)?"
      select="$segment-elm/fieldgroup[$fieldgroup-index]/field[$field-index]/component[$component-index]/subcomponent[$subcomponent-index]"/>
    <xsl:if test="$required and (string($subcomponent-elm) eq '')">
      <xsl:sequence select="error((), 'Required HL7V2 value not found: ' || local:atts2str($base-elm/@*))"/>
    </xsl:if>
    <xsl:sequence select="$subcomponent-elm"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-segment-elements" as="element(segment)*">
    <xsl:param name="base-elm" as="element()"/>
    <xsl:param name="repeat-index" as="xs:integer?"/>

    <!-- Gather data: -->
    <xsl:variable name="segment-name" as="xs:string" select="$base-elm/@segment-name"/>
    <xsl:variable name="repeat-field-index" as="xs:integer?" select="xs:integer($base-elm/@repeat-field-index)"/>
    <xsl:variable name="field1" as="xs:string?" select="$base-elm/@field1"/>
    <xsl:variable name="field2" as="xs:string?" select="$base-elm/@field2"/>
    <xsl:variable name="field3" as="xs:string?" select="$base-elm/@field3"/>

    <!-- Get it: -->
    <xsl:sequence
      select="$hl7v2-structured/segment[@name eq $segment-name]
       [if (exists($repeat-field-index) and exists($repeat-index) and (string(fieldgroup[$repeat-field-index]) castable as xs:integer)) then
         xs:integer(fieldgroup[$repeat-field-index]) eq $repeat-index else true()]
       [if (exists($field1)) then string(fieldgroup[1]) eq $field1 else true()]
       [if (exists($field2)) then string(fieldgroup[2]) eq $field2 else true()]
       [if (exists($field3)) then string(fieldgroup[3]) eq $field3 else true()]
      "
    />
  </xsl:function>
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-int" as="xs:integer">
    <xsl:param name="att" as="attribute()?"/>
    <xsl:param name="default" as="xs:integer"/>
    <xsl:sequence select="xs:integer(($att, $default)[1])"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-int" as="xs:integer">
    <xsl:param name="att" as="attribute()?"/>
    <xsl:sequence select="local:get-int($att, 1)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:atts2str" as="xs:string">
    <xsl:param name="atts" as="attribute()*"/>

    <xsl:variable name="att-strings" as="xs:string*">
      <xsl:for-each select="$atts">
        <xsl:sequence select="local-name(.) || '=' || local:q(.)"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:sequence select="string-join($att-strings, ' ')"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:q" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="'&quot;' || $in || '&quot;'"/>
  </xsl:function>

</xsl:stylesheet>
