<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes" />
    
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