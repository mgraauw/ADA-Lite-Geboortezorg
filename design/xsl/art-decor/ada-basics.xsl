<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Copyright © ART-DECOR Expert Group and ART-DECOR Open Tools
    see https://art-decor.org/mediawiki/index.php?title=Copyright
    
    This program is free software; you can redistribute it and/or modify it under the terms 
    of the GNU Affero General Public Licenseas published by the Free Software Foundation; 
    either version 3 of the License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
    See the GNU Affero General Public Licensefor more details.
    
    See http://www.gnu.org/licenses/
-->
<xsl:stylesheet xmlns:ada="http://www.art-decor.org/ada"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    <!-- The project prefix, as defined in the ADA XML definition file. -->
    <xsl:variable name="prefix" select="/ada/project/@prefix/string()"/>
    <!-- The URI from where to retrieve transactions, as defined in the ADA XML definition file. -->
    <xsl:variable name="releaseBaseUri" select="/ada/project/release/@baseUri/string()"/>
    <!-- The location in eXist of this project -->
    <xsl:variable name="existInternalBaseUri" select="'/db/apps/'"/>
    <!-- The local folder where the project is stored (one up from definition folder) -->
    <xsl:variable name="projectDiskRoot" select="resolve-uri('..', base-uri())"/>
    <!-- The name of this app -->
    <xsl:variable name="projectName" select="tokenize($projectDiskRoot, '/')[last()-1]"/>
    <!-- The URI for this project, starting from ada-data -->
    <xsl:variable name="projectUri" select="concat('ada-data/projects/', $projectName, '/')"/>
    <!-- The project language, as defined in the ADA XML definition file. -->
    <xsl:variable name="language" select="/ada/project/@language/string()"/>
    <!-- The project versionDate, as defined in the ADA XML definition file. -->
    <xsl:variable name="versionDate" select="/ada/project/@versionDate/string()"/>
    <!-- Special element in schema to support extensability -->
    <xsl:variable name="extensionElementName">adaextension</xsl:variable>
    
    <xsl:variable name="theMESSAGES" select="document('ada-i18n.xml')"/>
    <xsl:function name="ada:getMessage">
        <xsl:param name="key"/>
        <xsl:value-of select="$theMESSAGES//entry[@key = $key]/text[@language = $language]/text()"/>
    </xsl:function>
    
    <xsl:function name="ada:isRequired" as="xs:boolean">
        <xsl:param name="concept" as="element(concept)"/>
        <xsl:variable name="isMandatory" select="ada:isMandatory($concept)" as="xs:boolean"/>
        <xsl:value-of select="($concept/@minimumMultiplicity > 0 or $concept/@conformance = ('R', 'C')) and not($isMandatory)"/>
    </xsl:function>
    <xsl:function name="ada:isMandatory" as="xs:boolean">
        <xsl:param name="concept" as="element(concept)"/>
        <xsl:value-of select="$concept/@conformance = 'M' or $concept/@isMandatory = 'true'"/>
    </xsl:function>
</xsl:stylesheet>