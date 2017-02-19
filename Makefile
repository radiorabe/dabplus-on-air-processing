#!/usr/bin/make -f
#
# This file is part of Radio RaBe DAB+ On-Air Processing
#
# Copyright (c) 2017 Radio Bern RaBe
#                    http://www.rabe.ch
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Please submit enhancements, bugfixes or comments via GitHub:
# https://github.com/radiorabe/dabplus-on-air-processing
#

PN        = dabplus-on-air-processing

PADENC_N  = odr-padenc@dabplus-on-air-processing

PREFIX   ?= /usr/local
BINDIR    = $(PREFIX)/bin
LIBDIR    = $(PREFIX)/lib
ETCDIR   ?= $(PREFIX)/etc
DOCDIR    = $(PREFIX)/share/doc/$(PN)
MAN1DIR   = $(PREFIX)/share/man/man1
UNITDIR   = $(LIBDIR)/systemd/system
DATADIR   = $(PREFIX)/share/$(PN)

all:

test:

clean:

install-bin:

install-sysconf:
	@echo installing configuration files...
	install -Dm755 -d $(ETCDIR)/liquidsoap/
	install -Dm555 *.conf $(ETCDIR)/liquidsoap/
	@echo done.

install-man:

install-doc:

install-data:

install-unit:
	@echo installing systemd unit files...
	install -Dm755 -d $(UNITDIR)/$(PADENC_N).service.d
	install -Dm550 systemd/$(PADENC_N).service.d/* $(UNITDIR)/$(PADENC_N).service.d/
	@echo done.

# startable liquidsoap scripts belong in etc
install-liq:
	@echo installing liquidsoap files...
	install -Dm755 src/*.liq $(ETCDIR)/liquidsoap/
	@echo done.

install: all install-bin install-sysconf install-man install-doc install-data install-unit install-liq
