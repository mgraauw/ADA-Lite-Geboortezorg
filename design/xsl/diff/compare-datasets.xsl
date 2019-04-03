<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:saxon="http://saxon.sf.net/"
  xmlns:local="#local.mdp_npt_zgb" exclude-result-prefixes="#all" xmlns:bc-alg="https://babyconnect.org/ns/ada-lite-geboortezorg" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Compares two versions of a Receive Transaction Dataset (in short: rtd) with each other. 
       
       The code assumes no namespaces are used.
       
       Input is ignored. Provide the files to compare through the parameters.
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

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>
  
  <xsl:include href="../lib/xsl-common.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="dref-rtd-older-version" as="xs:string" required="yes"/>
  <xsl:param name="dref-rtd-newer-version" as="xs:string" required="yes"/>

  <!-- You can turn off the generation of a timestamp. This is useful when generating the diffs for a repo and you don't want the 
    files to change on any generator run. -->
  <xsl:param name="add-timestamp" as="xs:string" required="false" select="string(true())"/>
  <xsl:variable name="do-add-timestamp" as="xs:boolean" select="xs:boolean($add-timestamp)"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <xsl:variable name="root-older-version" as="element(dataset)" select="doc($dref-rtd-older-version)/*"/>
    <xsl:variable name="root-newer-version" as="element(dataset)" select="doc($dref-rtd-newer-version)/*"/>

    <compare-datasets dref-older="{bc-alg:dref-alg-path($dref-rtd-older-version)}" dref-newer="{bc-alg:dref-alg-path($dref-rtd-newer-version)}">
      <xsl:if test="$do-add-timestamp">
        <xsl:attribute name="timestamp" select="current-dateTime()"/>
      </xsl:if>
      <xsl:call-template name="compare-child-concepts">
        <xsl:with-param name="parent-elm-older" select="$root-older-version"/>
        <xsl:with-param name="parent-elm-newer" select="$root-newer-version"/>
      </xsl:call-template>
    </compare-datasets>

  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="compare-child-concepts">
    <xsl:param name="parent-elm-older" as="element()" required="yes"/>
    <xsl:param name="parent-elm-newer" as="element()" required="yes"/>

    <xsl:where-populated>
      <child-concepts doc-xpath="{local:get-doc-xpath($parent-elm-older)}">

        <!-- First check and report on any child objects without a shortname: -->
        <xsl:call-template name="report-child-concepts-without-shortname">
          <xsl:with-param name="parent" select="$parent-elm-older"/>
          <xsl:with-param name="source-older" select="true()"/>
        </xsl:call-template>
        <xsl:call-template name="report-child-concepts-without-shortname">
          <xsl:with-param name="parent" select="$parent-elm-newer"/>
          <xsl:with-param name="source-older" select="false()"/>
        </xsl:call-template>

        <!-- Compare the concepts in the older list with the ones in the newer list. Also check whether they are (re)moved: -->
        <xsl:for-each select="$parent-elm-older/concept[local:concept-has-shortname(.)]">
          <xsl:variable name="index-older" as="xs:integer" select="position()"/>
          <xsl:variable name="signature-older" as="xs:string" select="local:concept-signature(.)"/>
          <concept-compare signature="{$signature-older}" shortname="{@shortName}" doc-xpath="{local:get-doc-xpath(.)}"
            rtd-xpath-older="{local:get-rtd-xpath(.)}" id-older="{@id}" index-older="{$index-older}" value-type="{valueDomain/@type}">
            <xsl:variable name="corresponding-concept-newer" as="element(concept)*"
              select="$parent-elm-newer/concept[local:concept-has-shortname(.)][local:concept-signature(.) eq $signature-older]"/>
            <xsl:choose>

              <!-- We find multiple newer concepts with this signature: -->
              <xsl:when test="count($corresponding-concept-newer) gt 1">
                <!-- Don't know whether this will happen anyway. Enhance message if necessary. -->
                <xsl:sequence select="error((), 'Cannot handle multiple corresponding newer concepts')"/>
              </xsl:when>

              <!-- We only find one newer concept with this signature: -->
              <xsl:when test="count($corresponding-concept-newer) eq 1">
                <xsl:variable name="index-newer" as="xs:integer" select="count($corresponding-concept-newer/preceding-sibling::concept) + 1"/>
                <xsl:attribute name="index-newer" select="$index-newer"/>
                <xsl:attribute name="rtd-xpath-newer" select="local:get-rtd-xpath($corresponding-concept-newer)"/>
                <xsl:attribute name="id-newer" select="$corresponding-concept-newer/@id"/>
                <xsl:attribute name="value-type" select="(valueDomain/@type, $corresponding-concept-newer/valueDomain/@type)[1]"/>
                <xsl:if test="$index-older ne $index-newer">
                  <diff type="concept-moved" index-older="{$index-older}" index-newer="{$index-newer}"/>
                </xsl:if>
                <xsl:call-template name="compare-concepts">
                  <xsl:with-param name="concept-older" select="."/>
                  <xsl:with-param name="concept-newer" select="$corresponding-concept-newer"/>
                </xsl:call-template>
              </xsl:when>

              <!-- No newer concept for this signature: -->
              <xsl:otherwise>
                <diff type="concept-deleted"/>
              </xsl:otherwise>

            </xsl:choose>
          </concept-compare>
        </xsl:for-each>

        <!-- Now search for concepts in the newer list that are not in the older (aka new concepts): -->
        <xsl:for-each select="$parent-elm-newer/concept[local:concept-has-shortname(.)]">
          <xsl:variable name="index-newer" as="xs:integer" select="position()"/>
          <xsl:variable name="signature-newer" as="xs:string" select="local:concept-signature(.)"/>
          <xsl:variable name="corresponding-concepts-older" as="element(concept)*"
            select="$parent-elm-older/concept[local:concept-has-shortname(.)][local:concept-signature(.) eq $signature-newer]"/>
          <xsl:choose>
            <!-- We find multiple older concepts with this signature: -->
            <xsl:when test="count($corresponding-concepts-older) gt 1">
              <!-- Don't know whether this will happen anyway. Enhance message if necessary. -->
              <xsl:sequence select="error((), 'Cannot handle multiple corresponding older concepts')"/>
            </xsl:when>
            <!-- We only find one older concept with this signature. This situation should have been already handled above: -->
            <xsl:when test="count($corresponding-concepts-older) eq 1"/>
            <!-- No older concept for this signature, this is a new concept. Nothing to compare it against, so just mention it: -->
            <xsl:otherwise>
              <concept-compare signature="{$signature-newer}" shortname="{@shortName}" doc-xpath="{local:get-doc-xpath(.)}"
                rtd-xpath-newer="{local:get-rtd-xpath(.)}" index-newer="{$index-newer}" id-newer="{@id}" value-type="{valueDomain/@type}">
                <diff type="concept-new"/>
              </concept-compare>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:for-each>

      </child-concepts>
    </xsl:where-populated>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="compare-concepts">
    <xsl:param name="concept-older" as="element(concept)" required="yes"/>
    <xsl:param name="concept-newer" as="element(concept)" required="yes"/>

    <!-- Check several attributes: -->
    <xsl:call-template name="check-concept-attribute">
      <xsl:with-param name="concept-older" select="$concept-older"/>
      <xsl:with-param name="concept-newer" select="$concept-newer"/>
      <xsl:with-param name="attribute-name" select="'shortName'"/>
    </xsl:call-template>
    <xsl:call-template name="check-concept-attribute">
      <xsl:with-param name="concept-older" select="$concept-older"/>
      <xsl:with-param name="concept-newer" select="$concept-newer"/>
      <xsl:with-param name="attribute-name" select="'minimumMultiplicity'"/>
    </xsl:call-template>
    <xsl:call-template name="check-concept-attribute">
      <xsl:with-param name="concept-older" select="$concept-older"/>
      <xsl:with-param name="concept-newer" select="$concept-newer"/>
      <xsl:with-param name="attribute-name" select="'maximumMultiplicity'"/>
    </xsl:call-template>
    <xsl:call-template name="check-concept-attribute">
      <xsl:with-param name="concept-older" select="$concept-older"/>
      <xsl:with-param name="concept-newer" select="$concept-newer"/>
      <xsl:with-param name="attribute-name" select="'isMandatory'"/>
    </xsl:call-template>
    <xsl:call-template name="check-concept-attribute">
      <xsl:with-param name="concept-older" select="$concept-older"/>
      <xsl:with-param name="concept-newer" select="$concept-newer"/>
      <xsl:with-param name="attribute-name" select="'type'"/>
    </xsl:call-template>

    <!-- Check the definitions: -->
    <xsl:variable name="inherit-ref-older" as="xs:string?" select="$concept-older/inherit/@ref"/>
    <xsl:variable name="inherit-ref-newer" as="xs:string?" select="$concept-newer/inherit/@ref"/>
    <xsl:choose>
      <xsl:when test="exists($inherit-ref-older) and exists($inherit-ref-newer) and ($inherit-ref-older eq $inherit-ref-newer)">
        <!-- Both definitions have the same inherit reference, so these are the same, by definition.  -->
        <inherit-equals/>
      </xsl:when>
      <xsl:otherwise>
        <!-- The definition was not inherited, so we have to check more: -->
        <xsl:call-template name="check-value">
          <xsl:with-param name="value-older" select="$concept-older/name"/>
          <xsl:with-param name="value-newer" select="$concept-newer/name"/>
          <xsl:with-param name="reporting-name" select="'name'"/>
        </xsl:call-template>
        <!-- For non groups, we also have to check the value related things: -->
        <xsl:if test="($concept-older/@type ne 'group') and ($concept-newer/@type ne 'group')">
          <xsl:call-template name="check-value">
            <xsl:with-param name="value-older" select="$concept-older/valueDomain/@type"/>
            <xsl:with-param name="value-newer" select="$concept-newer/valueDomain/@type"/>
            <xsl:with-param name="reporting-name" select="'value-type'"/>
          </xsl:call-template>
          <xsl:call-template name="compare-conceptlists">
            <xsl:with-param name="conceptlist-older" select="$concept-older/valueSet/conceptList"/>
            <xsl:with-param name="conceptlist-newer" select="$concept-newer/valueSet/conceptList"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <!-- Go deeper: -->
    <xsl:call-template name="compare-child-concepts">
      <xsl:with-param name="parent-elm-older" select="$concept-older"/>
      <xsl:with-param name="parent-elm-newer" select="$concept-newer"/>
    </xsl:call-template>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="compare-conceptlists">
    <xsl:param name="conceptlist-older" as="element(conceptList)?" required="yes"/>
    <xsl:param name="conceptlist-newer" as="element(conceptList)?" required="yes"/>

    <xsl:where-populated>
      <diff type="conceptlist">
        <!-- Check if there is a corresponding concept/exception for all concepts/exceptions in the older concept list: -->
        <xsl:for-each select="$conceptlist-older/(concept | extension)">
          <xsl:variable name="code-type-older" as="xs:string" select="local-name(.)"/>
          <xsl:variable name="code-older" as="xs:string" select="@code"/>
          <xsl:variable name="corresponding-concept-newer" as="element()*" select="$conceptlist-newer/(concept | extension)[@code eq $code-older]"/>
          <xsl:choose>
            <xsl:when test="count($corresponding-concept-newer) gt 1">
              <xsl:sequence select="error((), 'Cannot handle multiple corresponding newer concepts/extensions')"/>
            </xsl:when>
            <xsl:when test="count($corresponding-concept-newer) eq 1">
              <xsl:variable name="code-type-newer" as="xs:string" select="local-name($corresponding-concept-newer)"/>
              <xsl:if test="$code-type-older ne $code-type-newer">
                <diff type="code-type" code="{$code-older}" type-older="{$code-type-older}" type-newer="{$code-type-newer}"
                  displayname-older="{@displayName}" displayname-newer="{$corresponding-concept-newer/@displayName}"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <diff type="code-deleted" code-older="{$code-older}" code-type-older="{$code-type-older}" displayname-older="{@displayName}"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        <!-- Check the lists vice-versa: -->
        <xsl:for-each select="$conceptlist-newer/(concept | extension)">
          <xsl:variable name="code-newer" as="xs:string" select="@code"/>
          <xsl:variable name="code-type-newer" as="xs:string" select="local-name(.)"/>
          <xsl:variable name="corresponding-concept-older" as="element()*" select="$conceptlist-older/(concept | extension)[@code eq $code-newer]"/>
          <xsl:choose>
            <xsl:when test="count($corresponding-concept-older) gt 1">
              <xsl:sequence select="error((), 'Cannot handle multiple corresponding older concepts/extensions')"/>
            </xsl:when>
            <xsl:when test="count($corresponding-concept-older) eq 1">
              <!-- Handled above -->
            </xsl:when>
            <xsl:otherwise>
              <diff type="code-new" code-newer="{$code-newer}" code-type-newer="{$code-type-newer}" displayname-newer="{@displayName}"/>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:for-each>
      </diff>
    </xsl:where-populated>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="report-child-concepts-without-shortname">
    <xsl:param name="parent" as="element()" required="yes"/>
    <xsl:param name="source-older" as="xs:boolean" required="yes"/>

    <xsl:where-populated>
      <concepts-no-shortname source="{if ($source-older) then 'older' else 'newer'}">
        <xsl:for-each select="$parent/concept[not(local:concept-has-shortname(.))]">
          <concept xpath="{local:get-rtd-xpath(.)}">
            <xsl:copy-of select="@id"/>
          </concept>
        </xsl:for-each>
      </concepts-no-shortname>
    </xsl:where-populated>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- GENERIC SUPPORT: -->

  <xsl:template name="check-concept-attribute">
    <xsl:param name="concept-older" as="element(concept)" required="yes"/>
    <xsl:param name="concept-newer" as="element(concept)" required="yes"/>
    <xsl:param name="attribute-name" as="xs:string" required="yes"/>
    <xsl:param name="reporting-name" as="xs:string" required="no" select="$attribute-name"/>

    <xsl:call-template name="check-value">
      <xsl:with-param name="value-older" select="string($concept-older/@*[local-name(.) eq $attribute-name])"/>
      <xsl:with-param name="value-newer" select="string($concept-newer/@*[local-name(.) eq $attribute-name])"/>
      <xsl:with-param name="reporting-name" select="$reporting-name"/>
    </xsl:call-template>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="check-value">
    <xsl:param name="value-older" as="xs:string?" required="yes"/>
    <xsl:param name="value-newer" as="xs:string?" required="yes"/>
    <xsl:param name="reporting-name" as="xs:string" required="yes"/>

    <xsl:if test="string($value-older) ne string($value-newer)">
      <diff type="{$reporting-name}" value-older="{$value-older}" value-newer="{$value-newer}"/>
    </xsl:if>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:concept-signature" as="xs:string?">
    <!-- Computes a signature string for an concept. If these strings are the same, the concepts are supposed to be about the same  -->
    <xsl:param name="concept" as="element(concept)"/>
    <!-- <xsl:choose>
      <xsl:when test="exists($concept/inherit/@ref)">
        <xsl:sequence select="'inherit-ref:' || $concept/inherit/@ref"/>
      </xsl:when>
      <xsl:when test="local:concept-has-shortname($concept)">
        <xsl:sequence select="'shortname:' || $concept/@shortName"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="()"/>
      </xsl:otherwise>
    </xsl:choose>-->
    <xsl:sequence select="'shortname:' || $concept/@shortName"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:concept-has-shortname" as="xs:boolean">
    <xsl:param name="concept" as="element(concept)"/>
    <xsl:sequence select="normalize-space($concept/@shortName) ne ''"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:elm-eq" as="xs:boolean">
    <xsl:param name="elm1" as="element()"/>
    <xsl:param name="elm2" as="element()"/>

    <xsl:sequence select="local-name($elm1) eq local-name($elm2)"/>
    <!-- Remark: We assume no namespaces. If namespace pop-up, use (namespace-uri($elm1) eq namespace-uri($elm2)) as well. -->
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-rtd-xpath" as="xs:string?">
    <!-- Computes a simple XPath expression to $elm -->
    <xsl:param name="elm" as="element()?"/>

    <xsl:choose>
      <xsl:when test="empty($elm)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="local:get-rtd-xpath($elm/parent::*) || '/' || local-name($elm) || local:elm-seq-nr-string($elm)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-doc-xpath" as="xs:string?">
    <xsl:param name="elm" as="element()?"/>

    <xsl:choose>
      <xsl:when test="empty($elm)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="shortname" as="xs:string" select="if (exists($elm/@shortName)) then string($elm/@shortName) else '?'"/>
        <xsl:sequence select="local:get-doc-xpath(($elm/ancestor::*[exists(@shortName)])[last()]) || '/' || $shortname"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:elm-seq-nr-string" as="xs:string?">
    <!-- Determines a sequence number string for an XPath. When () it means that a sequence number is not necessary -->
    <xsl:param name="elm" as="element()"/>

    <xsl:variable name="seq-nr" as="xs:integer?">
      <xsl:choose>

        <!-- We have to display a sequence number when there are siblings with the same name: -->
        <xsl:when test="exists($elm/preceding-sibling::*[local:elm-eq(., $elm)]) or exists($elm/following-sibling::*[local:elm-eq(., $elm)])">
          <xsl:sequence select="count($elm/preceding-sibling::*[local:elm-eq(., $elm)]) + 1"/>
        </xsl:when>

        <!-- No same siblings, no sequence number necessary... -->
        <xsl:otherwise>
          <xsl:sequence select="()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:sequence select="if (exists($seq-nr)) then concat('[', $seq-nr, ']') else ()"/>
  </xsl:function>


</xsl:stylesheet>
