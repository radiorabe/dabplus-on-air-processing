DAB+ On Air Processing
======================

On Air Processing for sending a processed and encoded stream to an
[opendigitalradio](https://github.com/Opendigitalradio) broadcast
service provider.

This uses simple internet radio processing technology to prepare
our DAB+ stream letting us save the cost of buying a gold standard
omnia DAB+ preprocessor.

It is written in liquidsoap and integrates process from
[mkpascal](https://github.com/mkpascal/mk_liquidsoap_processing) with
the [fdk-aac-dabplus-odr codec](https://github.com/Opendigitalradio/fdk-aac-dabplus).
Parts of the processing chain are inspired by [conduit](https://github.com/JamesHarrison/conduit).

Requirements
------------

A working install of the [RaBe Liquidsoap distribution](http://build.opensuse.org/project/show/home:radiorabe:liquidsoap)
or any other liquidsoap install. The examples below depend on the systemd configuration from the RaBe dist.

Usage
-----

Enable and start the processor.

```bash
systemctl enable liquidsoap@rabe-dabplus-processor
systemctl start liquidsoap@rabe-dabplus-processor
```

Development
-----------

This repository contains the main processing script as well as the tooling needed to package it on the openbuild service.
