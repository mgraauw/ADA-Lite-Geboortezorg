<?xml version="1.0" encoding="UTF-8"?>
<!-- Voorbewerking Orfeus -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes" />
    
    <!-- Toevoegen dossiernummer -->
    <xsl:template match="concept[@shortName='zwangerschap']">
        <concept>
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="(* except concept)"/>
            <concept minimumMultiplicity="0" maximumMultiplicity="1" conformance="R" isMandatory="false" id="2.16.840.1.113883.2.4.3.11.999.60.5.6.3.1" statusCode="draft" effectiveDate="2019-01-28T00:00:00" type="item" shortName="dossiernummer">
                <name language="nl-NL">Dossiernummer</name>
                <desc language="nl-NL">Dossiernummer van de betreffende zwangerschap bij deze zorgaanbieder.</desc>
                <implementation shortName="dossiernummer"/>
                <valueDomain type="identifier"/>
            </concept>
            <xsl:apply-templates select="concept"/>
        </concept>
    </xsl:template>

    <!-- Rest kopieren -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>