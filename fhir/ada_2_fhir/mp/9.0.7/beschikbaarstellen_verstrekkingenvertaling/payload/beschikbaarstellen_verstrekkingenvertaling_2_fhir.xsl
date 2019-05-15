<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright © Nictiz

This program is free software; you can redistribute it and/or modify it under the terms of the
GNU Lesser General Public License as published by the Free Software Foundation; either version
2.1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
-->
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:nf="http://www.nictiz.nl/functions" xmlns:f="http://hl7.org/fhir" xmlns:local="urn:fhir:stu3:functions" xmlns="http://hl7.org/fhir" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Nictiz</xd:p>
			<xd:p><xd:b>Purpose:</xd:b> This XSL was created to facilitate mapping from ADA MP9-transaction, to HL7 FHIR STU3 profiles.</xd:p>
			<xd:p>
				<xd:b>History:</xd:b>
				<xd:ul>
					<xd:li>2019-02-25 version 0.1 <xd:ul><xd:li>Initial version</xd:li></xd:ul></xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:output method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>
    <!-- import because we want to be able to override the param for macAddress for UUID generation
         and the param for referById -->
    <xsl:import href="../../../2_fhir_mp_include.xsl"/>
    <!-- pass an appropriate macAddress to ensure uniqueness of the UUID -->
    <!-- 28-F1-0E-48-1D-92 is the mac address of a Nictiz device and may not be used outside of Nictiz -->
    <xsl:param name="macAddress">28-F1-0E-48-1D-92</xsl:param>
    <xsl:param name="referById" as="xs:boolean" select="false()"/>
 	<xsl:variable name="commonEntries" as="element(f:entry)*">
	    <xsl:copy-of select="$patients/f:entry | $practitioners/f:entry | $organizations/f:entry | $practitionerRoles/f:entry | $products/f:entry | $locations/f:entry"/>
	</xsl:variable>

	<xd:doc>
		<xd:desc>Start conversion. Handle interaction specific stuff for "beschikbaarstellen verstrekkingenvertaling".</xd:desc>
	</xd:doc>
	<xsl:template match="/">
		<xsl:call-template name="verstrekkingenvertaling_90">
			<xsl:with-param name="mbh" select="//beschikbaarstellen_verstrekkingenvertaling/medicamenteuze_behandeling"/>
		</xsl:call-template>
	</xsl:template>
	<xd:doc>
		<xd:desc>Build a FHIR Bundle of type searchset.</xd:desc>
		<xd:param name="mbh">ada medicamenteuze behandeling</xd:param>
	</xd:doc>
	<xsl:template name="verstrekkingenvertaling_90">
		<xsl:param name="mbh" as="element()*"/>
		<xsl:processing-instruction name="xml-model">href="http://hl7.org/fhir/STU3/bundle.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
		<Bundle xsl:exclude-result-prefixes="#all" xmlns="http://hl7.org/fhir" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://hl7.org/fhir http://hl7.org/fhir/STU3/bundle.xsd">
			<type value="searchset"/>
			<xsl:variable name="entries" as="element(f:entry)*">
				<!-- common entries (patient, practitioners, organizations, practitionerroles, locations -->
				<xsl:copy-of select="$commonEntries"/>
			    <xsl:copy-of select="$bouwstenen-verstrekkingenvertaling"/>
			</xsl:variable>
			<total value="{count($entries)}"/>
			<xsl:copy-of select="$entries"/>			
		</Bundle>
	</xsl:template>

</xsl:stylesheet>
