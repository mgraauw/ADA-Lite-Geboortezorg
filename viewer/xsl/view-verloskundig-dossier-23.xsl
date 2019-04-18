<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="#local.vgm_d5w_fhb"
  xmlns:bc-al2af="https://babyconnect.org/ns/ada-lite2ada-full" exclude-result-prefixes="#all" expand-text="true">
  <!-- ================================================================== -->
  <!-- 
      Creates a HTML page from a verloskundig dossier 2.3
  -->
  <!-- ================================================================== -->
  <!-- SETUP: -->

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:mode on-no-match="fail"/>

  <xsl:include href="../../design/xsl/lib/xsl-common.xsl"/>
  <xsl:include href="../../design/xsl/lib/ada-lite2ada-full.mod.xsl"/>

  <!-- ================================================================== -->
  <!-- PARAMETERS: -->

  <xsl:param name="input-is-ada-full" as="xs:string" required="no" select="string(false())">
    <!-- Set this to true when the input file is (already) an ADA-full file. -->
  </xsl:param>

  <xsl:param name="dref-specification" as="xs:string" required="no"
    select="resolve-uri('../../design/specs-full/verloskundig-dossier-23.xml', static-base-uri())"/>
  <!-- Document reference to the Retrieve Transaction Dataset document (with root element <dataset>) for . -->

  <xsl:param name="dref-css" as="xs:string" required="no" select="resolve-uri('../data/viewer.css', static-base-uri())">
    <!-- Reference to the CSS file used for generating the result.  -->
  </xsl:param>

  <!-- ================================================================== -->
  <!-- GLOBAL DECLARATIONS: -->

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

  <xsl:variable name="verloskundig-dossier-23-transaction-id" as="xs:string" select="'2.16.840.1.113883.2.4.3.11.60.90.77.4.2467'"/>
  <xsl:variable name="error-prompt" as="xs:string" select="'*** View verloskundig dossier 23: '"/>

  <xsl:variable name="nvt" as="xs:string" select="'nvt'"/>

  <!-- ================================================================== -->
  <!-- MAIN TEMPLATE: -->

  <xsl:template match="/">
    <xsl:apply-templates select="/*"/>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template match="/*">

    <!-- Pre-flight checks: -->
    <xsl:if test="/*/@transactionRef ne $verloskundig-dossier-23-transaction-id">
      <xsl:sequence
        select="error((), $error-prompt || 'Input @transactionRef has an incorrect value. Got ' || local:q(/*/@transactionRef) || 
          ', expected ' || local:q($verloskundig-dossier-23-transaction-id))"
      />
    </xsl:if>
    <xsl:if test="empty($specification-root/self::dataset)">
      <xsl:sequence select="error((), $error-prompt || 'Missing or invalid ADA specification ' || local:q($dref-specification))"/>
    </xsl:if>
    <xsl:if test="$specification-root/@transactionId ne $verloskundig-dossier-23-transaction-id">
      <xsl:sequence
        select="error((), $error-prompt || 'Specification @transactionId has an incorrect value. Got ' || 
        local:q($specification-root/@transactionId) || ', expected ' || local:q($verloskundig-dossier-23-transaction-id))"
      />
    </xsl:if>


    <!-- Create the HTML: -->
    <xsl:variable name="title" as="xs:string" select="'Samenvatting verloskundig dossier'"/>
    <html>
      <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title> { $title }</title>
        <xsl:if test="unparsed-text-available($dref-css)">
          <style> 
            <xsl:value-of select="unparsed-text($dref-css)"/>
          </style>
        </xsl:if>
      </head>
      <body>
        <h1 class="main-title">{ $title }</h1>

        <xsl:call-template name="do-header"/>

        <xsl:call-template name="do-section-overdracht"/>
        <xsl:call-template name="do-section-anamnese"/>
        <xsl:call-template name="do-section-voorgaande-zwangerschappen"/>
        <xsl:call-template name="do-section-laboratoriumuitslagen"/>
        <xsl:call-template name="do-section-huidige-zwangerschap"/>
        <xsl:call-template name="do-section-partus"/>
        <xsl:call-template name="do-section-baring-per-kind"/>
        <xsl:call-template name="do-section-onderzoek-moeder"/>
        <xsl:call-template name="do-section-ante-partum"/>

      </body>
    </html>

  </xsl:template>

  <!-- ================================================================== -->
  <!-- HEADER: -->

  <xsl:template name="do-header">

    <div class="header">
      <table width="100%">
        <tr valign="top">
          <!-- Left column in header: -->
          <td>
            <table class="header-table">
              <tr>
                <td>Naam: </td>
                <td>{local:get-value-by-id('.6.82360')} {local:get-value-by-id('.6.82363')} {local:get-value-by-id('.6.10043')}</td>
              </tr>
              <tr>
                <td>BSN: </td>
                <td>{local:get-value-by-id('.6.10030')}</td>
              </tr>
              <tr>
                <td>Zwangerschap: </td>
                <td>G/P {local:get-value-by-id('.6.20010')}/{local:get-value-by-id('.6.20153')}</td>
              </tr>
              <tr>
                <td>At. Datum: </td>
                <td>{local:get-value-by-id('.6.20030')}</td>
              </tr>
            </table>
          </td>
          <!-- Right column in header: -->
          <td>
            <table class="header-table">
              <tr>
                <td>Naam zorgverlener: </td>
                <td>{local:get-value-by-id('.6.80736')}</td>
              </tr>
              <tr>
                <td>Naam zorginstelling: </td>
                <td>{local:get-value-by-id('.6.10026')}</td>
              </tr>
              <tr>
                <td>Zorginstelling OID: </td>
                <td>{local:get-value-by-id('.6.10021')}</td>
              </tr>
              <tr>
                <td>Telefoon: </td>
                <td>{local:get-value-by-id('.6.10012')}</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- SECTIONS: -->

  <xsl:template name="do-section-overdracht">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'OVERDRACHT GEBOORTEZORG PER ?DATUM?'"/>
      <xsl:with-param name="color" select="'black'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="20%" style="color: red;">Reden overdracht</th>
            <th>Toelichting</th>
          </tr>
          <tr>
            <td style="color: red;">
              <xsl:call-template name="process-nested-data">
                <xsl:with-param name="parent-id-suffix" select="'.6.20365'"/>
                <xsl:with-param name="child-id-suffixes" select="'.6.20372'"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="process-nested-data">
                <xsl:with-param name="parent-id-suffix" select="'.6.20365'"/>
                <xsl:with-param name="child-id-suffixes" select="'.6.20373'"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
        <table>
          <tr>
            <th width="20%">Bloedverlies</th>
            <th>Actuele Bloeddruk</th>
            <th>Intra-uteriene vruchtdood?</th>
            <th>Taalvaardigheid</th>
          </tr>
          <tr>
            <td>{local:get-value-by-id('.6.20633')}</td>
            <td>
              <xsl:call-template name="process-nested-data">
                <xsl:with-param name="parent-id-suffix" select="'.6.10807'"/>
                <xsl:with-param name="child-id-suffixes" select="('.6.10808', '.6.10809')"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:call-template name="process-nested-data">
                <xsl:with-param name="parent-id-suffix" select="'.6.80613'"/>
                <xsl:with-param name="child-id-suffixes" select="'.6.80614'"/>
              </xsl:call-template>
            </td>
            <td>{local:get-value-by-id('.6.10401')}</td>
          </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-anamnese">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'ANAMNESE'"/>
      <xsl:with-param name="color" select="'grey'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="31%">Bijzonderheden algemene anamnese</th>
            <th width="31%">Bijzonderheden obstetrische anamnese</th>
            <th width="7%">Allergieën</th>
            <th width="7%">Actuele medicatie</th>
            <th width="7%">Bloed-transfusie</th>
            <th width="7%">BMI</th>
            <th>Negatieve seksuele ervaringen</th>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="local:get-value-by-id('.6.10610')"/>
              <br/>
              <xsl:call-template name="process-multi-values">
                <xsl:with-param name="id-suffix" select="'.6.10611'"/>
              </xsl:call-template>
            </td>
            <td>
              <xsl:value-of select="local:get-value-by-id('.6.10710')"/>
              <br/>
              <xsl:call-template name="process-multi-values">
                <xsl:with-param name="id-suffix" select="'.6.10711'"/>
              </xsl:call-template>
            </td>
            <td>{local:get-value-by-id('.6.10800')}</td>
            <td>{local:get-value-by-id('.6.10801')}</td>
            <td>{local:get-value-by-id('.6.10805')}</td>
            <td>{local:get-value-by-id('.6.10806')}</td>
            <td>{local:get-value-by-id('.6.10803')}</td>
          </tr>

        </table>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-voorgaande-zwangerschappen">
    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'VOORGAANDE ZWANGERSCHAPPEN'"/>
      <xsl:with-param name="color" select="'dodgerblue'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="8%">Identificatie zwangerschap</th>
            <th width="8%">Wijze einde zwangerschap</th>
            <th width="8%">Zwangerschaps-duur</th>
            <th width="8%">Bloedverlies</th>
            <th width="8%">Duur ontsluiting</th>
            <th width="8%">Duur uitdrijving</th>
            <th width="8%">Conditie perineum postpartum</th>
            <th width="8%">Type partus</th>
            <th width="8%">Geboortegewicht</th>
            <th width="8%">Apgarscore na 5 min.</th>
            <th width="8%">Vaginale kunstverlossing</th>
            <th>Beslismoment sectio caesarea</th>
          </tr>
          <xsl:variable name="elms" as="element()*" select="local:find-elms-by-id('.6.17')"/>
          <xsl:choose>
            <xsl:when test="exists($elms)">
              <xsl:for-each select="$elms">
                <xsl:call-template name="do-voorgaande-zwangerschap-row">
                  <xsl:with-param name="context-elm" select="."/>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="check" as="xs:string" select="local:check-id('.6.17')"/>
              <xsl:choose>
                <xsl:when test="contains($check, '?')">
                  <tr>
                    <td>{$check}</td>
                  </tr>
                  <xsl:call-template name="do-voorgaande-zwangerschap-row">
                    <xsl:with-param name="context-elm" select="$full-data-document/*"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise/>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </table>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-voorgaande-zwangerschap-row">
    <xsl:param name="context-elm" as="element()" required="yes"/>

    <tr>
      <td>{local:get-value-by-id($context-elm, '.6.10590')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.80623')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.10599')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.10598')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.10601')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.10602')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.80674')}</td>
      <td>
        <xsl:call-template name="process-nested-data">
          <xsl:with-param name="search-root" select="$context-elm"/>
          <xsl:with-param name="parent-id-suffix" select="'.6.21'"/>
          <xsl:with-param name="child-id-suffixes" select="'.6.80624'"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="process-nested-data">
          <xsl:with-param name="search-root" select="$context-elm"/>
          <xsl:with-param name="parent-id-suffix" select="'.6.21'"/>
          <xsl:with-param name="child-id-suffixes" select="('.6.80604', '.6.80605')"/>
          <xsl:with-param name="separator" select="'P: '"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="process-nested-data">
          <xsl:with-param name="search-root" select="$context-elm"/>
          <xsl:with-param name="parent-id-suffix" select="'.6.21'"/>
          <xsl:with-param name="child-id-suffixes" select="'.6.80606'"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="process-nested-data">
          <xsl:with-param name="search-root" select="$context-elm"/>
          <xsl:with-param name="parent-id-suffix" select="'.6.21'"/>
          <xsl:with-param name="child-id-suffixes" select="'.6.80607'"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="process-nested-data">
          <xsl:with-param name="search-root" select="$context-elm"/>
          <xsl:with-param name="parent-id-suffix" select="'.6.21'"/>
          <xsl:with-param name="child-id-suffixes" select="'.6.80608'"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-laboratoriumuitslagen">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'LABORATORIUM UITSLAGEN'"/>
      <xsl:with-param name="color" select="'lightblue'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="12%">Bloedgroep vrouw</th>
            <th width="12%">Rhesus c Factor</th>
            <th width="12%">Rhesus D Factor vrouw</th>
            <th width="12%">Rhesus D Factor foetus</th>
            <th width="12%">Hb</th>
            <th width="12%">Irregulaire antistoffen</th>
            <th width="12%">Afwijkende infectieparameters HBsAg?</th>
            <th>MRSA besmetting aangetoond?</th>
          </tr>
          <tr>
            <td>{local:get-value-by-id('.6.10810')}</td>
            <td>{local:get-value-by-id('.6.10816')}</td>
            <td>{local:get-value-by-id('.6.10811')}</td>
            <td>{local:get-value-by-id('.6.40051')}</td>
            <td>{local:get-value-by-id('.6.10814')}</td>
            <td>
              <xsl:call-template name="process-multi-values">
                <xsl:with-param name="id-suffix" select="'.6.10813'"/>
              </xsl:call-template>
            </td>
            <td>{local:get-value-by-id('.6.10817')}</td>
            <td>{local:get-value-by-id('.6.10804')}</td>
          </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-huidige-zwangerschap">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'HUIDIGE ZWANGERSCHAP'"/>
      <xsl:with-param name="color" select="'limegreen'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="25%">Identificatie van de zwangerschap</th>
            <th width="25%">Aantal levende kinderen</th>
            <th width="25%">Einde zwangerschap</th>
            <th>Bevalplan</th>
          </tr>
          <tr>
            <td>{local:get-value-by-id('.6.80627')}</td>
            <td>{local:get-value-by-id('.6.80617')}</td>
            <td>{local:get-value-by-id('.6.80625')}</td>
            <td>Zie meegeleverd bevalplan</td>
          </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-partus">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'PARTUS'"/>
      <xsl:with-param name="color" select="'gold'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="14%">Wijze waarop de baring begon</th>
            <th width="14%">Tijdstip begin actieve ontsluiting</th>
            <th width="14%">Kleur vruchtwater</th>
            <th width="14%">Medicatie nageboortetijdperk</th>
            <th width="14%">Geboorte placenta</th>
            <th width="14%">Placenta Compleet</th>
            <th>Conditie perineum postpartum</th>
          </tr>
          <tr>
            <td>{local:get-checked-value-by-id-or-nvt('.6.20550')}</td>
            <td>{local:get-checked-value-by-id-or-nvt('.6.20590')}</td>
            <td>{local:get-checked-value-by-id-or-nvt('.6.20610')}</td>
            <td>
              <xsl:call-template name="process-multi-values">
                <xsl:with-param name="id-suffix" select="'.6.20626'"/>
                <xsl:with-param name="default" select="$nvt"/>
              </xsl:call-template>
            </td>
            <td>{local:get-checked-value-by-id-or-nvt('.6.20630')}</td>
            <td>{local:get-checked-value-by-id-or-nvt('.6.20631')}</td>
            <td>{local:get-checked-value-by-id-or-nvt('.6.80673')}</td>
          </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-baring-per-kind">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'BARING PER KIND'"/>
      <xsl:with-param name="color" select="'orange'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>

          <xsl:variable name="elms" as="element()*" select="local:find-elms-by-id('.6.7')"/>
          <xsl:choose>
            <xsl:when test="exists($elms)">
              <xsl:for-each select="$elms">
                <xsl:call-template name="do-baring-per-kind-header-1"/>
                <xsl:call-template name="do-baring-per-kind-row-1">
                  <xsl:with-param name="context-elm" select="."/>
                </xsl:call-template>
                <xsl:call-template name="do-baring-per-kind-header-2"/>
                <xsl:call-template name="do-baring-per-kind-row-2">
                  <xsl:with-param name="context-elm" select="."/>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="do-baring-per-kind-header-1"/>
              <xsl:variable name="check" as="xs:string" select="local:check-id('.6.7')"/>
              <xsl:if test="contains($check, '?')">
                <tr>
                  <td>{$check}</td>
                </tr>
              </xsl:if>
              <xsl:call-template name="do-baring-per-kind-row-1">
                <xsl:with-param name="context-elm" select="()"/>
              </xsl:call-template>
              <xsl:call-template name="do-baring-per-kind-header-2"/>
              <xsl:call-template name="do-baring-per-kind-row-2">
                <xsl:with-param name="context-elm" select="()"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </table>

      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-baring-per-kind-row-1">
    <xsl:param name="context-elm" as="element()?" required="yes"/>

    <tr>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.80619')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.30030')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.80626')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40140')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40071')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40080')}</td>
      <td>
        <xsl:call-template name="process-double-value">
          <xsl:with-param name="context-elm" select="$context-elm"/>
          <xsl:with-param name="id-suffix-1" select="'.6.40280'"/>
          <xsl:with-param name="id-suffix-2" select="'.6.40290'"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-baring-per-kind-row-2">
    <xsl:param name="context-elm" as="element()?" required="yes"/>

    <tr>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40010')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40011')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40041')}</td>
      <td>{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40050')}</td>
      <td>
        <xsl:call-template name="process-double-value">
          <xsl:with-param name="context-elm" select="$context-elm"/>
          <xsl:with-param name="id-suffix-1" select="'.6.40060'"/>
          <xsl:with-param name="id-suffix-2" select="'.6.80670'"/>
          <xsl:with-param name="separator" select="' P: '"/>
        </xsl:call-template>
      </td>
      <td colspan="2">{local:get-checked-value-by-id-or-nvt($context-elm, '.6.40240')}</td>
    </tr>
  </xsl:template>
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-baring-per-kind-header-1">
    <tr>
      <th width="14%">Tijdstip breken vliezen</th>
      <th width="14%">Tijdstip actief meepersen</th>
      <th width="14%">Type partus</th>
      <th width="14%">Ligging bij geboorte</th>
      <th width="14%">Apgarscore na 5 min.</th>
      <th width="14%">Congenitale afwijkingen?</th>
      <th>Fase perinatale sterfte</th>
    </tr>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-baring-per-kind-header-2">
    <tr>
      <th width="14%">BSN kind</th>
      <th width="14%">Lokale identificatie kind</th>
      <th width="14%">Geslacht</th>
      <th width="14%">Geboortedatum</th>
      <th width="14%">Geboortegewicht</th>
      <th colspan="2">Overige interventies</th>
    </tr>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-onderzoek-moeder">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'ONDERZOEK MOEDER'"/>
      <xsl:with-param name="color" select="'lightblue'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>

          <xsl:variable name="elms" as="element()*" select="local:find-elms-by-id('.6.1421')"/>
          <xsl:choose>
            <xsl:when test="exists($elms)">
              <xsl:for-each select="$elms">
                <xsl:call-template name="do-onderzoek-moeder-header"/>
                <xsl:call-template name="do-onderzoek-moeder-row">
                  <xsl:with-param name="context-elm" select="."/>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="do-onderzoek-moeder-header"/>
              <xsl:variable name="check" as="xs:string" select="local:check-id('.6.1421')"/>
              <xsl:if test="contains($check, '?')">
                <tr>
                  <td>{$check}</td>
                </tr>
              </xsl:if>
              <xsl:call-template name="do-onderzoek-moeder-row">
                <xsl:with-param name="context-elm" select="$full-data-document/*"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </table>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-onderzoek-moeder-header">
    <tr>
      <th width="12%">Datum onderzoek</th>
      <th width="12%">Zwangerschapsduur</th>
      <th width="12%">Portio</th>
      <th width="12%">Ontsluiting</th>
      <th width="12%">Vliezen</th>
      <th width="12%">Indaling Hodge</th>
      <th width="12%">Aard v.h. voorliggend deel</th>
      <th>Stand</th>
    </tr>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="do-onderzoek-moeder-row">
    <xsl:param name="context-elm" as="element()" required="yes"/>

    <tr>
      <td>{local:get-value-by-id($context-elm, '.6.50020')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.50021')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.20612')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.20613')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.20614')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.20615')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.80616')}</td>
      <td>{local:get-value-by-id($context-elm, '.6.80618')}</td>
    </tr>
  </xsl:template>

  <!-- ================================================================== -->

  <xsl:template name="do-section-ante-partum">

    <xsl:call-template name="create-section">
      <xsl:with-param name="title" select="'ANTE PARTUM ONDERZOEK FOETUS'"/>
      <xsl:with-param name="color" select="'lightblue'"/>
      <xsl:with-param name="tables" as="element(table)+">
        <table>
          <tr>
            <th width="12%">Datum onderzoek</th>
            <th width="12%">Zwangerschapsduur</th>
            <th width="12%">BPD</th>
            <th width="12%">HC</th>
            <th width="12%">AC</th>
            <th width="12%">FL</th>
            <th>Echoparameters BPD, HC, AC, FL</th>
          </tr>
          <tr>
            <td> {local:get-value-by-id('.6.50020')} </td>
            <td> {local:get-value-by-id('.6.50021')} </td>
            <td>
              <xsl:value-of select="local:value-with-perc(local:get-value-by-id('.6.60030'), local:get-value-by-id('.6.60031'))"/>
            </td>
            <td>
              <xsl:value-of select="local:value-with-perc(local:get-value-by-id('.6.60060'), local:get-value-by-id('.6.60061'))"/>
            </td>
            <td>
              <xsl:value-of select="local:value-with-perc(local:get-value-by-id('.6.60080'), local:get-value-by-id('.6.60081'))"/>
            </td>
            <td>
              <xsl:value-of select="local:value-with-perc(local:get-value-by-id('.6.60100'), local:get-value-by-id('.6.60101'))"/>
            </td>
            <td>Zie bijgeleverd verslag</td>
          </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- ================================================================== -->
  <!-- GENERIC SUPPORT: -->

  <xsl:function name="local:value-with-perc" as="text()*">
    <xsl:param name="value" as="xs:string"/>
    <xsl:param name="perc" as="xs:string"/>
    <xsl:if test="normalize-space($value) and ($value ne '&#160;')">
      <xsl:value-of select="$value"/>
    </xsl:if>
    <xsl:if test="normalize-space($perc) and ($perc ne '&#160;')">
      <xsl:text> P: </xsl:text>
      <xsl:value-of select="$perc"/>
      <xsl:text>%</xsl:text>
    </xsl:if>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:q" as="xs:string">
    <xsl:param name="in" as="xs:string"/>
    <xsl:sequence select="concat('&quot;', $in, '&quot;')"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:find-elms-by-id" as="element()*">
    <xsl:param name="search-root" as="element()"/>
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="$search-root//*[ends-with(@conceptId, $id-suffix)]"/>
  </xsl:function>
  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:find-elms-by-id" as="element()*">
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="local:find-elms-by-id($full-data-document/*, $id-suffix)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:find-elm-by-id" as="element()?">
    <xsl:param name="search-root" as="element()"/>
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="local:find-elms-by-id($search-root, $id-suffix)[1]"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:find-elm-by-id" as="element()?">
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="local:find-elm-by-id($full-data-document/*, $id-suffix)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-value" as="xs:string">
    <xsl:param name="elm" as="element()?"/>
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:param name="default" as="xs:string?"/>
    <xsl:choose>
      <xsl:when test="exists($elm)">
        <xsl:variable name="value-raw" as="xs:string" select="($elm/@displayName, $elm/@value, '?')[1]"/>
        <xsl:sequence select="local:massage-value($value-raw)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="string-join(($default, local:check-id($id-suffix)), ' ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-value-by-id" as="xs:string">
    <xsl:param name="search-root" as="element()"/>
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:param name="default" as="xs:string?"/>
    <xsl:variable name="elm" as="element()?" select="local:find-elm-by-id($search-root, $id-suffix)"/>
    <xsl:sequence select="local:get-value($elm, $id-suffix, $default)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-value-by-id" as="xs:string">
    <xsl:param name="search-root" as="element()"/>
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="local:get-value-by-id($search-root, $id-suffix, ())"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-value-by-id" as="xs:string">
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="local:get-value-by-id($full-data-document/*, $id-suffix)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-checked-value-by-id-or-nvt" as="xs:string">
    <xsl:param name="context-elm" as="element()?"/>
    <xsl:param name="id-suffix" as="xs:string"/>

    <xsl:variable name="check" as="xs:string" select="local:check-id($id-suffix)"/>
    <xsl:choose>
      <xsl:when test="contains($check, '?')">
        <xsl:sequence select="$check"/>
      </xsl:when>
      <xsl:when test="empty($context-elm)">
        <xsl:sequence select="$nvt"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="local:get-value-by-id($context-elm, $id-suffix, $nvt)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:get-checked-value-by-id-or-nvt" as="xs:string">
    <xsl:param name="id-suffix" as="xs:string"/>
    <xsl:sequence select="local:get-checked-value-by-id-or-nvt($full-data-document/*, $id-suffix)"/>
  </xsl:function>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="process-nested-data">
    <xsl:param name="search-root" as="element()" required="no" select="$full-data-document/*"/>
    <xsl:param name="parent-id-suffix" as="xs:string" required="yes"/>
    <xsl:param name="child-id-suffixes" as="xs:string+" required="yes"/>
    <xsl:param name="separator" as="xs:string" required="no" select="' / '"/>
    <xsl:param name="default" as="xs:string?" required="no" select="()"/>

    <xsl:variable name="parent-elms" as="element()*" select="local:find-elms-by-id($search-root, $parent-id-suffix)"/>
    <xsl:choose>
      <xsl:when test="exists($parent-elms)">
        <xsl:for-each select="local:find-elms-by-id($search-root, $parent-id-suffix)">
          <xsl:variable name="parent-elm" as="element()" select="."/>
          <xsl:value-of select="string-join($child-id-suffixes ! local:get-value-by-id($parent-elm, .), $separator)"/>
          <xsl:if test="position() ne last()">
            <br/>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string-join(($default, local:check-id($parent-id-suffix), $child-id-suffixes ! local:check-id(.)), ' ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="process-multi-values">
    <xsl:param name="search-root" as="element()" required="no" select="$full-data-document/*"/>
    <xsl:param name="id-suffix" as="xs:string" required="yes"/>
    <xsl:param name="default" as="xs:string?" required="no" select="()"/>

    <xsl:variable name="elms" as="element()*" select="local:find-elms-by-id($id-suffix)"/>
    <xsl:choose>
      <xsl:when test="exists($elms)">
        <xsl:for-each select="$elms">
          <xsl:value-of select="local:get-value(., '.6.10611', ())"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string-join(($default, local:check-id($id-suffix)), ' ')"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="process-double-value">
    <xsl:param name="context-elm" as="element()?" required="no" select="()"/>
    <xsl:param name="id-suffix-1" as="xs:string" required="yes"/>
    <xsl:param name="id-suffix-2" as="xs:string" required="yes"/>
    <xsl:param name="separator" as="xs:string" required="no" select="' '"/>

    <!-- Make sure to show only a single nvt but do check the second id! -->

    <xsl:variable name="v1" as="xs:string" select="local:get-checked-value-by-id-or-nvt($context-elm, $id-suffix-1)"/>
    <xsl:value-of select="$v1"/>
    <xsl:choose>
      <xsl:when test="$v1 eq $nvt">
        <xsl:value-of select="local:check-id($id-suffix-2)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$separator"/>
        <xsl:value-of select="local:get-value-by-id(if (empty($context-elm)) then $full-data-document/* else $context-elm, $id-suffix-2)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

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

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:template name="create-section">
    <xsl:param name="title" as="xs:string" required="yes"/>
    <xsl:param name="color" as="xs:string" required="yes"/>
    <xsl:param name="tables" as="element(table)+" required="yes"/>

    <div class="top-level-section">
      <h1 class="section-title" style="background-color: {$color};">{ $title }</h1>
      <xsl:for-each select="$tables">
        <table class="table-view">
          <xsl:sequence select="*"/>
        </table>
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

  <xsl:function name="local:check-id" as="xs:string">
    <xsl:param name="id-suffix" as="xs:string"/>

    <xsl:variable name="specification-element" as="element(concept)?"
      select="$specification-root//concept[empty(parent::conceptList)][ends-with(@id, $id-suffix)]"/>
    <xsl:choose>
      <xsl:when test="exists($specification-element)">
        <xsl:sequence select="'&#160;'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="'?' || $id-suffix || '?'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>
