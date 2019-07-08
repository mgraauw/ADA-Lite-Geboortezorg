<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- XSL implementation of art-decor.xqm function -->
    <!-- 2019-07-08 AH - Add proper alternatives for &lt;=? smaller(equal) and >=? greater(equal) -->
    <!--
        declare function art:shortName($name as xs:string?) as xs:string? {
            let $shortname := 
                if ($name) then (
                    (: add some readability to CamelCased names. E.g. MedicationStatement to Medication_Statement. :)
                    let $r0 := replace($name, '([a-z])([A-Z])', '$1_$2')
                    
                    (: find matching alternatives for <=? smaller(equal) and >=? greater(equal) :)
                    let $r1 := replace($r0, '<\s*=', 'le')
                    let $r2 := replace($r1, '<', 'lt')
                    let $r3 := replace($r2, '>\s*=', 'ge')
                    let $r4 := replace($r3, '>', 'gt')
                    
                    (: find matching alternatives for more or less common diacriticals, replace single spaces with _ , replace ? with q (same name occurs quite often twice, with and without '?') :)
                    let $r5 := translate(normalize-space(lower-case($r4)),' àáãäåèéêëìíîïòóôõöùúûüýÿç€ßñ?','_aaaaaeeeeiiiiooooouuuuyycEsnq')
                    (: ditch anything that's not alpha numerical or underscore :)
                    let $r6 := replace($r5,'[^a-zA-Z\d_]','')
                    (: make sure we do not start with a digit :)
                    let $r7 := replace($r6, '^(\d)' , '_$1')
                    return $r7
                ) else ()
            
            return if (matches($shortname, '^[a-zA-Z_][a-zA-Z\d_]+$')) then $shortname else ()
        };
    -->
    
    <xsl:template name="shortName">
        <xsl:param name="name"/>
        <!-- add some readability to CamelCased names. E.g. MedicationStatement to Medication_Statement. -->
        <xsl:variable name="r0" select="replace($name, '([a-z])([A-Z])', '$1_$2')"/>
        
        <!-- find matching alternatives for &lt;=? smaller(equal) and >=? greater(equal) -->
        <xsl:variable name="r1" select="replace($r0, '&lt;\s*=', 'le')"/>
        <xsl:variable name="r2" select="replace($r1, '&lt;', 'lt')"/>
        <xsl:variable name="r3" select="replace($r2, '&gt;\s*=', 'ge')"/>
        <xsl:variable name="r4" select="replace($r3, '&gt;', 'gt')"/>
        
        <!-- find matching alternatives for more or less common diacriticals, replace single spaces with _ , replace ? with q (same name occurs quite often twice, with and without '?') -->
        <xsl:variable name="r5" select="translate(normalize-space(lower-case($r4)),' àáãäåèéêëìíîïòóôõöùúûüýÿç€ßñ?','_aaaaaeeeeiiiiooooouuuuyycEsnq')"/>
        <!-- ditch anything that's not alpha numerical or underscore -->
        <xsl:variable name="r6" select="replace($r5,'[^a-zA-Z\d_]','')"/>
        <!-- make sure we do not start with a digit -->
        <xsl:variable name="r7" select="replace($r6, '^(\d)' , '_$1')"/>
        
        <xsl:value-of select="if (matches($r7, '^[a-zA-Z_][a-zA-Z\d_]+$')) then $r7 else ()"/>
    </xsl:template>
    
</xsl:stylesheet>