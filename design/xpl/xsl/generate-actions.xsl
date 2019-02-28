<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xtlc="http://www.xtpxlib.nl/ns/common" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:local="#local.xqg_kfw_xgb"
  exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
       Input to this stylesheet is a full directory listing of the files in the ADA-Lite-Gebeoortezorg repo (as generated
       by the XProc step xtlc:recursive-directory-list).
       
       Output is a list of actions. The encompassing XProc then performs these actions.
       
       This stylesheet relies on the presence of xtpxlib. See the comment in ../generate-specs.xpl about how this library must be placed.
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="xml" indent="no" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="../../../../../xtpxlib/common/xslmod/dref.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="dir-common-root" as="xs:string" select="/c:directory/@xml:base"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Common names: -->

  <xsl:variable name="subdir-examples-lite" as="xs:string" select="'examples-lite'"/>
  <xsl:variable name="subdir-xsl" as="xs:string" select="'xsl'"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Source related information: -->

  <xsl:variable name="subdir-source-main" as="xs:string" select="'design'"/>
  <xsl:variable name="subdir-source-specs-full" as="xs:string" select="'specs-full'"/>

  <xsl:variable name="dir-source-main" as="xs:string" select="xtlc:dref-concat(($dir-common-root, $subdir-source-main))"/>
  <xsl:variable name="dir-source-examples-lite" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-examples-lite))"/>
  <xsl:variable name="dir-source-specs-full" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-source-specs-full))"/>
  <xsl:variable name="dir-source-xsl" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-xsl))"/>

  <!-- All examples lite files: -->
  <xsl:variable name="filelist-source-examples-lite" as="xs:string*">
    <xsl:for-each
      select="/c:directory/c:directory[@name eq $subdir-source-main]/c:directory[@name eq $subdir-examples-lite]/c:file/@name[xtlc:dref-ext(.) eq 'xml']">
      <xsl:sequence select="xtlc:dref-concat(($dir-source-examples-lite, .))"/>
    </xsl:for-each>
  </xsl:variable>

  <!-- All full specification files: -->
  <xsl:variable name="filelist-source-specs-full" as="xs:string*">
    <xsl:for-each
      select="/c:directory/c:directory[@name eq $subdir-source-main]/c:directory[@name eq $subdir-source-specs-full]/c:file/@name[xtlc:dref-ext(.) eq 'xml']">
      <xsl:sequence select="xtlc:dref-concat(($dir-source-specs-full, .))"/>
    </xsl:for-each>
  </xsl:variable>

  <!-- Create a map that maps the transaction ids onto the right specification file: -->
  <xsl:variable name="transaction-id2specification-file" as="map(xs:string, xs:string)">
    <xsl:map>
      <xsl:for-each select="$filelist-source-specs-full">
        <xsl:map-entry key="string(doc(.)/*/@transactionId)" select="."/>
      </xsl:for-each>
    </xsl:map>
  </xsl:variable>


  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Build related information: -->

  <xsl:variable name="subdir-build-main" as="xs:string" select="'ada-lite'"/>
  <xsl:variable name="subdir-build-specs-lite" as="xs:string" select="'specs-lite'"/>
  <xsl:variable name="subdir-build-examples-empty" as="xs:string" select="'examples-empty'"/>
  <xsl:variable name="subdir-build-examples-full" as="xs:string" select="'examples-full'"/>
  <xsl:variable name="subdir-build-schematron-full" as="xs:string" select="'schematron-full'"/>
  <xsl:variable name="subdir-build-schematron-lite" as="xs:string" select="'schematron-lite'"/>

  <xsl:variable name="dir-build-main" as="xs:string" select="xtlc:dref-concat(($dir-common-root, $subdir-build-main))"/>
  <xsl:variable name="dir-build-xsl" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-xsl))"/>
  <xsl:variable name="dir-build-examples-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-examples-lite))"/>
  <xsl:variable name="dir-build-specs-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-specs-lite))"/>
  <xsl:variable name="dir-build-examples-empty" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-examples-empty))"/>
  <xsl:variable name="dir-build-examples-full" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-examples-full))"/>
  <xsl:variable name="dir-build-schematron-full" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schematron-full))"/>
  <xsl:variable name="dir-build-schematron-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schematron-lite))"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <actions timestamp="{fn:current-dateTime()}" root="{/*/@xml:base}">

      <!-- Remove the full build branch, since we're going to create this from scratch: -->
      <remove-dir path="{$dir-build-main}"/>

      <!-- Copy the xsl files necessary in the build -->
      <xsl:call-template name="generate-action-copy-file">
        <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-source-xsl, 'ada-lite2ada-full.xsl'))"/>
        <xsl:with-param name="dir-target" select="$dir-build-xsl"/>
      </xsl:call-template>

      <!-- Copy the examples lite: -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <xsl:call-template name="generate-action-copy-file">
          <xsl:with-param name="file-source" select="."/>
          <xsl:with-param name="dir-target" select="$dir-build-examples-lite"/>
        </xsl:call-template>
      </xsl:for-each>

      <!-- Create the specifications-lite: -->
      <xsl:for-each select="$filelist-source-specs-full">
        <specs-full2specs-lite in="{.}" out="{xtlc:dref-concat(($dir-build-specs-lite, xtlc:dref-name(.)))}"/>
      </xsl:for-each>

      <!-- Create the examples-empty: -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <example-lite2example-empty in="{.}" out="{xtlc:dref-concat(($dir-build-examples-empty, xtlc:dref-name(.)))}"/>
      </xsl:for-each>

      <!-- Create the examples-full: -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <examples-lite2examples-full in="{.}" out="{xtlc:dref-concat(($dir-build-examples-full, xtlc:dref-name(.)))}"
          rtd="{local:get-specification-file-from-transaction-id(doc(.)/*/@transactionRef)}"/>
      </xsl:for-each>

      <!-- Create the Schematrons: -->
      <xsl:for-each select="$filelist-source-specs-full">
        <spec2schematron in="{.}" out="{xtlc:dref-concat(($dir-build-schematron-lite, xtlc:dref-name-noext(.) || '.sch'))}" ada-lite-version="true"/>
        <spec2schematron in="{.}" out="{xtlc:dref-concat(($dir-build-schematron-full, xtlc:dref-name-noext(.) || '.sch'))}" ada-lite-version="false"/>
      </xsl:for-each>


      <!--      <xsl:call-template name="generate-actions-examples-lite2examples-full"/>-->
      <!-- TBD: Generate the examples-empty -->
      <!-- TBD: Generate the schematrons lite -->
      <!-- TBD: Generate the schematrons full -->
      <!-- TBD: Generate the schemas (lite/full)? -->
      <!-- TBD: generate the validations we can do! -->
    </actions>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- ACTION GENERATION: -->



  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <!--<xsl:template name="generate-actions-examples-lite2examples-full">

    <xsl:variable name="examples-lite-subdir-name" as="xs:string" select="'examples-lite'"/>
    <xsl:variable name="examples-full-subdir-name" as="xs:string" select="'examples-full'"/>

    <xsl:comment> == examples-full2examples-lite == </xsl:comment>
    <xsl:call-template name="generate-action-remove-dir">
      <xsl:with-param name="dir" select="$ada-lite-directory/c:directory[@name eq $examples-full-subdir-name]/@xml:base"/>
    </xsl:call-template>

    <xsl:variable name="examples-lite-directory" as="element(c:directory)"
      select="$ada-lite-directory/c:directory[@name eq $examples-lite-subdir-name]"/>
    <xsl:variable name="examples-lite-files" as="element(c:file)+" select="$examples-lite-directory/c:file"/>

    <xsl:for-each select="$examples-lite-files">
      <xsl:variable name="filename" as="xs:string" select="@name"/>
      <xsl:variable name="full-input-filename" as="xs:string" select="$ada-lite-directory/@xml:base || $examples-lite-subdir-name || '/' || $filename"/>
      <xsl:variable name="transaction-ref" as="xs:string" select="doc($full-input-filename)/*/@transactionRef"/>
      <xsl:variable name="rtd" as="xs:string?" select="$transactionid2rtd($transaction-ref)"/>
      <xsl:if test="empty($rtd)">
        <xsl:sequence select="error((), 'No full specs rtd found for transaction id ' || $transaction-ref)"/>
      </xsl:if>
      <examples-lite2examples-full in="{$full-input-filename}" out="{$ada-lite-directory/@xml:base}{$examples-full-subdir-name}/{$filename}"
        rtd="{$rtd}"/>
    </xsl:for-each>

  </xsl:template>-->

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="generate-action-copy-file">
    <!-- Copies a file into a directory. Specify $name-target if it needs another name. -->
    <xsl:param name="file-source" as="xs:string" required="yes"/>
    <xsl:param name="dir-target" as="xs:string" required="yes"/>
    <xsl:param name="name-target" as="xs:string?" required="no" select="()"/>

    <xsl:variable name="filename-target" as="xs:string" select="($name-target, xtlc:dref-name($file-source))[1]"/>
    <xsl:variable name="file-target" as="xs:string" select="xtlc:dref-concat(($dir-target, $filename-target))"/>
    <copy-file source="{$file-source}" target="{$file-target}"/>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-specification-file-from-transaction-id" as="xs:string">
    <xsl:param name="transaction-id" as="xs:string"/>

    <xsl:variable name="specification-file" as="xs:string?" select="$transaction-id2specification-file($transaction-id)"/>
    <xsl:if test="empty($specification-file)">
      <xsl:sequence select="error((), 'No specification file found for transaction id ' || $transaction-id)"/>
    </xsl:if>
    <xsl:sequence select="$specification-file"/>
  </xsl:function>


</xsl:stylesheet>
