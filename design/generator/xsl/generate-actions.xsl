<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xtlc="http://www.xtpxlib.nl/ns/common" xmlns:local="#local.xqg_kfw_xgb" exclude-result-prefixes="#all" expand-text="true">
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

  <xsl:include href="../../../../../xtpxlib/common/xslmod/common.mod.xsl"/>
  <xsl:include href="../../../../../xtpxlib/common/xslmod/dref.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

  <xsl:variable name="dir-common-root" as="xs:string" select="/c:directory/@xml:base"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Common names: -->

  <xsl:variable name="subdir-examples-lite" as="xs:string" select="'examples-lite'"/>
  <xsl:variable name="subdir-xsl" as="xs:string" select="'xsl'"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Documentation related information: -->

  <xsl:variable name="dir-docs-main" as="xs:string" select="xtlc:dref-concat(($dir-common-root, 'docs'))"/>
  <xsl:variable name="filename-readme" as="xs:string" select="'README.md'"/>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
  <!-- Source related information: -->

  <xsl:variable name="subdir-source-main" as="xs:string" select="'design'"/>
  <xsl:variable name="subdir-source-specs-full" as="xs:string" select="'specs-full'"/>
  <xsl:variable name="subdir-source-documentation" as="xs:string" select="'documentation'"/>

  <xsl:variable name="dir-source-main" as="xs:string" select="xtlc:dref-concat(($dir-common-root, $subdir-source-main))"/>
  <xsl:variable name="dir-source-examples-lite" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-examples-lite))"/>
  <xsl:variable name="dir-source-specs-full" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-source-specs-full))"/>
  <xsl:variable name="dir-source-xsl" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-xsl))"/>
  <xsl:variable name="dir-source-documentation" as="xs:string" select="xtlc:dref-concat(($dir-source-main, $subdir-source-documentation))"/>

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
  <xsl:variable name="subdir-build-specs-simplified" as="xs:string" select="'specs-simplified'"/>
  <xsl:variable name="subdir-build-examples-empty" as="xs:string" select="'examples-empty'"/>
  <xsl:variable name="subdir-build-examples-full" as="xs:string" select="'examples-full'"/>
  <xsl:variable name="subdir-build-schematron-full" as="xs:string" select="'schematrons-full'"/>
  <xsl:variable name="subdir-build-schematron-lite" as="xs:string" select="'schematrons-lite'"/>
  <xsl:variable name="subdir-build-schema" as="xs:string" select="'schemas'"/>
  <xsl:variable name="subdir-build-schema-simple-full" as="xs:string" select="'schemas-simple-full'"/>
  <xsl:variable name="subdir-build-schema-simple-lite" as="xs:string" select="'schemas-simple-lite'"/>
  <xsl:variable name="subdir-build-svrl-xsl" as="xs:string" select="'svrl-xsl'"/>
  <xsl:variable name="subdir-build-diffs" as="xs:string" select="'diffs'"/>

  <xsl:variable name="dir-build-main" as="xs:string" select="xtlc:dref-concat(($dir-common-root, $subdir-build-main))"/>
  <xsl:variable name="dir-build-xsl" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-xsl))"/>
  <xsl:variable name="dir-build-examples-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-examples-lite))"/>
  <xsl:variable name="dir-build-specs-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-specs-simplified))"/>
  <xsl:variable name="dir-build-examples-empty" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-examples-empty))"/>
  <xsl:variable name="dir-build-examples-full" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-examples-full))"/>
  <xsl:variable name="dir-build-schematron-full" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schematron-full))"/>
  <xsl:variable name="dir-build-schematron-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schematron-lite))"/>
  <xsl:variable name="dir-build-schema" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schema))"/>
  <xsl:variable name="dir-build-schema-simple-full" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schema-simple-full))"/>
  <xsl:variable name="dir-build-schema-simple-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-schema-simple-lite))"/>
  <xsl:variable name="dir-build-diffs" as="xs:string" select="xtlc:dref-concat(($dir-build-main, $subdir-build-diffs))"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATES: -->

  <xsl:template match="/">
    <actions timestamp="{current-dateTime()}" root="{/*/@xml:base}">

      <!-- Perform checks on the specifications: -->
      <xsl:for-each select="$filelist-source-specs-full">
        <check-specification in="{.}"/>
      </xsl:for-each>

      <!-- Remove the full build and docs branch, since we're going to create these from scratch: -->
      <remove-dir path="{$dir-build-main}"/>
      <remove-dir path="{$dir-docs-main}"/>

      <!-- Copy the xsl files (and included libraries!) necessary in the build -->
      <xsl:call-template name="generate-action-copy-file">
        <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-source-xsl, 'ada-lite2ada-full.xsl'))"/>
        <xsl:with-param name="dir-target" select="$dir-build-xsl"/>
      </xsl:call-template>
      <xsl:call-template name="generate-action-copy-file">
        <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-source-xsl, 'lib', 'xsl-common.xsl'))"/>
        <xsl:with-param name="dir-target" select="xtlc:dref-concat(($dir-build-xsl, 'lib'))"/>
      </xsl:call-template>
      <xsl:call-template name="generate-action-copy-file">
        <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-source-xsl, 'art-decor', 'shortName.xsl'))"/>
        <xsl:with-param name="dir-target" select="xtlc:dref-concat(($dir-build-xsl, 'art-decor'))"/>
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
      <xsl:for-each select="$filelist-source-specs-full">
        <specs-full2examples-empty in="{.}" out="{xtlc:dref-concat(($dir-build-examples-empty, xtlc:dref-name(.)))}"/>
      </xsl:for-each>

      <!-- Create the examples-full: -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <examples-lite2examples-full in="{.}" out="{xtlc:dref-concat(($dir-build-examples-full, xtlc:dref-name(.)))}"
          rtd="{local:get-specification-file-from-transaction-id(doc(.)/*/@transactionRef)}"/>
      </xsl:for-each>

      <!-- Create the Schematrons and the SVRL generating xslt stylesheets: -->
      <xsl:for-each select="$filelist-source-specs-full">
        <xsl:variable name="basename" as="xs:string" select="xtlc:dref-name-noext(.)"/>
        <!-- Lite: -->
        <xsl:variable name="schematron-outfile-lite" as="xs:string" select="xtlc:dref-concat(($dir-build-schematron-lite, $basename || '.lite.sch'))"/>
        <xsl:variable name="svrl-xsl-outfile-lite" as="xs:string"
          select="xtlc:dref-concat(($dir-build-schematron-lite, $subdir-build-svrl-xsl, $basename || '.lite.xsl'))"/>
        <spec2schematron in="{.}" out="{$schematron-outfile-lite}" ada-lite-version="true"/>
        <schematron2svrl-xsl in="{$schematron-outfile-lite}" out="{$svrl-xsl-outfile-lite}"/>
        <!-- Full: -->
        <xsl:variable name="schematron-outfile-full" as="xs:string" select="xtlc:dref-concat(($dir-build-schematron-full, $basename || '.full.sch'))"/>
        <xsl:variable name="svrl-xsl-outfile-full" as="xs:string"
          select="xtlc:dref-concat(($dir-build-schematron-full, $subdir-build-svrl-xsl, $basename || '.full.xsl'))"/>
        <spec2schematron in="{.}" out="{$schematron-outfile-full}" ada-lite-version="false"/>
        <schematron2svrl-xsl in="{$schematron-outfile-full}" out="{$svrl-xsl-outfile-full}"/>
      </xsl:for-each>

      <!-- Generate the schemas: -->
      <xsl:for-each select="$filelist-source-specs-full">
        <!-- The schema generation is done with ART-DECOR stylesheets that write files under a certain name as secondary documents. We need to
          catch this generated file and write it to the appropriate location. For this we need the name of the generated file which is
          passed in @generated-xsd-filename.
        -->
        <spec2schema in="{.}" out="{xtlc:dref-concat(($dir-build-schema, xtlc:dref-name-noext(.) || '.xsd'))}"
          generated-xsd-filename="{string(doc(.)/*/@shortName) || '.xsd'}"/>
      </xsl:for-each>

      <!-- Create the simple schemas: -->
      <xsl:for-each select="$filelist-source-specs-full">
        <spec2schema-simple in="{.}" out="{xtlc:dref-concat(($dir-build-schema-simple-full, xtlc:dref-name-noext(.) || '.simple.full.xsd'))}"
          ada-lite-version="false"/>
        <spec2schema-simple in="{.}" out="{xtlc:dref-concat(($dir-build-schema-simple-lite, xtlc:dref-name-noext(.) || '.simple.lite.xsd'))}"
          ada-lite-version="true"/>
      </xsl:for-each>

      <!-- Create the diff specifications: -->
      <xsl:variable name="dref-difflist" as="xs:string" select="xtlc:dref-canonical(resolve-uri('../data/difflist.xml', static-base-uri()))"/>
      <xsl:if test="not(doc-available($dref-difflist))">
        <xsl:sequence select="error((), 'Could not find the difflist xml ' || xtlc:q($dref-difflist))"/>
      </xsl:if>
      <xsl:variable name="difflist-root" as="element(difflist)" select="doc($dref-difflist)/*"/>
      <xsl:for-each select="$difflist-root/diff[@newer][@older][@output]">
        <specification-diff older="{xtlc:dref-concat(($dir-source-specs-full, @older))}" newer="{xtlc:dref-concat(($dir-source-specs-full, @newer))}"
          html-out="{xtlc:dref-concat(($dir-build-diffs, @output || '.html'))}" xml-out="{xtlc:dref-concat(($dir-build-diffs, @output || '.xml'))}"/>
      </xsl:for-each>

      <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
      <!-- DOcumentation and GitHub pages: -->

      <xsl:variable name="dref-sitegen" as="xs:string" select="xtlc:dref-canonical(resolve-uri('../data/sitegen.xml', static-base-uri()))"/>
      <xsl:if test="not(doc-available($dref-sitegen))">
        <xsl:sequence select="error((), 'Could not find the sitegen xml ' || xtlc:q($dref-sitegen))"/>
      </xsl:if>
      <xsl:variable name="sitegen-root" as="element(sitegen)" select="doc($dref-sitegen)/*"/>
      <!-- Copy the documentation files as mentioned in the sitegen spec: -->
      <xsl:for-each select="$sitegen-root/filecopy[@source][@destination]">
        <xsl:call-template name="generate-action-copy-file">
          <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-common-root, @source))"/>
          <xsl:with-param name="dir-target" select="xtlc:dref-concat(($dir-docs-main, xtlc:dref-path(@destination)))"/>
          <xsl:with-param name="name-target" select="xtlc:dref-name(@destination)"/>
        </xsl:call-template>
      </xsl:for-each>
      <!-- Copy the diff html files (the home page will link to them) -->
      <xsl:for-each select="$difflist-root/diff[@newer][@older][@output]">
        <xsl:call-template name="generate-action-copy-file">
          <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-build-diffs, @output || '.html'))"/>
          <xsl:with-param name="dir-target" select="xtlc:dref-concat(($dir-docs-main, 'diffs'))"/>
        </xsl:call-template>
      </xsl:for-each>
      <!-- Create home page: -->
      <xsl:variable name="home-page-spec-elm" as="element(generate-home)" select="$sitegen-root/generate-home[1]"/>
      <create-gh-home-page in="{xtlc:dref-concat(($dir-common-root, $home-page-spec-elm/@source))}"
        out="{xtlc:dref-concat(($dir-docs-main, lower-case($filename-readme)))}" difflist="{$dref-difflist}" diffdir="{$dir-build-diffs}"/>

      <xsl:variable name="dref-docgen" as="xs:string" select="xtlc:dref-canonical(resolve-uri('../data/docgen.xml', static-base-uri()))"/>
      <xsl:if test="not(doc-available($dref-docgen))">
        <xsl:sequence select="error((), 'Could not find the docgen xml ' || xtlc:q($dref-docgen))"/>
      </xsl:if>
      <xsl:variable name="docgen-root" as="element(docgen)" select="doc($dref-docgen)/*"/>
      <xsl:for-each select="$docgen-root/doccopy[@source][@destination]">
        <xsl:call-template name="generate-action-copy-file">
          <xsl:with-param name="file-source" select="xtlc:dref-concat(($dir-source-documentation, @source))"/>
          <xsl:with-param name="dir-target" select="xtlc:dref-concat(($dir-build-main, @destination))"/>
          <xsl:with-param name="name-target" select="$filename-readme"/>
        </xsl:call-template>
      </xsl:for-each>

      <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
      <!-- Validations: -->

      <!-- Create validation actions 1: Validate the examples-lite against the appropriate schemas (normal and simple one): -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <xsl:variable name="specification-file" as="xs:string" select="local:get-specification-file-from-transaction-id(doc(.)/*/@transactionRef)"/>
        <xsl:variable name="specification-filename-noext" as="xs:string" select="xtlc:dref-name-noext($specification-file)"/>
        <xsl:variable name="schema-file" as="xs:string" select="xtlc:dref-concat(($dir-build-schema, $specification-filename-noext || '.xsd'))"/>
        <xsl:variable name="schema-file-simple" as="xs:string"
          select="xtlc:dref-concat(($dir-build-schema-simple-lite, $specification-filename-noext || '.simple.lite.xsd'))"/>
        <!-- Remark: Validation of the lite example against the (ART-DECOR generated) schema is disabled because a lite document can 
          contain enum attributes. These are for the lite documents only and are not in the schemas. -->
        <!--<validate-schema in="{.}" schema="{$schema-file}"/>-->
        <validate-schema in="{.}" schema="{$schema-file-simple}"/>
      </xsl:for-each>

      <!-- Create validation actions 2: Validate the examples-full against the appropriate schema (normal and simple one): -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <xsl:variable name="specification-file" as="xs:string" select="local:get-specification-file-from-transaction-id(doc(.)/*/@transactionRef)"/>
        <xsl:variable name="specification-filename-noext" as="xs:string" select="xtlc:dref-name-noext($specification-file)"/>
        <xsl:variable name="examples-full-file" as="xs:string" select="xtlc:dref-concat(($dir-build-examples-full, xtlc:dref-name(.)))"/>
        <xsl:variable name="schema-file" as="xs:string" select="xtlc:dref-concat(($dir-build-schema, $specification-filename-noext || '.xsd'))"/>
        <xsl:variable name="schema-file-simple" as="xs:string"
          select="xtlc:dref-concat(($dir-build-schema-simple-full, $specification-filename-noext || '.simple.full.xsd'))"/>
        <validate-schema in="{$examples-full-file}" schema="{$schema-file}"/>
        <validate-schema in="{$examples-full-file}" schema="{$schema-file-simple}"/>
      </xsl:for-each>

      <!-- Create validation actions 3: Validate the examples-lite against the appropriate Schematron: -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <xsl:variable name="specification-file" as="xs:string" select="local:get-specification-file-from-transaction-id(doc(.)/*/@transactionRef)"/>
        <xsl:variable name="schematron-file" as="xs:string"
          select="xtlc:dref-concat(($dir-build-schematron-lite, xtlc:dref-name-noext($specification-file) || '.lite.sch'))"/>
        <validate-schematron in="{.}" schematron="{$schematron-file}"/>
      </xsl:for-each>

      <!-- Create validation actions 4: Validate the examples-full against the appropriate Schematron: -->
      <xsl:for-each select="$filelist-source-examples-lite">
        <xsl:variable name="examples-full-file" as="xs:string" select="xtlc:dref-concat(($dir-build-examples-full, xtlc:dref-name(.)))"/>
        <xsl:variable name="specification-file" as="xs:string" select="local:get-specification-file-from-transaction-id(doc(.)/*/@transactionRef)"/>
        <xsl:variable name="schematron-file" as="xs:string"
          select="xtlc:dref-concat(($dir-build-schematron-full, xtlc:dref-name-noext($specification-file) || '.full.sch'))"/>
        <validate-schematron in="{$examples-full-file}" schematron="{$schematron-file}"/>
      </xsl:for-each>

    </actions>
  </xsl:template>

  <!-- ================================================================== -->

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
