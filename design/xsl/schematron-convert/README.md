# Schematron SVRL XSL Generator

The files in this directory are the Schematron to SVRL-XSL generator. 

- This generator takes a Schematron file and converst it into an XSLT stylesheet. 
- This generated stylesheet can then be used to validate a document against the rules in the original Schematron file. 
- The output of the generated stylesheet will be SVRL (Schematron Validation Report Language). 
- SVRL is an XML dialect Schematron uses to report its validation messages. Its not meant for direct human consumption but can be easily used to create a report in, for instance, HTML. 

Source is the GitHub skeleton Schematron repo: 
[https://github.com/Schematron/schematron.git](https://github.com/Schematron/schematron.git)

See the `readme.txt` in this directory for more information on how it must be used.
