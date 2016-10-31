
%define _gh_mk_lp_name mk_liquidsoap_processing
%define _gh_mk_lp_ref 59d14f2e07aadcc35cece0729c6d8b9d1955145c
# liquidsoap version
%define _ls_version 1.2.1

Name:     dabplus-on-air-processing

Requires: liquidsoap
Requires: odr-audioenc
Requires: odr-padenc
Requires: %{_gh_mk_lp_name}

Version:  0.4.0
Release:  1
Summary:  Liquidsoap based DAB+ on air processing solution
License:  GPLv3+
URL:      https://github.com/radiorabe/dabplus-on-air-processing
Source0:  https://github.com/radiorabe/dabplus-on-air-processing/archive/v%{version}.tar.gz#/%{name}-v%{version}.tar.gz
Source1:  https://github.com/mkpascal/%{_gh_mk_lp_name}/archive/%{_gh_mk_lp_ref}.tar.gz#/%{_gh_mk_lp_name}-%{_gh_mk_lp_ref}.tar.gz

%description
DAB+ on air processing is the precessing chain we use to prepare and encode the
broadcast signal for Radio Bern RaBe.

%package -n %{_gh_mk_lp_name}
Summary:  Broadcast Audio Processing Settings in Liquidsoap
Requires: liquidsoap
Requires: ladspa-tap-plugins
Requires: ladspa-swh-plugins

%description -n %{_gh_mk_lp_name}
Multiband compression chain for liquidsoap. Packaged as part of %{name}.

%prep
%setup0
%setup1 -T -D -a 1

%install
install -d %{buildroot}/etc/liquidsoap
install src/dabplus-on-air-processing.liq %{buildroot}/etc/liquidsoap/
install dabplus-on-air-processing.conf %{buildroot}/etc/liquidsoap/
install -d %{buildroot}%{_exec_prefix}/lib/liquidsoap/%{_ls_version}/
install %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}/process.liq %{buildroot}%{_exec_prefix}/lib/liquidsoap/%{_ls_version}/
install -d %{buildroot}%{_exec_prefix}/lib/systemd/system/
install *.service %{buildroot}%{_exec_prefix}/lib/systemd/system/

%files
%doc README.md
%config /etc/liquidsoap/dabplus-on-air-processing.liq
%config /etc/liquidsoap/dabplus-on-air-processing.conf

%files -n %{_gh_mk_lp_name}
%doc %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}/README.md
%doc %{_gh_mk_lp_name}-%{_gh_mk_lp_ref}/LICENSE
%{_exec_prefix}/lib/liquidsoap/%{_ls_version}/process.liq
%attr(550, -, -) %{_exec_prefix}/lib/systemd/system/*.service
