<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xtlc="http://www.xtpxlib.nl/ns/common"
  xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:pxf="http://exproc.org/proposed/steps/file" xmlns:local="#local.e53_j2w_xgb" version="1.0"
  xpath-version="2.0" exclude-inline-prefixes="#all">

  <p:documentation>
      This pipeline generates what can be generated in the ADA-Lite-Geboortezorg repo. Input data is:
      - ada-lite/examples-lite
        From this it generates the examples-full and the examples-empty
      - design/specs-full
        Used in the generations mentoned above.
        From this it generates the schemas and Schematron files.
      
      
      The pipeline depends on an XProc module in xtpxlib (https://github.com/eriksiegel/xtpxlib). Directory dependencies:
      ---+--- Babyconnect --- ADA-Lite-Geboortezorg --- *
         |
         +--- xtpxlib --- *

  </p:documentation>

  <!-- ================================================================== -->
  <!-- SETUP: -->

  <p:output port="result" primary="true" sequence="false">
    <p:documentation> </p:documentation>
  </p:output>
  <p:serialization port="result" method="xml" encoding="UTF-8" indent="true" omit-xml-declaration="false"/>

  <p:import href="../../../../xtpxlib/common/xplmod/common.mod/common.mod.xpl"/>
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>

  <!-- ================================================================== -->
  <!-- GLOBAL VARIABLES: -->

  <p:variable name="root-dir" select="resolve-uri('../..', static-base-uri())"/>

  <!-- ================================================================== -->

  <!-- Get the contents of the full GIT repo in: -->
  <xtlc:recursive-directory-list>
    <p:with-option name="path" select="$root-dir"/>
    <p:with-option name="exclude-filter" select="'\.git.*'"/>
  </xtlc:recursive-directory-list>

  <!-- Create a list with things to do: -->
  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="xsl/generate-actions.xsl"/>
    </p:input>
    <p:with-param name="null" select="()"/>
  </p:xslt>

  <!-- Remove the directories we need to remove: -->
  <p:viewport match="remove-dir">
    <p:variable name="dir" select="/*/@path"/>
    <xtlc:remove-dir>
      <p:with-option name="dref-dir" select="$dir"/>
    </xtlc:remove-dir>
    <p:add-attribute attribute-name="status" attribute-value="success" match="/*"/>
  </p:viewport>

  <!-- Copy files: -->
  <p:viewport match="copy-file">
    <p:variable name="source" select="/*/@source"/>
    <p:variable name="target" select="/*/@target"/>
    <p:identity name="original"/>
    <pxf:copy>
      <p:with-option name="href" select="$source"/>
      <p:with-option name="target" select="$target"/>
      <p:with-option name="fail-on-error" select="true()"/>
    </pxf:copy>
    <!-- Get the original input back: -->
    <p:identity>
      <p:input port="source">
        <p:pipe port="result" step="original"/>
      </p:input>
    </p:identity>
    <p:add-attribute attribute-name="status" attribute-value="success" match="/*"/>
  </p:viewport>

  <!-- Create the specs-lite: -->
  <p:viewport match="specs-full2specs-lite">
    <p:variable name="in" select="/*/@in"/>
    <p:variable name="out" select="/*/@out"/>
    <p:identity name="original"/>
    <p:load dtd-validate="false">
      <p:with-option name="href" select="$in"/>
    </p:load>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="../xsl/spec-full2spec-lite.xsl"/>
      </p:input>
      <p:with-param name="null" select="()"/>
    </p:xslt>
    <p:store method="xml" omit-xml-declaration="false" indent="true">
      <p:with-option name="href" select="$out"/>
    </p:store>
    <!-- Get the original input back: -->
    <p:identity>
      <p:input port="source">
        <p:pipe port="result" step="original"/>
      </p:input>
    </p:identity>
    <p:add-attribute attribute-name="status" attribute-value="success" match="/*"/>
  </p:viewport>

  <!-- Create the examples-empty: -->
  <p:viewport match="example-lite2example-empty">
    <p:variable name="in" select="/*/@in"/>
    <p:variable name="out" select="/*/@out"/>
    <p:identity name="original"/>
    <p:load dtd-validate="false">
      <p:with-option name="href" select="$in"/>
    </p:load>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="../xsl/example-lite2example-empty.xsl"/>
      </p:input>
      <p:with-param name="null" select="()"/>
    </p:xslt>
    <p:store method="xml" omit-xml-declaration="false" indent="true">
      <p:with-option name="href" select="$out"/>
    </p:store>
    <!-- Get the original input back: -->
    <p:identity>
      <p:input port="source">
        <p:pipe port="result" step="original"/>
      </p:input>
    </p:identity>
    <p:add-attribute attribute-name="status" attribute-value="success" match="/*"/>
  </p:viewport>

  <!-- Generate the full examples: -->
  <p:viewport match="examples-lite2examples-full" name="viewport-examples-lite2examples-full">
    <p:variable name="in" select="/*/@in"/>
    <p:variable name="out" select="/*/@out"/>
    <p:variable name="rtd" select="/*/@rtd"/>
    <p:identity name="original"/>
    <p:load dtd-validate="false">
      <p:with-option name="href" select="$in"/>
    </p:load>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="../../ada-lite/xsl/ada-lite2ada-full.xsl"/>
      </p:input>
      <p:with-param name="dref-rtd" select="$rtd"/>
    </p:xslt>
    <p:store method="xml" omit-xml-declaration="false" indent="true">
      <p:with-option name="href" select="$out"/>
    </p:store>
    <!-- Get the original input back: -->
    <p:identity>
      <p:input port="source">
        <p:pipe port="result" step="original"/>
      </p:input>
    </p:identity>
    <p:add-attribute attribute-name="status" attribute-value="success" match="/*"/>
  </p:viewport>

  <!-- Generate schematron: -->
  <p:viewport match="spec2schematron">
    <p:variable name="in" select="/*/@in"/>
    <p:variable name="out" select="/*/@out"/>
    <p:variable name="ada-lite-version" select="/*/@ada-lite-version"/>
    <p:identity name="original"/>
    <p:load dtd-validate="false">
      <p:with-option name="href" select="$in"/>
    </p:load>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="../xsl/ada-rtd2ada-schema-simple.xsl"/>
      </p:input>
      <p:with-param name="ada-lite-version" select="$ada-lite-version"/>
    </p:xslt>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="../xsl/ada-schema-simple2ada-schematron.xsl"/>
      </p:input>
      <!-- Add the technical info to the full version only: -->
      <p:with-param name="add-technical-info" select="not(xs:boolean($ada-lite-version))"/>
    </p:xslt>
    <p:store method="xml" omit-xml-declaration="false" indent="true">
      <p:with-option name="href" select="$out"/>
    </p:store>
    <!-- Get the original input back: -->
    <p:identity>
      <p:input port="source">
        <p:pipe port="result" step="original"/>
      </p:input>
    </p:identity>
    <p:add-attribute attribute-name="status" attribute-value="success" match="/*"/>
  </p:viewport>

  <!-- Validate with schematron: -->
  <p:viewport match="validate-schematron">
    <p:variable name="in" select="/*/@in"/>
    <p:variable name="schematron" select="/*/@schematron"/>
    <p:identity name="original"/>
    <!-- Load the Schematron file: -->
    <p:load dtd-validate="false" name="schematron-file">
      <p:with-option name="href" select="$schematron"/>
    </p:load>
    <p:sink/>
    <!-- Load the file to validate and go: -->
    <p:load dtd-validate="false">
      <p:with-option name="href" select="$in"/>
    </p:load>
    <p:validate-with-schematron assert-valid="false" name="schematron-validation">
      <p:input port="schema">
        <p:pipe port="result" step="schematron-file"/>
      </p:input>
      <p:with-param name="null" select="()"/>
    </p:validate-with-schematron>
    <p:sink/>
    <!-- Get the report and filter only the necessary failed messages: -->
    <p:filter select="//svrl:failed-assert | //svrl:successful-report">
      <p:input port="source">
        <p:pipe port="report" step="schematron-validation"/>
      </p:input>
    </p:filter>
    <p:wrap-sequence wrapper="validation-result"/>
    <p:xslt name="schematron-validation-filtered">
      <p:input port="stylesheet">
        <p:document href="../xsl/remove-namespaces.xsl"/>
      </p:input>
      <p:with-param name="null" select="()"/>
    </p:xslt>
    <p:sink/>
    <!-- Create output: -->
    <p:insert match="/*" position="first-child">
      <p:input port="source">
        <p:pipe port="result" step="original"/>
      </p:input>
      <p:input port="insertion">
        <p:pipe port="result" step="schematron-validation-filtered"/>
      </p:input>
    </p:insert>
  </p:viewport>

</p:declare-step>
