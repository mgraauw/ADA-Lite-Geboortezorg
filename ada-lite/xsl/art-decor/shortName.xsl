<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--
        declare function art:shortName($name as xs:string?) as xs:string? {
            let $shortname := 
                if ($name) then (
                    (: add some readability to CamelCased names. E.g. MedicationStatement to Medication_Statement. :)
                    let $r0 := replace($name, '([a-z])([A-Z])', '$1_$2')
                    (: find matching alternatives for more or less common diacriticals, replace single spaces with _ , replace ? with q (same name occurs quite often twice, with and without '?') :)
                    let $r1 := translate(normalize-space(lower-case($r0)),' àáãäåèéêëìíîïòóôõöùúûüýÿç€ßñ?','_aaaaaeeeeiiiiooooouuuuyycEsnq')
                    (: ditch anything that's not alpha numerical or underscore :)
                    let $r2 := replace($r1,'[^a-zA-Z\d_]','')
                    (: make sure we do not start with a digit :)
                    let $r3 := if (matches($r2,'^\d')) then concat('_',$r2) else $r2
                    return $r3
                ) else ()
            
            return if (matches($shortname, '^[a-zA-Z_][a-zA-Z\d_]+$')) then $shortname else ()
        };
    -->
    
    <xsl:template name="shortName">
        <xsl:param name="name"/>
        <!-- add some readability to CamelCased names. E.g. MedicationStatement to Medication_Statement. -->
        <xsl:variable name="r0" select="replace($name, '([a-z])([A-Z])', '$1_$2')"/>
        <!-- find matching alternatives for more or less common diacriticals, replace single spaces with _ , replace ? with q (same name occurs quite often twice, with and without '?') -->
        <xsl:variable name="r1" select="translate(normalize-space(lower-case($r0)),' àáãäåèéêëìíîïòóôõöùúûüýÿç€ßñ?','_aaaaaeeeeiiiiooooouuuuyycEsnq')"/>
        <!-- ditch anything that's not alpha numerical or underscore -->
        <xsl:variable name="r2" select="replace($r1,'[^a-zA-Z\d_]','')"/>
        <!-- make sure we do not start with a digit -->
        <xsl:variable name="r3" select="if (matches($r2,'^\d')) then concat('_',$r2) else $r2"/>
        
        <xsl:value-of select="if (matches($r3, '^[a-zA-Z_][a-zA-Z\d_]+$')) then $r3 else ()"/>
    </xsl:template>

</xsl:stylesheet>