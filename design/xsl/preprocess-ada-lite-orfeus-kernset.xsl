<?xml version="1.0" encoding="UTF-8"?>
<!-- Voorbewerking Orfeus -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes" />
    
    <!-- Hernoemen naar juiste root node -->
<!--    <xsl:template match="/">
        <kernset_geboortezorg>
            <xsl:apply-templates select="*/*"/>
        </kernset_geboortezorg>
    </xsl:template>-->
    
    <!-- Items zonder @value weggooien -->
    <xsl:template match="*[@value][string-length(@value/string())=0]"/>

    <!-- Groepen zonder children met niet-lege @value weggooien -->
    <xsl:template match="*[not(@value)][not(descendant::*[@value][string-length(@value/string()) > 0])]"/>

    <!-- Rest kopieren -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>