<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:variable name="transaction" select="doc('../specs-full/prio1-vorig.xml')"/>
    <xsl:variable name="ids" select="$transaction//@shortName/string()"/>

    <xsl:template match="/">
        <transaction xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="../schemas/prio1_vorig.xsd"
            transactionRef="2.16.840.1.113883.2.4.3.11.60.90.77.4.2456">
            <xsl:apply-templates select="//data/*/*"></xsl:apply-templates>
        </transaction>
    </xsl:template>
    
    <xsl:template match="*[@conceptId]">
        <xsl:if test="local-name() = $ids">
            <xsl:variable name="name" select="local-name()"/>
            <xsl:element name="{$name}">
                <xsl:copy-of select="(@* except @conceptId)"></xsl:copy-of>
                <xsl:apply-templates></xsl:apply-templates>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="node()|@*"></xsl:template>

</xsl:stylesheet>