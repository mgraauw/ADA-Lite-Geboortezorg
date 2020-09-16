<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:local="#local"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        queryBinding="xslt2"
        xml:lang="nl-NL">
<!--
MIT License

Copyright (c) 2019 Marc de Graauw and Erik Siegel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
   <pattern>
       <rule context="/kernset_geboortezorg/uitkomst_per_kind/baring/demografische_gegevens/perinatale_sterfte_groep">
           <assert test="not(fase_perinatale_sterfte/@value and not(perinatale_sterfteq/@value='true'))">Fase perinatale sterfte alleen opnemen wanneer er perinatale sterfte 'ja' is.</assert>
           <assert test="not(datumtijd_vaststelling_perinatale_sterfte/@value and not(perinatale_sterfteq/@value='true'))">Datum perinatale sterfte alleen opnemen wanneer er perinatale sterfte 'ja' is.</assert>
       </rule>
       <rule context="/kernset_geboortezorg/uitkomst_per_kind/baring/kindspecifieke_uitkomstgegevens">
           <assert test="not(.//specificatie_congenitale_afwijking/@value and not(congenitale_afwijkingenq/@value='true'))">Alleen een waarde voor congenitale afwijking opnemen als congenitale afwijking 'ja is.</assert>
           <assert test="not(not(.//specificatie_congenitale_afwijking/@value) and congenitale_afwijkingenq/@value='true')">Als er sprake is van congenitale afwijkingen, ook een waarde voor de congenitale óf chromosomale afwijking opnemen.</assert>
           <assert test="not(.//chromosomale_afwijkingenq/@value='true' and not(congenitale_afwijkingenq/@value='true'))">Chromosomale afwijking(en) zijn alleen van toepassing wanneer er sprake is van congenitale afwijkingen.</assert>
           <assert test="not(.//chromosomale_afwijkingenq/@value='true' and not(.//specificatie_chromosomale_afwijking/@value))">Als er sprake is van Chromosomale afwijkingen, ook een waarde opnemen.</assert>
           <assert test="not(not(.//chromosomale_afwijkingenq/@value='true') and .//specificatie_chromosomale_afwijking/@value)">Alleen een waarde voor chromosomale afwijking opnemen als er ook sprake is van een chromosomale afwijking.</assert>
           <assert test="not(type_partus/@value!='3311000146109' and .//succes_vaginale_kunstverlossingq/@value='true')">Alleen een succesvolle vaginale kunstverlossing opnemen als type partus = vaginale kunstverlossing.</assert>

           <assert test="1=1">If Vaginalekunstverlossing=true (negationInd=false) a Succesvaginalekunstverlossing shall be present</assert>
           
       </rule>
       <rule context="/">
          <assert test="1=1">If Episiotomie=true (negationInd=false) an hl7:targetSiteCode (Faseamniotomie) shall be present</assert>
          <assert test="1=1">If Episiotomie=false (negationInd=true) hl7:targetSiteCode (Faseamniotomie) shall not be present</assert>
          <assert test="1=1">Beslismoment sectio alleen van toepassing wanneer type partus een secundaire sectio is.</assert>
          <assert test="1=1">Wanneer er geen informatie over de indicatie sectio is (de observation heeft een @nullFlavor) kan er ook geen waarde voor indicatie opgenomen worden (de observation/value heeft een @code).</assert>
          <assert test="1=1">Wanneer er geen informatie over het beslismoment van de sectio is (de observation heeft een @nullFlavor) kan er ook geen waarde voor beslismoment opgenomen worden (de observation/value heeft een @code).</assert>
          <assert test="1=1">Wanneer er geen informatie over de indicatie sectio is (de observation heeft een @nullFlavor) kan er ook geen waarde voor indicatie opgenomen worden (de observation/value heeft een @code).</assert>
          <assert test="1=1">Als er sprake is van pijnbestrijding (negationInd=false) dan de methode (hl7:methodCode) ook opnemen.</assert>
          <assert test="1=1">Als er sprake is Medicatie nageboortetijdperk = true, ook een waarde voor die medicatie opnemen.</assert>
          <assert test="1=1">Als er meer dan één observatie is over pathologie vrouw, moet er ook sprake zijn van pathologie bij die vrouw (negationInd moet dan in alle gevallen false zijn). </assert>
          <assert test="1=1">Indien er géén irregulaire antistoffen aanwezig zijn (negationInd=true), mag er maar één component voor irregulaire antistoffen in het bericht voorkomen.</assert>
          <assert test="1=1">Indien er irregulaire antistoffen aanwezig zijn moet value een waarde bevatten of nullFlavor bevatten.</assert>
          <assert test="1=1">Indien er géén irregulaire antistoffen aanwezig zijn, value niet opnemen.</assert>
          <assert test="1=1">Transfusiereactie alleen opnemen wanneer er sprake is (geweest) van een Bloedtransfusie.</assert>
          <assert test="1=1">Als er meer dan één observatie is over pathologie vrouw, moet er ook sprake zijn van pathologie bij die vrouw (negationInd moet dan in alle gevallen false zijn). </assert>
          <assert test="1=1">Eerdere bevalling is alleen van toepassing wanneer wijze einde zwangerschap = partus.</assert>
          <assert test="1=1">Algemene anamnese alleen opnemen wanneer 'Onder behandeling (geweest)? is 'Ja'.</assert>
          <assert test="1=1">Transfusiereactie alleen opnemen wanneer er sprake is (geweest) van een Bloedtransfusie.</assert>
      </rule>
   </pattern>
</schema>
