<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <valueSet>
            <xsl:apply-templates/>
        </valueSet>
    </xsl:template>

    <xsl:template match="*[@codeSystem]">
        <concept>
            <xsl:copy-of select="@code, @codeSystem, @displayName"/>
            <xsl:copy-of select="*"/>
        </concept>
    </xsl:template>
    
    <xsl:template match="node()">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="@*"/>
    
</xsl:stylesheet>