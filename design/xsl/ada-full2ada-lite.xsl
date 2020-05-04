<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/*">
        <xsl:copy>
            <xsl:copy-of select="@transactionRef | @transactionEffectiveDate | @versionDate | @prefix"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="@code">
                    <xsl:attribute name="value" select="@code"/>
                    <xsl:copy-of select="@displayName"/>
                </xsl:when>
                <xsl:when test="@value">
                    <xsl:copy-of select="@value"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>