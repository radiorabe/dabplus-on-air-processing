RaBe DAB+ On Air Processing
===========================

RaBe DAB+ On Air Processing processes and encodes an audio stream for later broadcasting at an
[opendigitalradio](https://github.com/Opendigitalradio) broadcast service provider.

This uses simple internet radio processing technology to prepare
our DAB+ stream letting us save the cost of buying a gold standard
Omnia DAB+ processor.

It is written in liquidsoap and integrates [mk_liquidsoap_process from
mkpascal](https://github.com/mkpascal/mk_liquidsoap_processing) with
the [fdk-aac-dabplus-odr codec](https://github.com/Opendigitalradio/fdk-aac-dabplus).
Parts of the processing chain are inspired by [conduit](https://github.com/JamesHarrison/conduit).

Requirements
------------

A working install of the [RaBe Liquidsoap distribution](http://build.opensuse.org/project/show/home:radiorabe:liquidsoap)
or any other liquidsoap install. The examples below depend on the systemd configuration from the RaBe dist.

Install
-------

RaBe DAB+ On Air Processing is packaged for CentOS7.

```bash
yum install -y epel-release
yum install -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
curl -o /etc/yum.repos.d/liquidsoap.repo \
  http://download.opensuse.org/repositories/home:/radiorabe:/liquidsoap/CentOS_7/home:radiorabe:liquidsoap.repo
curl -o /etc/yum.repos.d/dab.repo \
  http://download.opensuse.org/repositories/home:radiorabe:streambox/CentOS_7/home:radiorabe:dab.repo

yum install -y dabplus-on-air-processing
```

Usage
-----

Enable and start the processor.

```bash
systemctl enable liquidsoap@dabplus-on-air-processing
systemctl start liquidsoap@dabplus-on-air-processing
```

Development
-----------

This repository contains the main processing script as well as the
tooling needed to package it on the [openbuild service](https://build.opensuse.org/project/show/home:radiorabe:dab).
