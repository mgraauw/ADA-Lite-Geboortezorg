<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.d31_531_1hb" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       This stylesheet renders the output or compare-datasets.xsl into a more-or-less nice looking HTML page.
       The page layout is rather primitive. No CSS is added (yet).
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

  <xsl:param name="limited-view" as="xs:string" required="no" select="'false'"/>
  <xsl:variable name="full-view" as="xs:boolean" select="not(xs:boolean($limited-view))"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="from-to" as="xs:string" select="' → '"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <xsl:variable name="page-title" as="xs:string"
      select="'Datasets vergelijking' || (if (fn:normalize-space($description) ne '') then ': ' || $description else ()) ||
        (if ($full-view) then () else ' (vereenvoudigd)')"/>

    <html>
      <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>
          <xsl:value-of select="$page-title"/>
        </title>
      </head>
      <body>
        <h1>{ $page-title }</h1>
        <p>Oude dataset: <a href="{ bc-alg:dref-alg-path(/*/@dref-older) }">{/*/meta/older/@shortName/string()}</a></p>
        <p>Nieuwe dataset: <a href="{ bc-alg:dref-alg-path(/*/@dref-newer) }">{/*/meta/newer/@shortName/string()}</a></p>
        <xsl:if test="$do-add-timestamp and (exists(/*/@timestamp))">
          <p>Tijdstip vergelijking: { replace(substring(/*/@timestamp, 1, 19), 'T', ' ') }</p>
        </xsl:if>
        <xsl:if test="$full-view">
          <xsl:call-template name="add-statistics"/>
        </xsl:if>
        <hr/>
        <xsl:apply-templates select="/*/child-concepts"/>
      </body>
    </html>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="add-statistics">

    <xsl:variable name="concepts-older" as="element(child-concepts)*" select="//child-concepts[exists(concept-compare/@index-older)]"/>
    <xsl:variable name="concepts-newer" as="element(child-concepts)*" select="//child-concepts[exists(concept-compare/@index-newer)]"/>
    <xsl:variable name="concepts-deleted" as="element(child-concepts)*" select="//child-concepts[string(@reason) eq 'deleted']"/>
    <xsl:variable name="concepts-new" as="element(child-concepts)*" select="//child-concepts[string(@reason) eq 'new']"/>

    <table border="1" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <th>&#160;</th>
        <th>Oud</th>
        <th>Nieuw</th>
      </tr>
      <tr valign="top">
        <td>Totaal aantal concepten:&#160;</td>
        <td align="right">{count($concepts-older/concept-compare) + count($concepts-deleted/concept-compare)}</td>
        <td align="right">{count($concepts-newer/concept-compare) + count($concepts-new/concept-compare)}</td>
      </tr>
      <tr valign="top">
        <td>Waarvan groepen:&#160;</td>
        <td align="right">{count($concepts-older) + count($concepts-deleted)}</td>
        <td align="right">{count($concepts-newer) + count($concepts-new)}</td>
      </tr>
      <tr>
        <td>Codelijsten:&#160;</td>
        <td align="right">{count($concepts-older/concept-compare/conceptcodelist-old) + count($concepts-deleted/concept-compare/conceptcodelist)}</td>
        <td align="right">{count($concepts-newer/concept-compare/conceptcodelist-old) + count($concepts-new/concept-compare/conceptcodelist)}</td>
      </tr>
    </table>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="child-concepts">

    <xsl:variable name="is-new" as="xs:boolean" select="string(@reason) eq 'new'"/>
    <xsl:variable name="is-deleted" as="xs:boolean" select="string(@reason) eq 'deleted'"/>
    <xsl:variable name="is-new-or-deleted" as="xs:boolean" select="$is-new or $is-deleted"/>

    <xsl:if test="$full-view or not($is-new-or-deleted)">
      <div>
        <h2>
          <a name="{ local:create-anchor-name(@doc-xpath) }"/>
          <code>
            <xsl:sequence select="local:create-header(@doc-xpath)"/>
          </code>
          <xsl:text>&#160;</xsl:text>
          <xsl:where-populated>
            <span style="color:red; font-weight: bold;">
              <xsl:choose>
                <xsl:when test="$is-new">
                  <xsl:text>(nieuw)</xsl:text>
                </xsl:when>
                <xsl:when test="$is-deleted">
                  <xsl:text>(verwijderd)</xsl:text>
                </xsl:when>
                <xsl:otherwise/>
              </xsl:choose>
            </span>
          </xsl:where-populated>
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
            <tr valign="top">
              <th>Naam</th>
              <xsl:choose>
                <xsl:when test="$full-view and $is-new-or-deleted">
                  <th>Type</th>
                </xsl:when>
                <xsl:when test="not($full-view) and $is-new-or-deleted"/>
                <xsl:otherwise>
                  <th>Type oud</th>
                  <th>#oud</th>
                  <th>Type nw</th>
                  <th>#nw</th>
                  <th>Wijzigingen</th>
                </xsl:otherwise>
              </xsl:choose>
            </tr>
            <xsl:for-each select="concept-compare">
              <xsl:sort select="if (empty(@index-older)) then 100000 else xs:integer(@index-older)"/>
              <xsl:sort select="xs:integer(@index-newer)"/>
              <tr valign="top">
                <td>
                  <xsl:variable name="new-or-deleted" as="xs:boolean" select="exists(diff[@type = ('concept-deleted', 'concept-new')])"/>
                  <xsl:choose>
                    <xsl:when test="exists(child-concepts) and ($full-view or not($new-or-deleted))">
                      <a href="#{ local:create-anchor-name(child-concepts/@doc-xpath) }">
                        <code>{ @shortname }</code>
                      </a>
                    </xsl:when>
                    <xsl:otherwise>
                      <code>{ @shortname }</code>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
                <xsl:choose>
                  <xsl:when test="$full-view and $is-new-or-deleted">
                    <td>
                      <xsl:sequence select="local:c(data(@type))"/>
                      <xsl:call-template name="output-conceptcodelist">
                        <xsl:with-param name="conceptcodelist" select="conceptcodelist"/>
                      </xsl:call-template>
                    </td>
                  </xsl:when>
                  <xsl:when test="not($full-view) and $is-new-or-deleted"/>
                  <xsl:otherwise>
                    <td>
                      <xsl:sequence select="local:c(data(@type-old))"/>
                      <xsl:call-template name="output-conceptcodelist">
                        <xsl:with-param name="conceptcodelist" select="conceptcodelist-old"/>
                      </xsl:call-template>
                    </td>
                    <td>{ local:c(@index-older) }</td>
                    <td>
                      <xsl:sequence select="local:c(data(@type-new))"/>
                      <xsl:call-template name="output-conceptcodelist">
                        <xsl:with-param name="conceptcodelist" select="conceptcodelist-new"/>
                      </xsl:call-template>
                    </td>
                    <td>{ local:c(@index-newer) }</td>
                    <!-- Changes: -->
                    <td>
                      <xsl:sequence select="local:c(local:create-diff-list(.))"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
            </xsl:for-each>
          </table>
        </xsl:if>

      </div>
    </xsl:if>

    <xsl:apply-templates select="concept-compare/child-concepts"/>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="output-conceptcodelist">
    <xsl:param name="conceptcodelist" as="element()?" required="yes"/>

    <xsl:if test="$full-view">
      <xsl:for-each select="$conceptcodelist/code">
        <br/>
        <xsl:text>-&#160;</xsl:text>
        <xsl:sequence select="local:render-code(@code, @type, @displayname)"/>
      </xsl:for-each>
    </xsl:if>
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
        <xsl:when test="$full-view and (@type eq 'concept-moved')">
          <xsl:sequence select="'Verplaatst: positie ' || @index-older || $from-to || @index-newer"/>
        </xsl:when>
        <xsl:when test="not($full-view) and (@type eq 'concept-moved')">
          <xsl:text>Verplaatst</xsl:text>
        </xsl:when>
        <xsl:when test="@type eq 'concept-new'">
          <xsl:sequence select="'Nieuw'"/>
        </xsl:when>
        <xsl:when test="$full-view and (@type eq 'conceptlist')">
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
        <xsl:when test="not($full-view) and (@type eq 'conceptlist')">
          <xsl:text>Code aanpassingen</xsl:text>
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
          <xsl:variable name="path-to" as="xs:string" select="local:create-anchor-name(string-join($path-components[position() le $index], '/'))"/>
          <a href="#{$path-to}">{.}</a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$index ne last()">
        <xsl:value-of select="'/'"/>
      </xsl:if>
    </xsl:for-each>

  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:create-anchor-name" as="xs:string">
    <xsl:param name="doc-xpath" as="xs:string"/>

    <xsl:variable name="components" as="xs:string*" select="tokenize($doc-xpath, '/')[normalize-space(.) ne '']"/>
    <xsl:sequence select="fn:string-join($components, '_')"/>
  </xsl:function>

</xsl:stylesheet>
