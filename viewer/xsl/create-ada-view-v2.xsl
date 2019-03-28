<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:local="#local.tz2_jrr_fhb" exclude-result-prefixes="#all">
  <!-- ================================================================== -->
  <!-- 
       
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="html" indent="no" encoding="UTF-8"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-viewer-template" as="xs:string" required="yes"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="data-root" as="document-node()" select="/"/>

  <!-- Get the viewer template on board: -->
  <xsl:variable name="viewer-template-root" as="element(ada-viewer-template)" select="doc($dref-viewer-template)/*"/>

  <!-- From this, get the specification: -->
  <xsl:variable name="dref-specification" as="xs:string"
    select="string(resolve-uri($viewer-template-root/@specification, base-uri($viewer-template-root)))"/>
  <xsl:variable name="specification-root" as="element(dataset)" select="doc($dref-specification)/*"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">

    <xsl:variable name="page-title" as="xs:string" select="'TBD'"/>
    <html>
      <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>
          <xsl:value-of select="$page-title"/>
        </title>
      </head>
      <body>
        <xsl:call-template name="do-header">
          <xsl:with-param name="header" select="$viewer-template-root/header"/>
        </xsl:call-template>

        <xsl:for-each select="$viewer-template-root/section">
          <xsl:call-template name="do-section"/>
        </xsl:for-each>
      </body>
    </html>

  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-header">
    <xsl:param name="header" as="element(header)" required="no" select="."/>

    <table border="0">
      <xsl:for-each select="$header/item">
        <tr>
          <td>
            <xsl:call-template name="do-mixed-contents">
              <xsl:with-param name="parent-elm" select="prompt"/>
            </xsl:call-template>
            <xsl:text>:&#160;</xsl:text>
          </td>
          <td>
            <xsl:call-template name="do-mixed-contents">
              <xsl:with-param name="parent-elm" select="value"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-section">
    <xsl:param name="section" as="element(section)" required="no" select="."/>

    <h1>
      <xsl:if test="exists($section/@color)">
        <xsl:attribute name="style" select="concat('background-color:', $section/@color, ';')"/>
      </xsl:if>
      <xsl:call-template name="do-mixed-contents">
        <xsl:with-param name="parent-elm" select="title"/>
      </xsl:call-template>
    </h1>

    <xsl:apply-templates select="* except title" mode="mode-do-section"/>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="table-view" mode="mode-do-section">
    <table border="1" cellpadding="0" cellspacing="0">
      <!-- TBD in CSS later -->
      <tr>
        <xsl:for-each select="item">
          <th>
            <xsl:call-template name="do-mixed-contents">
              <xsl:with-param name="parent-elm" select="prompt"/>
            </xsl:call-template>
          </th>
        </xsl:for-each>
      </tr>
      <tr>
        <xsl:for-each select="item">
          <td>
            <xsl:call-template name="do-mixed-contents">
              <xsl:with-param name="parent-elm" select="value"/>
            </xsl:call-template>
          </td>
        </xsl:for-each>
      </tr>


    </table>



  </xsl:template>


  <!-- ================================================================== -->
  <!-- PROCESSING OF POSSIBLY MIXED CONTENTS -->

  <xsl:template name="do-mixed-contents">
    <xsl:param name="parent-elm" as="element()" required="yes"/>
    <xsl:param name="context" as="node()" required="no" select="$data-root"/>

    <xsl:apply-templates select="$parent-elm/node()" mode="mode-do-mixed-contents">
      <xsl:with-param name="context" as="node()" select="$context" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="text()" mode="mode-do-mixed-contents">
    <xsl:param name="context" as="node()" required="yes" tunnel="yes"/>
    <xsl:value-of select="local:parse-string(., $context)"/>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="@* | node()" mode="mode-do-mixed-contents" priority="-10">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- EXPRESSION PARSING: -->

  <xsl:function name="local:parse-string" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:param name="context" as="node()"/>

    <xsl:variable name="result-parts" as="xs:string*">
      <xsl:analyze-string select="$in" regex="\{{(.+?)\}}">
        <xsl:matching-substring>
          <xsl:variable name="expression" as="xs:string" select="normalize-space(regex-group(1))"/>
          <xsl:variable name="value-parts" as="xs:string*">
            <xsl:for-each select="local:resolve-simple-xpath-expression($expression, $context)">
              <xsl:sequence select="concat(local:massage-value(string((@displayName, @value, '&#160;')[1])), @unit)"/>
            </xsl:for-each>
          </xsl:variable>
          <xsl:sequence select="string-join($value-parts, ' ')"/>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:sequence select="."/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:sequence select="string-join($result-parts, '')"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:resolve-simple-xpath-expression" as="element()*">
    <xsl:param name="expression" as="xs:string"/>
    <xsl:param name="context" as="node()"/>

    <xsl:variable name="expression-parts" as="xs:string*" select="tokenize($expression, '/')[normalize-space(.) ne '']"/>
    <xsl:variable name="start-context" as="node()" select="if (starts-with($expression, '/')) then $data-root else $context"/>
    <xsl:sequence select="local:resolve-simple-xpath-expression-by-parts($expression-parts, $start-context)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->


  <xsl:function name="local:resolve-simple-xpath-expression-by-parts" as="element()*">
    <xsl:param name="expression-parts" as="xs:string*"/>
    <xsl:param name="contexts" as="node()*"/>

    <xsl:for-each select="$contexts">
      <xsl:variable name="context" as="node()" select="."/>
      <xsl:choose>
        <xsl:when test="empty($expression-parts)">
          <xsl:sequence select="if ($context instance of element()) then $context else ()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="first-expression-part" as="xs:string" select="normalize-space($expression-parts[1])"/>
          <xsl:variable name="index" as="xs:integer?">
            <xsl:choose>
              <xsl:when test="ends-with($first-expression-part, ']')and contains($first-expression-part, '[')">
                <xsl:variable name="index-string" as="xs:string" select="substring-before(substring-after($first-expression-part, '['), ']')"/>
                <xsl:sequence select="if ($index-string castable as xs:integer) then xs:integer($index-string) else ()"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="()"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="element-name" as="xs:string"
            select="if (contains($first-expression-part, '[')) then substring-before($first-expression-part, '[') else $first-expression-part "/>
          <xsl:variable name="new-context-all" as="element()*">
            <xsl:choose>
              <xsl:when test="$element-name eq '*'">
                <xsl:sequence select="$context/*"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$context/*[local-name(.) eq $element-name]"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="new-context" as="element()*" select="if (exists($index)) then $new-context-all[$index] else $new-context-all"/>
          <xsl:choose>
            <xsl:when test="empty($new-context)">
              <xsl:sequence select="()"/>
            </xsl:when>
            <xsl:when test="count($expression-parts) eq 1">
              <xsl:sequence select="$new-context"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="local:resolve-simple-xpath-expression-by-parts(subsequence($expression-parts, 2), $new-context)"/>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>


  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:massage-value" as="xs:string">
    <xsl:param name="value" as="xs:string"/>

    <xsl:variable name="date-format" as="xs:string" select="'[D]-[M]-[Y]'"/>
    <xsl:choose>
      <xsl:when test="$value eq 'true'">
        <xsl:sequence select="'ja'"/>
      </xsl:when>
      <xsl:when test="$value eq 'false'">
        <xsl:sequence select="'nee'"/>
      </xsl:when>
      <xsl:when test="$value castable as xs:dateTime">
        <!-- Discard time info for now? -->
        <xsl:sequence select="format-dateTime(xs:dateTime($value), $date-format)"/>
      </xsl:when>
      <xsl:when test="$value castable as xs:date">
        <xsl:sequence select="format-date(xs:date($value), $date-format)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>
