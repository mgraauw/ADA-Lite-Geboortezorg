<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.d31_531_1hb" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       This stylesheet renders the output or compare-datasets.xsl into a more-or-less nice looking HTML page.
       The page is rather primitive. No CSS is added (yet).
  -->
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
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="html" indent="no" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="../lib/xsl-common.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="description" as="xs:string?" required="no" select="()"/>

  <!-- You can turn off the generation of a timestamp. This is useful when generating the diffs for a repo and you don't want the 
    files to change on any generator run. -->
  <xsl:param name="add-timestamp" as="xs:string" required="false" select="string(true())"/>
  <xsl:variable name="do-add-timestamp" as="xs:boolean" select="xs:boolean($add-timestamp)"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="from-to" as="xs:string" select="' → '"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <xsl:variable name="page-title" as="xs:string"
      select="'Datasets vergelijking' || (if (fn:normalize-space($description) ne '') then ': ' || $description else ())"/>

    <html>
      <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>
          <xsl:value-of select="$page-title"/>
        </title>
      </head>
      <body>
        <h1>{ $page-title }</h1>
        <p>Oude dataset: <code>{ bc-alg:dref-alg-path(/*/@dref-older) }</code></p>
        <p>Nieuwe dataset: <code>{ bc-alg:dref-alg-path(/*/@dref-newer) }</code></p>
        <xsl:if test="$do-add-timestamp and (exists(/*/@timestamp))">
          <p>Tijdstip vergelijking: { replace(substring(/*/@timestamp, 1, 19), 'T', ' ') }</p>
        </xsl:if>
        <hr/>
        <xsl:apply-templates select="/*/child-concepts"/>
      </body>
    </html>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="child-concepts">
    <div>
      <h2>
        <a name="{ @doc-xpath }"/>
        <code>
          <xsl:sequence select="local:create-header(@doc-xpath)"/>
        </code>
      </h2>

      <!-- Handle no shortname situations: -->
      <xsl:variable name="older-concepts-no-shortname-count" as="xs:integer" select="count(concepts-no-shortname[@source eq 'older']/concept)"/>
      <xsl:if test="$older-concepts-no-shortname-count gt 0">
        <p>
          <b>Oude dataset: { $older-concepts-no-shortname-count } onderliggende concepten zonder naam!</b>
        </p>
      </xsl:if>
      <xsl:variable name="newer-concepts-no-shortname-count" as="xs:integer" select="count(concepts-no-shortname[@source eq 'newer']/concept)"/>
      <xsl:if test="$newer-concepts-no-shortname-count gt 0">
        <p>
          <b>Nieuwe dataset: { $newer-concepts-no-shortname-count } onderliggende concepten zonder naam!</b>
        </p>
      </xsl:if>

      <!-- Handle all the concept comparisons: -->
      <xsl:if test="exists(concept-compare)">
        <table border="1" cellspacing="0" cellpadding="0">
          <tr>
            <th>Naam</th>
            <th>#oud</th>
            <th>#nw</th>
            <th>Value type</th>
            <th>Wijzigingen</th>
          </tr>
          <xsl:for-each select="concept-compare">
            <xsl:sort select="if (empty(@index-older)) then 100000 else xs:integer(@index-older)"/>
            <xsl:sort select="xs:integer(@index-newer)"/>
            <tr valign="top">
              <!-- Name/xpath -->
              <td>
                <xsl:choose>
                  <xsl:when test="exists(child-concepts)">
                    <a href="#{ child-concepts/@doc-xpath }">
                      <code>{ @shortname }</code>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>
                    <code>{ @shortname }</code>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <!-- Indexes: -->
              <td>{ local:c(@index-older) }</td>
              <td>{ local:c(@index-newer) }</td>
              <!-- Value type: -->
              <xsl:variable name="value-type" as="xs:string?">
                <xsl:choose>
                  <xsl:when test="empty(@value-type) or (string(@value-type) eq '') or exists(diff[@type eq 'value-type'])">
                    <xsl:sequence select="()"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:sequence select="string(@value-type)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <td>
                <xsl:sequence select="local:c($value-type)"/>
              </td>
              <!-- Changes: -->
              <td>
                <xsl:sequence select="local:c(local:create-diff-list(.))"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </xsl:if>

    </div>

    <xsl:apply-templates select="concept-compare/child-concepts"/>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:create-diff-list" as="item()*">
    <xsl:param name="root" as="element(concept-compare)"/>


    <xsl:for-each select="$root/diff">
      <xsl:choose>
        <xsl:when test="exists(@value-older) and exists(@value-newer)">
          <xsl:sequence select="@type || ': ' || @value-older || $from-to || @value-newer"/>
        </xsl:when>
        <xsl:when test="@type eq 'concept-deleted'">
          <xsl:sequence select="'Verwijderd'"/>
        </xsl:when>
        <xsl:when test="@type eq 'concept-moved'">
          <xsl:sequence select="'Verplaatst: positie ' || @index-older || $from-to || @index-newer"/>
        </xsl:when>
        <xsl:when test="@type eq 'concept-new'">
          <xsl:sequence select="'Nieuw'"/>
        </xsl:when>
        <xsl:when test="@type eq 'conceptlist'">
          <xsl:text>Code aanpassingen:</xsl:text>
          <br/>
          <xsl:for-each select="diff">
            <xsl:text>-&#160;</xsl:text>
            <xsl:choose>
              <xsl:when test="@type eq 'code-deleted'">
                <xsl:text>Verwijderd: </xsl:text>
                <xsl:sequence select="local:render-code(@code-older, @code-type-older, @displayname-older)"/>
              </xsl:when>
              <xsl:when test="@type eq 'code-new'">
                <xsl:text>Nieuw: </xsl:text>
                <xsl:sequence select="local:render-code(@code-newer, @code-type-newer, @displayname-newer)"/>
              </xsl:when>
              <xsl:when test="@type eq 'code-type'">
                <xsl:text>Type: </xsl:text>
                <xsl:sequence select="local:render-code(@code-older, @code-type-older, @displayname-older)"/>
                <xsl:value-of select="$from-to"/>
                <xsl:sequence select="local:render-code(@code-newer, @code-type-newer, @displayname-newer)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="'?' || @type || '?'"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
              <br/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="'?' || @type || '?'"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="position() ne last()">
        <br/>
      </xsl:if>
    </xsl:for-each>
  </xsl:function>


  <!-- ================================================================== -->
  <!-- SUPPORT: -->

  <xsl:function name="local:c" as="item()*">
    <xsl:param name="items" as="item()*"/>
    <xsl:sequence select="if (empty($items)) then '&#160;' else $items"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:render-code" as="item()*">
    <xsl:param name="code" as="xs:string"/>
    <xsl:param name="type" as="xs:string"/>
    <xsl:param name="displayname" as="xs:string?"/>


    <xsl:if test="$type ne 'concept'">
      <xsl:sequence select="$type || ':'"/>
    </xsl:if>
    <code>
      <xsl:sequence select="$code"/>
    </code>
    <xsl:if test="string($displayname) ne ''">
      <xsl:sequence select="' ('|| $displayname || ')'"/>
    </xsl:if>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:create-header" as="item()*">
    <xsl:param name="xpath" as="xs:string"/>

    <xsl:variable name="path-components" as="xs:string+" select="tokenize($xpath, '/')[normalize-space(.) ne '']"/>
    <xsl:value-of select="'/'"/>
    <xsl:for-each select="$path-components">
      <xsl:variable name="index" as="xs:integer" select="position()"/>
      <xsl:choose>
        <xsl:when test="$index eq last()">
          <xsl:sequence select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="path-to" as="xs:string" select="'/' || string-join($path-components[position() le $index], '/')"/>
          <a href="#{$path-to}">{.}</a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$index ne last()">
        <xsl:value-of select="'/'"/>
      </xsl:if>
    </xsl:for-each>


  </xsl:function>

</xsl:stylesheet>
