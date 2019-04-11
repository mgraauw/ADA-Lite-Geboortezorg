<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:bc-hl7v2c="https://babyconnect.org/ns/hl7v2-conversion" xmlns:local="#local.pbl_z4v_jhb" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!--	
       
	-->
  <!-- ================================================================== -->
  <!-- HL7 V2 TEST FORMAT TO BASIC STRUCTURED XML: -->

  <xsl:template name="bc-hl7v2c:hl7v2-to-structured" as="element(hl7v2-structured)">
    <xsl:param name="dref-hl7v2" as="xs:string" required="yes"/>

    <!-- We only accept messages with the standard control characters, so the first line must start with: -->
    <xsl:variable name="line1-start" as="xs:string" select="'MSH|^~\&amp;|'"/>

    <hl7v2-structured timestamp="{current-dateTime()}" source="{$dref-hl7v2}">

      <!-- Read the file and split into lines:: -->
      <xsl:variable name="lines" as="xs:string*" select="tokenize(unparsed-text($dref-hl7v2), '[&#10;&#13;]+')[normalize-space(.) ne '']"/>

      <!-- Pre-flight check: -->
      <xsl:if test="not(starts-with($lines[1], $line1-start))">
        <xsl:sequence
          select="error((), 'Unrecognized file format in ' || local:q($dref-hl7v2) || ': First line does not start with ' || local:q($line1-start))"/>
      </xsl:if>

      <!-- Each line will become a segment. This is split into fieldgroups using the | character. The first fieldgroup is the segment's name: -->
      <xsl:for-each select="$lines">
        <xsl:variable name="line" as="xs:string" select="."/>
        <xsl:variable name="fieldgroups" as="xs:string*" select="tokenize($line, '\|')"/>
        <xsl:if test="count($fieldgroups) le 1">
          <xsl:sequence select="error((), 'Unrecognized file format in ' || local:q($dref-hl7v2) || ': Invalid number of fields')"/>
        </xsl:if>

        <segment name="{$fieldgroups[1]}">
          <xsl:variable name="segment-index" as="xs:integer" select="position()"/>
          <xsl:for-each select="subsequence($fieldgroups, 2)">
            <xsl:variable name="fieldgroup-index" as="xs:integer" select="position()"/>
            <xsl:variable name="fieldgroup" as="xs:string" select="."/>

            <fieldgroup>
              <xsl:choose>

                <!-- Special handling of first fieldgroup (that defines all the control characters): -->
                <xsl:when test="($segment-index eq 1) and ($fieldgroup-index eq 1)">
                  <field>
                    <component>
                      <subcomponent>
                        <xsl:value-of select="$fieldgroup"/>
                      </subcomponent>
                    </component>
                  </field>
                </xsl:when>

                <!-- All other fieldgroups: -->
                <xsl:otherwise>

                  <!-- Fieldgroups can have multiple fields, separated with a ~: -->
                  <xsl:variable name="fields" as="xs:string*" select="tokenize($fieldgroup, '~')"/>
                  <xsl:for-each select="if (empty($fields)) then '' else $fields">
                    <xsl:variable name="field" as="xs:string" select="."/>

                    <field>
                      <!-- A field can be split into components, using the ^ as separator: -->
                      <xsl:variable name="components" as="xs:string*" select="tokenize($field, '\^')"/>
                      <xsl:for-each select="if (empty($components)) then '' else $components">
                        <xsl:variable name="component" as="xs:string" select="."/>

                        <component>
                          <!-- A component can be slit in sub-components, using the & as separator:  -->
                          <xsl:variable name="subcomponents" as="xs:string*" select="tokenize($component, '&amp;')"/>
                          <xsl:for-each select="if (empty($subcomponents)) then '' else $subcomponents">
                            <xsl:variable name="subcomponent" as="xs:string" select="."/>

                            <subcomponent>
                              <xsl:sequence select="local:process-escape-characters(., $dref-hl7v2)"/>
                            </subcomponent>

                          </xsl:for-each>
                        </component>

                      </xsl:for-each>
                    </field>

                  </xsl:for-each>

                </xsl:otherwise>
              </xsl:choose>

            </fieldgroup>

          </xsl:for-each>
        </segment>

      </xsl:for-each>

    </hl7v2-structured>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:process-escape-characters" as="node()*">
    <xsl:param name="in" as="xs:string"/>
    <xsl:param name="dref-hl7v2" as="xs:string"/>

   
      <xsl:analyze-string select="$in" regex="\\(.+?)\\">
        <xsl:matching-substring>
          <xsl:variable name="escape-code" as="xs:string" select="regex-group(1)"/>
          <xsl:choose>
            <xsl:when test="$escape-code = ('H', 'N')">
              <!-- Ignore (highlighting) -->
            </xsl:when>
            <xsl:when test="$escape-code eq 'F'">
              <xsl:value-of select="'|'"/>
            </xsl:when>
            <xsl:when test="$escape-code eq 'S'">
              <xsl:value-of select="'^'"/>
            </xsl:when>
            <xsl:when test="$escape-code eq 'T'">
              <xsl:value-of select="'&amp;'"/>
            </xsl:when>
            <xsl:when test="$escape-code eq 'R'">
              <xsl:value-of select="'~'"/>
            </xsl:when>
            <xsl:when test="$escape-code eq 'E'">
              <xsl:value-of select="'\'"/>
            </xsl:when>
            <!-- This seems to be special in the Astraia files: -->
            <xsl:when test="$escape-code eq '.br'">
              <br/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="error((), 'Unhandeld escape-sequence in ' || local:q($dref-hl7v2) || ': ' || local:q(.))"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:matching-substring>

        <xsl:non-matching-substring>
          <xsl:value-of select="."/>
        </xsl:non-matching-substring>

      </xsl:analyze-string>
    
   
  </xsl:function>

  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:function name="local:q" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="'&quot;' || $in || '&quot;'"/>
  </xsl:function>

</xsl:stylesheet>
