<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="#local.vgm_d5w_fhb"
  xmlns:bc-al2af="https://babyconnect.org/ns/ada-lite2ada-full" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       This stylesheet combines several inputs to create a user-friendly HTML view of an ADA-lite or ADA-full data file.
       - Main input to the stylesheet is the ADA-lite or ADA-full data file
         Default is ADA-lite. If you supply an ADA-full data file, set the input-is-ada-full parameter to true.
       - Parameter dref-viewer-template must point to a viewer-template. A schema for such a template can be found in 
         ../xsd/viewer-template.xsd
       - This file in turn, through its /*/@specification attribute, must point to the appropriate specification 
         (Retrieve-Transaction Dataset or rtd, root element <dataset>)
         
       The system works with simple XPaths:  
       - To set the context for something, simple XPath expressions can be used, e.g. /*/vrouw[1]/geboortedatum[1]
         Accepted are * for all children and [n] for the n-th child.
       - You can set the context (with @context) on almost all elements. 
       - Text nodes can contain theses simple XPath expressions between curly braces, e.g. {vrouw/geboortedatum}
         - If you prefix this with # (e.g. #/*/vrouw[1]/geboortedatum[1]) you get the user-friendly name of the element 
           (as present in the specification).       
       - {} will give you the value of the context item, {#} the user-friendly name of the context item
       - You can add a "specifier" at the end of a curly-braced expression, after a % sign to get additional conversions. The following are defined:
         - %wd : Convert a number of days into a number of weeks + days (e.g. 240 ==> 34w2d)
       - Relative paths are always computed based on the context of the parent element.
       
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>
  <xsl:mode name="mode-do-mixed-contents" on-no-match="shallow-copy"/>
  <xsl:mode name="mode-do-section" on-no-match="fail"/>

  <xsl:include href="../../design/xsl/lib/xsl-common.xsl"/>
  <xsl:include href="../../design/xsl/lib/ada-lite2ada-full.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="input-is-ada-full" as="xs:string" required="no" select="string(false())">
    <!-- Set this to true when the input file is an ADA-full file. -->
  </xsl:param>

  <xsl:param name="dref-viewer-template" as="xs:string" required="yes">
    <!-- Reference to the viewer-template. Prefix this path with file:/  -->
  </xsl:param>

  <xsl:param name="dref-css" as="xs:string" required="no" select="resolve-uri('../data/viewer.css', static-base-uri())">
    <!-- Reference to the CSS file used for generating the result.  -->
  </xsl:param>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <!-- Get the viewer template on board: -->
  <xsl:variable name="viewer-template-document" as="document-node()?"
    select="if (doc-available($dref-viewer-template)) then doc($dref-viewer-template) else ()"/>
  <xsl:variable name="viewer-template-root" as="element()?" select="$viewer-template-document/*"/>

  <!-- From this, get the specification: -->
  <xsl:variable name="dref-specification" as="xs:string"
    select="string(resolve-uri($viewer-template-root/@specification, base-uri($viewer-template-root)))"/>
  <xsl:variable name="specification-document" as="document-node()?"
    select="if (doc-available($dref-specification)) then doc($dref-specification) else ()"/>
  <xsl:variable name="specification-root" as="element()?" select="$specification-document/*"/>

  <!-- Get the root of the data. Convert this to ADA-full if the input is ADA-lite: -->
  <xsl:variable name="full-data-document" as="document-node()">
    <xsl:choose>
      <xsl:when test="xs:boolean($input-is-ada-full)">
        <xsl:sequence select="/"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:document>
          <xsl:call-template name="bc-al2af:ada-lite2ada-full">
            <xsl:with-param name="ada-lite-root-element" select="/*"/>
            <xsl:with-param name="rtd-root-element" select="$specification-root"/>
          </xsl:call-template>
        </xsl:document>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="default-value-separator" as="node()*">
    <xsl:text> </xsl:text>
  </xsl:variable>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">

    <!-- Pre-flight checks: -->
    <xsl:if test="empty($viewer-template-root/self::ada-viewer-template)">
      <xsl:sequence select="error((), 'Missing or invalid viewer-template ' || local:q($dref-viewer-template))"/>
    </xsl:if>
    <xsl:if test="empty($specification-root/self::dataset)">
      <xsl:sequence select="error((), 'Missing or invalid ADA specification ' || local:q($dref-specification))"/>
    </xsl:if>

    <!-- Establish the main context: -->
    <xsl:variable name="initial-context" as="xs:string" select="($viewer-template-root/@context, '/*')[1]"/>
    <xsl:variable name="initial-data-contexts" as="node()*" select="local:resolve-data-xpath-expression($initial-context, $full-data-document)"/>
    <xsl:variable name="initial-specification-context" as="element()?" select="local:resolve-specification-xpath-expression($initial-context, ())"/>

    <!-- Get the title: -->
    <xsl:variable name="title-html" as="node()*"
      select="local:get-title-html($viewer-template-root/title, $initial-data-contexts, $initial-specification-context)"/>

    <!-- Create the HTML: -->
    <html>
      <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title> { string-join($title-html) }</title>
        <xsl:if test="unparsed-text-available($dref-css)">
          <style> 
            <xsl:value-of select="unparsed-text($dref-css)"/>
          </style>
        </xsl:if>
      </head>
      <body>
        <h1 class="main-title">
          <xsl:sequence select="$title-html"/>
        </h1>

        <xsl:call-template name="do-header">
          <xsl:with-param name="header" select="$viewer-template-root/header"/>
          <xsl:with-param name="data-contexts" select="$initial-data-contexts"/>
          <xsl:with-param name="specification-context" select="$initial-specification-context"/>
        </xsl:call-template>

        <xsl:for-each select="$viewer-template-root/section">
          <xsl:call-template name="do-section">
            <xsl:with-param name="data-contexts" select="$initial-data-contexts"/>
            <xsl:with-param name="specification-context" select="$initial-specification-context"/>
          </xsl:call-template>
        </xsl:for-each>

      </body>
    </html>

  </xsl:template>

  <!-- ================================================================== -->
  <!-- TITLE: -->

  <xsl:function name="local:get-title-html" as="node()*">
    <xsl:param name="title" as="element(title)?"/>
    <xsl:param name="data-contexts" as="node()*"/>
    <xsl:param name="specification-context" as="element()?"/>

    <xsl:variable name="title-parent" as="element(title)">
      <xsl:choose>
        <xsl:when test="empty($title)" expand-text="false">
          <title>{#}</title>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$title"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="do-mixed-contents">
      <xsl:with-param name="parent-elm" select="$title-parent"/>
      <xsl:with-param name="data-contexts" select="$data-contexts"/>
      <xsl:with-param name="specification-context" select="$specification-context"/>
    </xsl:call-template>
  </xsl:function>


  <!-- ================================================================== -->
  <!-- HEADER: -->

  <xsl:template name="do-header">
    <xsl:param name="header" as="element(header)" required="no" select="."/>
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>

    <xsl:variable name="header-context-expression" as="xs:string?" select="$header/@context"/>
    <xsl:variable name="header-data-contexts" as="node()*" select="local:resolve-data-xpath-expression($header-context-expression, $data-contexts)"/>
    <xsl:variable name="header-specification-context" as="element()?"
      select="local:resolve-specification-xpath-expression($header-context-expression, $specification-context)"/>

    <div class="header">
      <table class="header-table">
        <xsl:choose>
          <xsl:when test="exists($header/col1) and exists($header/col2)">
            <table width="100%">
              <tr valign="top">
                <td width="50%">
                  <xsl:call-template name="create-header-table">
                    <xsl:with-param name="parent" select="$header/col1"/>
                    <xsl:with-param name="parent-data-contexts" select="$header-data-contexts"/>
                    <xsl:with-param name="parent-specification-context" select="$header-specification-context"/>
                  </xsl:call-template>
                </td>
                <td width="50%">
                  <xsl:call-template name="create-header-table">
                    <xsl:with-param name="parent" select="$header/col2"/>
                    <xsl:with-param name="parent-data-contexts" select="$header-data-contexts"/>
                    <xsl:with-param name="parent-specification-context" select="$header-specification-context"/>
                  </xsl:call-template>
                </td>
              </tr>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="create-header-table">
              <xsl:with-param name="parent" select="$header"/>
              <xsl:with-param name="parent-data-contexts" select="$header-data-contexts"/>
              <xsl:with-param name="parent-specification-context" select="$header-specification-context"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </table>
    </div>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="create-header-table">
    <xsl:param name="parent" as="element()" required="yes"/>
    <xsl:param name="parent-data-contexts" as="node()*" required="yes"/>
    <xsl:param name="parent-specification-context" as="element()?" required="yes"/>

    <table class="header-table">
      <xsl:for-each select="local:effective-item-list($parent, $parent-specification-context)">
        <tr>
          <td>
            <xsl:call-template name="get-item-prompt-contents">
              <xsl:with-param name="item" select="."/>
              <xsl:with-param name="data-contexts" select="$parent-data-contexts"/>
              <xsl:with-param name="specification-context" select="$parent-specification-context"/>
            </xsl:call-template>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td>
            <xsl:call-template name="get-item-value-contents">
              <xsl:with-param name="item" select="."/>
              <xsl:with-param name="data-contexts" select="$parent-data-contexts"/>
              <xsl:with-param name="specification-context" select="$parent-specification-context"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>


  <!-- ================================================================== -->
  <!-- SECTION -->

  <xsl:template name="do-section">
    <xsl:param name="section" as="element(section)" required="no" select="."/>
    <xsl:param name="section-level" as="xs:integer" required="no" select="1"/>
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>

    <xsl:variable name="section-context-expression" as="xs:string?" select="$section/@context"/>
    <xsl:variable name="section-data-contexts" as="node()*" select="local:resolve-data-xpath-expression($section-context-expression, $data-contexts)"/>
    <xsl:variable name="section-specification-context" as="element()?"
      select="local:resolve-specification-xpath-expression($section-context-expression, $specification-context)"/>

    <div class="{ if ($section-level eq 1) then 'top-level-section' else 'child-section' }">
      <xsl:element name="h{$section-level}">
        <xsl:attribute name="class" select="'section-title'"/>
        <xsl:variable name="color" as="xs:string" select="($section/@color, 'silver')[1]"/>
        <xsl:attribute name="style" select="concat('background-color:', $color, ';')"/>
        <xsl:sequence select="local:get-title-html($section/title, $section-data-contexts, $section-specification-context)"/>
      </xsl:element>
      <xsl:apply-templates select="$section/* except $section/title" mode="mode-do-section">
        <xsl:with-param name="data-contexts" select="$section-data-contexts"/>
        <xsl:with-param name="specification-context" select="$section-specification-context"/>
        <xsl:with-param name="section-level" select="$section-level"/>
      </xsl:apply-templates>
    </div>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="table-view" mode="mode-do-section">
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>

    <xsl:variable name="table-view" as="element(table-view)" select="."/>
    <xsl:variable name="table-view-context-expression" as="xs:string?" select="$table-view/@context"/>
    <xsl:variable name="table-view-data-contexts" as="node()*"
      select="local:resolve-data-xpath-expression($table-view-context-expression, $data-contexts)"/>
    <xsl:variable name="table-view-specification-context" as="element()?"
      select="local:resolve-specification-xpath-expression($table-view-context-expression, $specification-context)"/>

    <xsl:variable name="effective-item-list" as="element(item)*" select="local:effective-item-list($table-view, $table-view-specification-context)"/>

    <xsl:if test="exists($effective-item-list)">
      <table class="table-view">
        <!-- TBD in CSS later -->
        <tr>
          <xsl:for-each select="$effective-item-list">
            <th>
              <xsl:if test="normalize-space(@width) ne ''">
                <xsl:attribute name="style" select="'width: ' || @width || ';'"/>
              </xsl:if>
              <xsl:call-template name="get-item-prompt-contents">
                <xsl:with-param name="data-contexts" select="$table-view-data-contexts"/>
                <xsl:with-param name="specification-context" select="$table-view-specification-context"/>
              </xsl:call-template>
            </th>
          </xsl:for-each>
        </tr>
        <xsl:for-each select="$table-view-data-contexts">
          <xsl:variable name="row-data-context" as="node()" select="."/>
          <tr>
            <xsl:for-each select="$effective-item-list">
              <td>
                <xsl:call-template name="get-item-value-contents">
                  <xsl:with-param name="data-contexts" select="$row-data-context"/>
                  <xsl:with-param name="specification-context" select="$table-view-specification-context"/>
                </xsl:call-template>
              </td>
            </xsl:for-each>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="section" mode="mode-do-section">
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>
    <xsl:param name="section-level" as="xs:integer" required="yes"/>

    <xsl:call-template name="do-section">
      <xsl:with-param name="section-level" select="$section-level + 1"/>
      <xsl:with-param name="data-contexts" select="$data-contexts"/>
      <xsl:with-param name="specification-context" select="$specification-context"/>
    </xsl:call-template>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="auto-sections" mode="mode-do-section">
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>
    <xsl:param name="section-level" as="xs:integer" required="yes"/>

    <xsl:variable name="auto-sections" as="element(auto-sections)" select="."/>
    <xsl:variable name="auto-sections-context-expression" as="xs:string?" select="$auto-sections/@context"/>
    <xsl:variable name="auto-sections-data-contexts" as="node()*"
      select="local:resolve-data-xpath-expression($auto-sections-context-expression, $data-contexts)"/>
    <xsl:variable name="auto-sections-specification-context" as="element()?"
      select="local:resolve-specification-xpath-expression($auto-sections-context-expression, $specification-context)"/>

    <xsl:for-each select="$auto-sections-specification-context/concept[@type eq 'group']">
      <xsl:call-template name="do-section">
        <xsl:with-param name="section" as="element(section)">
          <section context="{@shortName}">
            <xsl:copy-of select="$auto-sections/@color"/>
            <table-view>
              <auto-items/>
            </table-view>
            <auto-sections>
              <xsl:copy-of select="$auto-sections/@color"/>
            </auto-sections>
          </section>
        </xsl:with-param>
        <xsl:with-param name="section-level" select="$section-level + 1"/>
        <xsl:with-param name="data-contexts" select="$auto-sections-data-contexts"/>
        <xsl:with-param name="specification-context" select="$auto-sections-specification-context"/>
      </xsl:call-template>

    </xsl:for-each>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- ITEM HANDLING: -->

  <xsl:function name="local:effective-item-list" as="element(item)*">
    <!-- Turns an item list inside an element, which can contain also constructs like <auto-items>, into a list with only <item> elements -->
    <xsl:param name="parent-elm" as="element()"/>
    <xsl:param name="parent-elm-specification-context" as="element()?" required="yes"/>

    <xsl:for-each select="$parent-elm/*">
      <xsl:choose>
        <xsl:when test="self::item">
          <xsl:sequence select="."/>
        </xsl:when>
        <xsl:when test="self::auto-items">
          <xsl:for-each select="$parent-elm-specification-context/concept[@type ne 'group']">
            <item context="{@shortName}"/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="error((), 'Invalid element in item list: ' || local-name(.))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="get-item-prompt-contents" as="node()*">
    <!-- Processes the item/prompt element (only a single one). -->
    <xsl:param name="item" as="element(item)" required="no" select="."/>
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>

    <xsl:call-template name="get-item-sub-element-contents">
      <xsl:with-param name="item" select="$item"/>
      <xsl:with-param name="sub-element" select="$item/prompt"/>
      <xsl:with-param name="default-expression" select="'{#}'"/>
      <xsl:with-param name="data-contexts" select="$data-contexts"/>
      <xsl:with-param name="specification-context" select="$specification-context"/>
    </xsl:call-template>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="get-item-value-contents" as="node()*">
    <!-- Processes the item/value elements (multiple are allowed!) -->
    <xsl:param name="item" as="element(item)" required="no" select="."/>
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>

    <xsl:for-each select="$item/value">
      <xsl:variable name="separator-attribute-value" as="xs:string?" select="@separator"/>
      <xsl:variable name="value-separator" as="node()*">
        <xsl:choose>
          <xsl:when test="empty($separator-attribute-value)">
            <xsl:sequence select="$default-value-separator"/>
          </xsl:when>
          <xsl:when test="$separator-attribute-value eq '#br'">
            <br/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$separator-attribute-value"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:call-template name="get-item-sub-element-contents">
        <xsl:with-param name="item" select="$item"/>
        <xsl:with-param name="sub-element" select="."/>
        <xsl:with-param name="default-expression" select="'{.}'"/>
        <xsl:with-param name="data-contexts" select="$data-contexts"/>
        <xsl:with-param name="specification-context" select="$specification-context"/>
        <xsl:with-param name="value-separator" as="node()*" select="$value-separator" tunnel="true"/>
      </xsl:call-template>
      <xsl:if test="position() ne last()">
        <br/>
      </xsl:if>
    </xsl:for-each>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="get-item-sub-element-contents">
    <xsl:param name="item" as="element(item)" required="true"/>
    <xsl:param name="sub-element" as="element()?" required="true"/>
    <xsl:param name="default-expression" as="xs:string" required="true"/>
    <xsl:param name="data-contexts" as="node()*" required="true"/>
    <xsl:param name="specification-context" as="element()?" required="true"/>

    <xsl:variable name="item-context-expression" as="xs:string?" select="$item/@context"/>
    <xsl:variable name="item-data-contexts" as="node()*" select="local:resolve-data-xpath-expression($item-context-expression, $data-contexts)"/>
    <xsl:variable name="item-specification-context" as="element()?"
      select="local:resolve-specification-xpath-expression($item-context-expression, $specification-context)"/>

    <xsl:choose>
      <xsl:when test="exists($sub-element)">
        <xsl:call-template name="do-mixed-contents">
          <xsl:with-param name="parent-elm" select="$sub-element"/>
          <xsl:with-param name="data-contexts" select="$item-data-contexts"/>
          <xsl:with-param name="specification-context" select="$item-specification-context"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="do-mixed-contents">
          <xsl:with-param name="parent-elm" as="element()">
            <null>{ $default-expression }</null>
          </xsl:with-param>
          <xsl:with-param name="data-contexts" select="$item-data-contexts"/>
          <xsl:with-param name="specification-context" select="$item-specification-context"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- PROCESSING OF POSSIBLY MIXED CONTENTS -->

  <xsl:template name="do-mixed-contents" as="node()*">
    <!-- Processes mixed content inside $parent-elm, resolving curly-braced expressions. Returns the resulting node-set. -->
    <xsl:param name="parent-elm" as="element()" required="yes"/>
    <xsl:param name="data-contexts" as="node()*" required="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes"/>

    <xsl:variable name="context-expression" as="xs:string?" select="$parent-elm/@context"/>
    <xsl:variable name="contents-data-contexts" as="node()*" select="local:resolve-data-xpath-expression($context-expression, $data-contexts)"/>
    <xsl:variable name="contents-specification-context" as="element()?"
      select="local:resolve-specification-xpath-expression($context-expression, $specification-context)"/>

    <xsl:apply-templates select="$parent-elm/node()" mode="mode-do-mixed-contents">
      <xsl:with-param name="data-contexts" as="node()*" select="$contents-data-contexts" tunnel="yes"/>
      <xsl:with-param name="specification-context" as="element()?" select="$contents-specification-context" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="text()" mode="mode-do-mixed-contents">
    <xsl:param name="data-contexts" as="node()*" required="yes" tunnel="yes"/>
    <xsl:param name="specification-context" as="element()?" required="yes" tunnel="yes"/>
    <xsl:param name="value-separator" as="node()*" required="no" tunnel="yes" select="$default-value-separator"/>

    <xsl:copy-of select="local:parse-string-for-viewer-xpath-expressions(string(.), $data-contexts, $specification-context, $value-separator)"/>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- VIEWER XPATH EXPRESSION PARSING: -->

  <xsl:function name="local:parse-string-for-viewer-xpath-expressions" as="node()*">
    <!-- Parses a string and tries to resolve optional curly-braced viewer XPath expressions in it.  -->
    <xsl:param name="in" as="xs:string"/>
    <xsl:param name="data-contexts" as="node()*"/>
    <xsl:param name="specification-context" as="element()?"/>
    <xsl:param name="value-separator" as="node()*"/>

    <xsl:analyze-string select="$in" regex="\{{(.*?)\}}">

      <!-- Curly-braced expression found: -->
      <xsl:matching-substring>
        <xsl:choose>
          <!-- If the expression starts with a {{ ignore it: -->
          <xsl:when test="starts-with(., '{{')">
            <xsl:value-of select="."/>
          </xsl:when>
          <!-- Process the expression: -->
          <xsl:otherwise>
            <xsl:copy-of select="local:resolve-viewer-xpath-expression(regex-group(1), $data-contexts, $specification-context, $value-separator)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:matching-substring>

      <!-- Anything else pass through: -->
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>

    </xsl:analyze-string>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:resolve-viewer-xpath-expression" as="node()*">
    <!-- Resolves a viewer XPath expression into its value -->
    <xsl:param name="expression" as="xs:string?"/>
    <xsl:param name="data-contexts" as="node()*"/>
    <xsl:param name="definition-context" as="element()?"/>
    <xsl:param name="value-separator" as="node()*"/>

    <!-- Separate the expression into the expression itself and an optional specifier (after a % sign): -->
    <xsl:variable name="expression-normalized-raw" as="xs:string" select="normalize-space($expression)"/>
    <xsl:variable name="expression-contains-specifier" as="xs:boolean" select="contains($expression-normalized-raw, '%')"/>
    <xsl:variable name="expression-specifier" as="xs:string?"
      select="if ($expression-contains-specifier) then substring-after($expression-normalized-raw, '%') else ()"/>
    <xsl:variable name="expression-normalized-raw-no-specifier" as="xs:string"
      select="if ($expression-contains-specifier) then substring-before($expression-normalized-raw, '%') else $expression-normalized-raw"/>
    <xsl:variable name="expression-normalized" as="xs:string"
      select="if ($expression-normalized-raw-no-specifier eq '.') then '' else $expression-normalized-raw-no-specifier"/>

    <xsl:choose>

      <!-- An expression that starts with a # reaches into the definition: -->
      <xsl:when test="starts-with($expression-normalized, '#')">
        <xsl:if test="exists($expression-specifier)">
          <xsl:sequence select="error((), 'Specifier &quot;'|| $expression-specifier || '&quot; not allowed/recognized here')"/>
        </xsl:if>
        <xsl:variable name="definition-element" as="element()?"
          select="local:resolve-specification-xpath-expression(substring($expression-normalized, 2), $definition-context)"/>
        <xsl:variable name="value" as="xs:string" select="if (empty($definition-element)) then '?' else string($definition-element/name[1])"/>
        <xsl:value-of select="local:apply-expression-specifier($value, $expression-specifier, true())"/>
      </xsl:when>

      <!-- Anything else reaches into the data: -->
      <xsl:otherwise>
        <xsl:for-each select="local:resolve-data-xpath-expression($expression-normalized, $data-contexts)">
          <xsl:variable name="value-raw" as="xs:string" select="string((@displayName, @value, '&#160;')[1])"/>
          <xsl:variable name="value" as="xs:string"
            select="
                if ($expression-contains-specifier) then 
                  local:apply-expression-specifier($value-raw, $expression-specifier, false()) 
                else 
                  local:massage-value($value-raw)"/>
          <xsl:value-of select="concat($value, if (not($expression-contains-specifier)) then @unit else ())"/>
          <xsl:if test="position() ne last()">
            <xsl:sequence select="$value-separator"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>

    </xsl:choose>

  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:apply-expression-specifier" as="xs:string">
    <xsl:param name="value" as="xs:string?"/>
    <xsl:param name="expression-specifier" as="xs:string?"/>
    <xsl:param name="in-prompt" as="xs:boolean"/>

    <xsl:choose>
      <xsl:when test="normalize-space($expression-specifier) eq ''">
        <xsl:sequence select="$value"/>
      </xsl:when>
      <xsl:when test="not($in-prompt) and exists($value) and ($value castable as xs:integer) and ($expression-specifier eq 'wd')">
        <!-- Convert a number of days into weeks+days notation -->
        <xsl:variable name="total-days" as="xs:integer" select="xs:integer($value)"/>
        <xsl:variable name="weeks" as="xs:integer" select="xs:integer(floor($total-days div 7))"/>
        <xsl:variable name="days" as="xs:integer" select="$total-days - ($weeks * 7)"/>
        <xsl:sequence select="$weeks || 'w' || (if ($days ne 0) then $days || 'd' else ())"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="error((), 'Specifier &quot;'|| $expression-specifier || '&quot; not allowed/recognized here')"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:massage-value" as="xs:string">
    <!-- Checks if a value from a data file is anything special (date, boolean, etc.) and massages it into what must be shown. -->
    <xsl:param name="value" as="xs:string"/>

    <xsl:variable name="date-format" as="xs:string" select="'[D]-[M]-[Y]'"/>
    <xsl:choose>
      <xsl:when test="normalize-space($value) eq ''">
        <xsl:sequence select="'&#160;'"/>
      </xsl:when>
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

  <!-- ================================================================== -->
  <!-- DATA XPATH EXPRESSION PARSING: -->

  <xsl:function name="local:resolve-data-xpath-expression" as="node()*">
    <!-- Tries to resolve the data XPath expression in $expression. Returns the elements found. -->
    <xsl:param name="expression" as="xs:string?"/>
    <xsl:param name="data-contexts" as="node()*"/>

    <xsl:variable name="expression-parts" as="xs:string*" select="tokenize($expression, '/')[normalize-space(.) ne '']"/>
    <xsl:variable name="start-contexts" as="node()*" select="if (starts-with($expression, '/')) then $full-data-document else $data-contexts"/>
    <xsl:sequence select="local:resolve-data-xpath-expression-by-parts($expression-parts, $start-contexts)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:resolve-data-xpath-expression-by-parts" as="node()*">
    <!-- Resolves a tokenized XPath expression in $expression-parts. Returns the elements found. -->
    <xsl:param name="expression-parts" as="xs:string*"/>
    <xsl:param name="data-contexts" as="node()*"/>

    <xsl:for-each select="$data-contexts">
      <xsl:variable name="data-context" as="node()" select="."/>
      <xsl:choose>

        <!-- No expression parts: -->
        <xsl:when test="empty($expression-parts)">
          <xsl:sequence select="$data-context"/>
        </xsl:when>

        <!-- Parse the first of the expression parts and then the rest recursively: -->
        <xsl:otherwise>
          <xsl:variable name="first-expression-part" as="xs:string" select="normalize-space($expression-parts[1])"/>
          <!-- Find out if it has an index (an [n] part) suffix: -->
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
          <!-- Get the element name to match: -->
          <xsl:variable name="element-name" as="xs:string"
            select="if (contains($first-expression-part, '[')) then substring-before($first-expression-part, '[') else $first-expression-part "/>
          <!-- Get all the elements that match (and handle * as a special name): -->
          <xsl:variable name="new-context-all" as="element()*">
            <xsl:choose>
              <xsl:when test="$element-name eq '*'">
                <xsl:sequence select="$data-context/*"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$data-context/*[local-name(.) eq $element-name]"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <!-- Create the final context by processing the optional index: -->
          <xsl:variable name="new-context" as="element()*" select="if (exists($index)) then $new-context-all[$index] else $new-context-all"/>
          <!-- Handle the result and go deeper recursively if necessary: -->
          <xsl:choose>
            <xsl:when test="empty($new-context)">
              <xsl:sequence select="()"/>
            </xsl:when>
            <xsl:when test="count($expression-parts) eq 1">
              <xsl:sequence select="$new-context"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="local:resolve-data-xpath-expression-by-parts(subsequence($expression-parts, 2), $new-context)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>

      </xsl:choose>
    </xsl:for-each>

  </xsl:function>

  <!-- ================================================================== -->
  <!-- SPECIFICATION XPATH EXPRESSION HANDLING: -->

  <xsl:function name="local:resolve-specification-xpath-expression" as="element()?">
    <!-- Tries to resolve the specification XPath expression in $expression. Returns the element found (this the root <dataset> or an <concept>). -->
    <xsl:param name="expression" as="xs:string?"/>
    <xsl:param name="specification-context" as="element()?"/>

    <xsl:variable name="expression-parts" as="xs:string*" select="tokenize($expression, '/')[normalize-space(.) ne '']"/>
    <xsl:variable name="start-context" as="element()?" select="if (starts-with($expression, '/')) then () else $specification-context"/>
    <xsl:sequence select="local:resolve-specification-xpath-expression-by-parts($expression-parts, $start-context)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:resolve-specification-xpath-expression-by-parts" as="element()?">
    <!-- Resolves a tokenized specification XPath expression in $expression-parts. Returns the element found. -->
    <xsl:param name="expression-parts" as="xs:string*"/>
    <xsl:param name="specification-context" as="element()?"/>

    <xsl:choose>

      <!-- No expression parts: -->
      <xsl:when test="empty($expression-parts)">
        <xsl:sequence select="$specification-context"/>
      </xsl:when>

      <!-- Parse the first of the expression parts and then the rest recursively: -->
      <xsl:otherwise>
        <xsl:variable name="first-expression-part" as="xs:string" select="normalize-space($expression-parts[1])"/>
        <!-- Get the element name to match, removing the optional index part: -->
        <xsl:variable name="element-name" as="xs:string"
          select="if (contains($first-expression-part, '[')) then substring-before($first-expression-part, '[') else $first-expression-part "/>
        <!-- Find the specification for this element: -->
        <xsl:variable name="new-context" as="element()?">
          <xsl:choose>
            <xsl:when test="empty($specification-context)">
              <xsl:sequence select="$specification-root[if ($element-name eq '*') then true() else (@shortName eq $element-name)]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$specification-context/concept[if ($element-name eq '*') then true() else (@shortName eq $element-name)][1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Handle the result and go deeper recursively if necessary: -->
        <xsl:choose>
          <xsl:when test="empty($new-context)">
            <xsl:sequence select="()"/>
          </xsl:when>
          <xsl:when test="count($expression-parts) eq 1">
            <xsl:sequence select="$new-context"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="local:resolve-specification-xpath-expression-by-parts(subsequence($expression-parts, 2), $new-context)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:function>

  <!-- ================================================================== -->
  <!-- GENERIC SUPPORT: -->

  <xsl:function name="local:q" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="concat('&quot;', $in, '&quot;')"/>
  </xsl:function>

</xsl:stylesheet>