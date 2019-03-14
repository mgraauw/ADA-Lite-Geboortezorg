# ada-lite branch generator

The `ada-lite` branch of this repository contains the defintions and other helpful materials for the developers of ADA-Lite-Geboortezorg applications. It is *generated* completely by the software in the `design` branch. This `generator` sub-directory contains the generator software that does this.

The generator itself is an [XProc 1.0](https://www.w3.org/TR/xproc/) pipeline, running on the [Calabash](https://xmlcalabash.com/) processing engine. It will not run on any other engine since it uses Calabash extensions.

The easest way to run this generator is from inside [oXygen](https://www.oxygenxml.com/), using an XProc transformation scenario.

It has no inputs or options. Just run it. The output is an XML file that reports what it did.

make sure to look at the last bits in which it uses the generated XML Schemas and Schematrons to validate all the ADA documents in the `ada-lite` branch. There must be no validation error messages there!  