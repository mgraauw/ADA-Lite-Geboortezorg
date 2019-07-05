<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Author: Marc de Graauw 
    
    Helper stylesheet to generate ADA Lite examples from ADA full
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="example" select="doc('../../ada-lite/examples-empty/samenvatting-voorgaande-zwangerschap-23.xml')/*"/>

    <xsl:template match="/">
        <xsl:apply-templates select=".//data"/>
    </xsl:template>

    <xsl:template match="data">
        <xsl:element name="{$example/local-name()}">
            <xsl:attribute name="transactionRef" select="$example/@transactionRef" />
            <xsl:if test="$example/@versionDate">
                <xsl:attribute name="versionDate" select="$example/@versionDate"/>
            </xsl:if>
            <xsl:apply-templates select="*/*">
                <xsl:with-param name="examplepart" select="$example/*"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="node()">
        <xsl:param name="examplepart"/>
        <xsl:variable name="name" select="local-name()"/>
        <xsl:if test="$name = $examplepart/local-name()">
            <xsl:element name="{$name}">
                <xsl:choose>
                    <xsl:when test="@code">
                        <xsl:attribute name="value" select="@code"/>
                    </xsl:when>
                    <xsl:when test="@extension">
                        <xsl:attribute name="value" select="@extension"/>
                    </xsl:when>
                    <xsl:when test="@value">
                        <xsl:attribute name="value" select="@value"/>
                    </xsl:when>
                    <xsl:when test="@root">
                        <xsl:attribute name="value" select="@root"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:copy-of select="(@displayName, @unit)"/>
                <xsl:apply-templates select="*">
                    <xsl:with-param name="examplepart" select="$examplepart[local-name()=$name]/*"/>
                </xsl:apply-templates>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="@*"/>
    
</xsl:stylesheet>